#!/bin/bash

_DOCKER_TYPST_PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

compile_typst() {
    if [ $# -eq 0 ]; then
        echo "Usage: compile_typst <path>"
        echo "Example: compile_typst .          (from inside a ws_typst subfolder)"
        echo "Example: compile_typst my_project (relative to ws_typst/)"
        return 1
    fi

    local target_path="$1"
    local abs_path
    local ws_typst_root="${_DOCKER_TYPST_PROJECT_ROOT}/ws_typst"

    if [[ -d "$target_path" ]]; then
        abs_path="$(cd "$target_path" && pwd)"
    elif [[ -d "${ws_typst_root}/${target_path}" ]]; then
        abs_path="${ws_typst_root}/${target_path}"
    else
        echo "Error: Directory '${target_path}' not found"
        return 1
    fi

    if [[ "$abs_path" != "${ws_typst_root}"/* ]]; then
        echo "Error: '${abs_path}' is not inside ws_typst/"
        echo "       Projects must be under: ${ws_typst_root}/"
        return 1
    fi

    local relative_path="${abs_path#${ws_typst_root}/}"

    "${_DOCKER_TYPST_PROJECT_ROOT}/scripts/compile.sh" "${relative_path}"
}
