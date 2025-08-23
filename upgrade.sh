export all_proxy=http://127.0.0.1:10808 && nix flake update --flake . && nixos-rebuild switch --flake .#Kawaii
