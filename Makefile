.PHONY: test
test:
	nixos-rebuild test --flake .#default

.PHONY: switch
switch:
	nixos-rebuild switch --flake .#default
