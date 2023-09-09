#!/bin/sh

base_dir=$(cd "$(dirname "$0")" && pwd)
ln -s "${base_dir}/.vimrc" "${HOME}/.vimrc"
ln -s "${base_dir}/.zshrc" "${HOME}/.zshrc"

dot_configs="${base_dir}/.config/*"
for conf in $dot_configs; do
  name=$(basename "${conf}")
  link_path="${HOME}/.config/${name}"

  if [ ! -e "${link_path}" ]; then
    ln -s "${base_dir}/.config/${name}" "${link_path}"
  fi
done
