local M = {}

local namespace = vim.api.nvim_create_namespace("package-outdated")
local dependency_fields = {
	dependencies = true,
	devDependencies = true,
	optionalDependencies = true,
	peerDependencies = true,
}
local supported_files = {
	["package.json"] = true,
	["pnpm-workspace.yaml"] = true,
}

---@param node TSNode?
---@param bufnr integer
---@return string?
local function decode_json_key(node, bufnr)
	if not node then
		return
	end

	local ok, key = pcall(vim.json.decode, vim.treesitter.get_node_text(node, bufnr))
	if ok and type(key) == "string" then
		return key
	end
end

---@param node TSNode?
---@param bufnr integer
---@return string?
local function decode_yaml_key(node, bufnr)
	if not node then
		return
	end

	local key = vim.trim(vim.treesitter.get_node_text(node, bufnr))
	if key:sub(1, 1) == '"' then
		local ok, decoded = pcall(vim.json.decode, key)
		if ok and type(decoded) == "string" then
			return decoded
		end
		return
	end
	if key:sub(1, 1) == "'" and key:sub(-1) == "'" then
		return (key:sub(2, -2):gsub("''", "'"))
	end
	return key
end

---@param node TSNode?
---@return TSNode?
local function unwrap_yaml_mapping(node)
	while node and node:type() ~= "block_mapping" do
		if node:named_child_count() ~= 1 then
			return
		end
		node = node:named_child(0)
	end
	return node
end

---@param bufnr integer
---@param row integer
---@param update table?
local function render_update(bufnr, row, update)
	if not update or type(update.latest) ~= "string" then
		return
	end

	vim.api.nvim_buf_set_extmark(bufnr, namespace, row, 0, {
		virt_text = { { "(⬆️ " .. update.latest .. ")", "DiagnosticVirtualTextHint" } },
		virt_text_pos = "eol",
	})
end

---@param bufnr integer
---@param outdated table<string, table>
local function render_package_json(bufnr, outdated)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "json")
	if not ok or not parser then
		return
	end

	local tree = parser:parse()[1]
	local document = tree and tree:root()
	local object = document and document:named_child(0)
	if not object or object:type() ~= "object" then
		return
	end

	for field in object:iter_children() do
		if field:type() == "pair" then
			local field_name = decode_json_key(field:named_child(0), bufnr)
			local dependencies = field:named_child(1)
			if dependency_fields[field_name] and dependencies and dependencies:type() == "object" then
				for dependency in dependencies:iter_children() do
					if dependency:type() == "pair" then
						local package_name = decode_json_key(dependency:named_child(0), bufnr)
						local row = dependency:range()
						render_update(bufnr, row, package_name and outdated[package_name])
					end
				end
			end
		end
	end
end

---@param bufnr integer
---@param outdated table<string, table>
local function render_workspace_catalog(bufnr, outdated)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "yaml")
	if not ok or not parser then
		return
	end

	local tree = parser:parse()[1]
	local root = tree and tree:root()
	local workspace = unwrap_yaml_mapping(root)
	if not workspace then
		return
	end

	for field in workspace:iter_children() do
		if field:type() == "block_mapping_pair" and decode_yaml_key(field:named_child(0), bufnr) == "catalog" then
			local catalog = unwrap_yaml_mapping(field:named_child(1))
			if not catalog then
				return
			end

			for dependency in catalog:iter_children() do
				if dependency:type() == "block_mapping_pair" then
					local package_name = decode_yaml_key(dependency:named_child(0), bufnr)
					local row = dependency:range()
					render_update(bufnr, row, package_name and outdated[package_name])
				end
			end
			return
		end
	end
end

---@param bufnr integer
---@param filename string
---@param outdated table<string, table>
local function render(bufnr, filename, outdated)
	vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
	if filename == "package.json" then
		render_package_json(bufnr, outdated)
	else
		render_workspace_catalog(bufnr, outdated)
	end
end

---@param result vim.SystemCompleted
local function notify_error(result)
	local message = vim.trim(result.stderr or "")
	if message == "" then
		message = vim.trim(result.stdout or "")
	end
	message = message:match("[^\r\n]+") or ("exit code " .. result.code)
	vim.notify("pnpm outdated failed: " .. message, vim.log.levels.WARN)
end

---@param bufnr integer
function M.check(bufnr)
	local manifest = vim.api.nvim_buf_get_name(bufnr)
	local filename = vim.fs.basename(manifest)
	if not supported_files[filename] then
		return
	end

	local command = { "pnpm", "outdated", "--format", "json", "--no-color" }
	if filename == "pnpm-workspace.yaml" then
		table.insert(command, 3, "--recursive")
	end

	vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
	vim.system(command, {
		cwd = vim.fs.dirname(manifest),
		text = true,
	}, function(result)
		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
				return
			end

			local stdout = vim.trim(result.stdout or "")
			if stdout == "" and result.code == 0 then
				return
			end

			local ok, outdated = pcall(vim.json.decode, stdout)
			if not ok or type(outdated) ~= "table" then
				notify_error(result)
				return
			end

			render(bufnr, filename, outdated)
		end)
	end)
end

return M
