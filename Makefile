.PHONY: all switch

DIR := $(shell pwd)

all: switch

switch:
	sudo nixos-rebuild switch --flake $(DIR)/#default
