#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'

readonly GITHUB_OWNER="RAMCloudCode"
readonly GITHUB_REPO="Z-Arch"
readonly INSTALL_DIR="${HOME}/.local/bin"
readonly INSTALL_PATH="${INSTALL_DIR}/zarch"

log() {
    printf '%s\n' "$*"
}

fail() {
    printf 'Z-Arch installer: %s\n' "$*" >&2
    exit 1
}

append_path_block() {
    local profile_path="$1"
    local marker="# Added by the Z-Arch installer"

    touch "${profile_path}"

    if grep -Fq "${marker}" "${profile_path}" 2>/dev/null; then
        return
    fi

    cat >>"${profile_path}" <<'EOF'

# Added by the Z-Arch installer
case ":${PATH}:" in
    *":${HOME}/.local/bin:"*) ;;
    *) export PATH="${HOME}/.local/bin:${PATH}" ;;
esac
EOF
}

configure_path() {
    case "${SHELL##*/}" in
        bash)
            append_path_block "${HOME}/.profile"
            append_path_block "${HOME}/.bashrc"
            ;;
        zsh)
            append_path_block "${HOME}/.zprofile"
            append_path_block "${HOME}/.zshrc"
            ;;
        *)
            append_path_block "${HOME}/.profile"
            ;;
    esac
}

main() {
    [[ "$(uname -s)" == "Linux" ]] ||
        fail "This installer currently supports Linux only."

    [[ -n "${HOME:-}" ]] ||
        fail "HOME is not set."

    if [[ "${EUID}" -eq 0 ]]; then
        fail "Do not run this installer with sudo or as root."
    fi

    command -v curl >/dev/null 2>&1 ||
        fail "curl is required."

    local architecture
    case "$(uname -m)" in
        x86_64 | amd64)
            architecture="amd64"
            ;;
        aarch64 | arm64)
            architecture="arm64"
            ;;
        *)
            fail "Unsupported Linux architecture: $(uname -m)"
            ;;
    esac

    local asset_name="zarch-linux-${architecture}"
    local download_url="https://github.com/${GITHUB_OWNER}/${GITHUB_REPO}/releases/latest/download/${asset_name}"

    mkdir -p "${INSTALL_DIR}"

    local temporary_path
    temporary_path="$(mktemp "${INSTALL_DIR}/.zarch-install.XXXXXX")"

    cleanup() {
        rm -f "${temporary_path}"
    }

    trap cleanup EXIT INT TERM HUP

    log "Downloading the latest Z-Arch release for Linux ${architecture}..."

    curl \
        --proto '=https' \
        --proto-redir '=https' \
        --tlsv1.2 \
        --fail \
        --silent \
        --show-error \
        --location \
        --retry 3 \
        --retry-delay 1 \
        --output "${temporary_path}" \
        "${download_url}"

    [[ -s "${temporary_path}" ]] ||
        fail "The downloaded Z-Arch binary is empty."

    chmod 0755 "${temporary_path}"

    if ! "${temporary_path}" --help >/dev/null 2>&1; then
        fail "The downloaded Z-Arch binary could not be executed."
    fi

    mv -f "${temporary_path}" "${INSTALL_PATH}"
    chmod 0755 "${INSTALL_PATH}"

    trap - EXIT INT TERM HUP

    configure_path

    export PATH="${INSTALL_DIR}:${PATH}"
    hash -r

    if [[ "$(command -v zarch 2>/dev/null)" != "${INSTALL_PATH}" ]]; then
        fail "Z-Arch was installed, but the zarch command resolves to another executable."
    fi

    log "Z-Arch was installed successfully at:"
    log "  ${INSTALL_PATH}"
    log ""
    log "Open a new terminal and run:"
    log "  zarch"
}

main "$@"
