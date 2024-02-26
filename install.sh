#!/bin/sh
set -o errexit -o nounset

base_dir=$(cd "$(dirname "$0")" && pwd)
top_file_list='.vimrc .zshrc'

for top_file in $top_file_list ; do
  top_link_path="${HOME}/${top_file}"
  if [ ! -e "${top_link_path}" ]; then
    ln -s "${base_dir}/${top_file}" "${top_link_path}"
  fi
done

dot_configs="${base_dir}/.config/*"
for conf in $dot_configs; do
  name=$(basename "${conf}")
  link_path="${HOME}/.config/${name}"

  if [ ! -e "${link_path}" ]; then
    ln -s "${base_dir}/.config/${name}" "${link_path}"
  fi
done
