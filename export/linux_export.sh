#!/bin/sh
echo -ne '\033c\033]0;ElemenTUM\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/linux_export.x86_64" "$@"
