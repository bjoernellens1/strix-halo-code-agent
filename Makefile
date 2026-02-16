# Makefile for opencode-strix-stack

.PHONY: all scripts

all: help

help:
	@echo "Available commands:"
	@echo "  make setup      - Make scripts executable"
	@echo "  make clean      - Clean up"

setup:
	chmod +x scripts/*.sh

clean:
	@echo "Nothing to clean yet."
