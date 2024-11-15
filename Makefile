.PHONY: all switch

DIR := $(shell pwd)

all: switch

switch:
	sudo -E nixos-rebuild switch --flake $(DIR)/#lunix --show-trace
