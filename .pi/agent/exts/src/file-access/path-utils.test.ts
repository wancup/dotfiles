import assert from "node:assert/strict";
import { homedir } from "node:os";
import { describe, it } from "node:test";
import { expandPath, extractPathsFromCommand, isForbiddenFile, isOutsideCwd, normalizePath } from "./path-utils.ts";

describe("normalizePath", () => {
  it("@ プレフィックスを除去する", () => {
    assert.equal(normalizePath("@.pi/agent/index.ts"), ".pi/agent/index.ts");
  });

  it("@ が無いパスはそのまま返す", () => {
    assert.equal(normalizePath("./src/index.ts"), "./src/index.ts");
  });

  it("先頭以外の @ は除去しない", () => {
    assert.equal(normalizePath("src/@types/index.ts"), "src/@types/index.ts");
  });
});

describe("expandPath", () => {
  it("~ をホームディレクトリに展開する", () => {
    assert.equal(expandPath("~/Documents"), homedir() + "/Documents");
  });

  it("~ 単体をホームディレクトリに展開する", () => {
    assert.equal(expandPath("~"), homedir());
  });

  it("~ が含まれないパスはそのまま返す", () => {
    assert.equal(expandPath("/usr/local/bin"), "/usr/local/bin");
  });

  it("パス途中の ~ は展開しない", () => {
    assert.equal(expandPath("/tmp/~backup"), "/tmp/~backup");
  });
});

describe("isForbiddenFile", () => {
  it(".env を禁止する", () => {
    assert.equal(isForbiddenFile("/project/.env"), true);
  });

  it(".env.local を禁止する", () => {
    assert.equal(isForbiddenFile("/project/.env.local"), true);
  });

  it(".env.production を禁止する", () => {
    assert.equal(isForbiddenFile("/project/.env.production"), true);
  });

  it(".netrc を禁止する", () => {
    assert.equal(isForbiddenFile("/home/user/.netrc"), true);
  });

  it(".npmrc を禁止する", () => {
    assert.equal(isForbiddenFile("/home/user/.npmrc"), true);
  });

  it(".ssh 配下のファイルを禁止する", () => {
    assert.equal(isForbiddenFile("/home/user/.ssh/id_rsa"), true);
  });

  it("keys 配下のファイルを禁止する", () => {
    assert.equal(isForbiddenFile("/home/user/.keys/secret.pem"), true);
  });

  it("通常のファイルは許可する", () => {
    assert.equal(isForbiddenFile("/project/src/index.ts"), false);
  });

  it(".envrc は禁止しない", () => {
    assert.equal(isForbiddenFile("/project/.envrc"), false);
  });
});

describe("isOutsideCwd", () => {
  it("CWD 内のパスは false を返す", () => {
    assert.equal(isOutsideCwd("/project/src/index.ts", "/project"), false);
  });

  it("CWD 自体は false を返す", () => {
    assert.equal(isOutsideCwd("/project", "/project"), false);
  });

  it("CWD 外のパスは true を返す", () => {
    assert.equal(isOutsideCwd("/other/file.ts", "/project"), true);
  });

  it("CWD がスラッシュ付きでも正しく判定する", () => {
    assert.equal(isOutsideCwd("/project/src/index.ts", "/project/"), false);
  });

  it("プレフィックスが一致するだけの別ディレクトリは外部と判定する", () => {
    assert.equal(isOutsideCwd("/project-other/file.ts", "/project"), true);
  });
});

describe("extractPathsFromCommand", () => {
  it("相対パスを抽出する", () => {
    assert.deepEqual(extractPathsFromCommand("cat ./src/index.ts"), ["./src/index.ts"]);
  });

  it("絶対パスを抽出する", () => {
    assert.deepEqual(extractPathsFromCommand("cat /etc/hosts"), ["/etc/hosts"]);
  });

  it("~ パスを抽出する", () => {
    assert.deepEqual(extractPathsFromCommand("cat ~/.bashrc"), ["~/.bashrc"]);
  });

  it(".. を含むパスを抽出する", () => {
    assert.deepEqual(extractPathsFromCommand("cat foo/../bar.ts"), ["foo/../bar.ts"]);
  });

  it("パスでないトークンは除外する", () => {
    assert.deepEqual(extractPathsFromCommand("echo hello world"), []);
  });

  it("複数パスを抽出する", () => {
    assert.deepEqual(
      extractPathsFromCommand("cp ./a.ts /tmp/b.ts"),
      ["./a.ts", "/tmp/b.ts"],
    );
  });

  it("@ プレフィックス付きパスを正規化してから抽出する", () => {
    assert.deepEqual(
      extractPathsFromCommand("cat @.pi/agent/index.ts"),
      [".pi/agent/index.ts"],
    );
  });

  it("@ プレフィックス付きの絶対パスも抽出する", () => {
    assert.deepEqual(
      extractPathsFromCommand("cat @/etc/hosts"),
      ["/etc/hosts"],
    );
  });

  it("@ プレフィックス付きの ~ パスも抽出する", () => {
    assert.deepEqual(
      extractPathsFromCommand("cat @~/.bashrc"),
      ["~/.bashrc"],
    );
  });

  it("空コマンドでは空配列を返す", () => {
    assert.deepEqual(extractPathsFromCommand(""), []);
  });
});
