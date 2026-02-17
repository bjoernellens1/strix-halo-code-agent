TOOLBOX ?= llama-rocm-7.2

toolbox:
	./scripts/toolbox-create.sh $(TOOLBOX)

serve:
	@echo "Run this inside toolbox: toolbox enter $(TOOLBOX) && ./scripts/start-all.sh"

health:
	./scripts/health.sh

cartography:
	./scripts/cartography.sh

opencode:
	OPENCODE_CONFIG_DIR=$(PWD)/opencode opencode
