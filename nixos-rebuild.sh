set -e

ACTION="switch"
HOSTNAME=""
PROXY_URL=""
NIX_FLAGS="--extra-experimental-features nix-command --extra-experimental-features flakes"
INSTALL_MODE=false

usage() {
  echo "Usage: $0 [-b] [-p <url>] [-I] <hostname>"
  echo
  echo "  A script to build or rebuild a NixOS system from a flake."
  echo
  echo "  Modes (choose one):"
  echo "    (default)     Use 'nixos-rebuild switch' to build and activate immediately."
  echo "    -b, --boot    Use 'nixos-rebuild boot' to make the build the default for the next boot."
  echo "    -I, --install Use 'nixos-build' for a first-time installation (overrides -b)."
  echo
  echo "  Options:"
  echo "    -p, --proxy <url>  Set the http/https proxy for the operation."
  echo "    -h, --help         Display this help message and exit."
  echo
  echo "  Arguments:"
  echo "    <hostname>         The hostname of the system to build."
  exit 1
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -b|--boot)
      ACTION="boot"
      shift
      ;;
    -I|--install)
      INSTALL_MODE=true
      shift
      ;;
    -p|--proxy)
      if [ -z "$2" ]; then
        echo "Error: Option '$1' requires a URL as an argument." >&2
        usage
      fi
      PROXY_URL="$2"
      shift 2
      ;;
    -h|--help)
      usage
      ;;
    -*)
      echo "Error: Unknown option: $1" >&2
      usage
      ;;
    *)
      if [ -n "$HOSTNAME" ]; then
        echo "Error: Multiple hostnames provided. Please specify only one." >&2
        usage
      fi
      HOSTNAME="$1"
      shift
      ;;
  esac
done

if [ -z "$HOSTNAME" ]; then
  echo "Error: Hostname is required." >&2
  usage
fi

echo
echo "--- Configuration ---"
if [ "$INSTALL_MODE" = true ]; then
  echo "Mode:     Initial Build (nixos-build)"
  if [ "$ACTION" = "boot" ]; then
    echo "          (Note: --install overrides --boot)"
  fi
else
  echo "Mode:     Rebuild"
  echo "Action:   $ACTION"
fi
echo "Hostname: $HOSTNAME"
if [ -n "$PROXY_URL" ]; then
  echo "Proxy:    $PROXY_URL"
fi
echo "---------------------"
echo

if [ -n "$PROXY_URL" ]; then
  export all_proxy="$PROXY_URL"
  echo "✓ Proxy exported."
else
  echo "ℹ︎ No proxy specified."
fi

echo "→ Running 'nix flake update'..."
nix $NIX_FLAGS flake update --flake .
echo "✓ Flake updated successfully."

if [ "$INSTALL_MODE" = true ]; then
    echo "→ Running 'nixos-build' for flake '.#$HOSTNAME'..."
    nixos-build --flake ".#$HOSTNAME"
    echo
    echo "✅ NixOS build for '$HOSTNAME' completed successfully."
    echo "   The result is available in the './result' symlink."
    echo "   You can now proceed with 'nixos-install --root /mnt --flake .#$HOSTNAME'"
else
    echo "→ Running 'nixos-rebuild $ACTION' for flake '.#$HOSTNAME'..."
    nixos-rebuild "$ACTION" --flake ".#$HOSTNAME" --use-remote-sudo
    echo
    echo "✅ NixOS rebuild for '$HOSTNAME' completed successfully with action '$ACTION'."
fi