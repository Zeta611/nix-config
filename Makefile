.PHONY: nixos-test nixos-switch darwin-test darwin-switch

nixos-test:
	nixos-rebuild test --flake .#default

nixos-switch:
	nixos-rebuild switch --flake .#default

darwin-test:
	darwin-rebuild switch --flake .

darwin-switch:
	darwin-rebuild switch --flake .
