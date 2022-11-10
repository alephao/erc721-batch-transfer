.PHONY: build
build:
	forge build --force --optimize

.PHONY: test
test:
	forge test --match-contract "UnitTest$$|E2ETest$$"

.PHONY: snapshot
snapshot:
	forge snapshot --force --optimize --match-contract "BenchmarkTest$$"

.PHONY: codegen
codegen:
		python scripts/solcery/main.py errsig ./src/*.sol
		python scripts/solcery/main.py errgen ./src/test/utils/Errors.sol ./src/*.sol

.PHONY: format
format:
	yarn prettier

.PHONY: lint
lint:
	yarn lint:check

.PHONY: analyze
analyze:
	slither src/*.sol --config-file slither.config.json

.PHONY: typechain
typechain:
	yarn typechain

.PHONY: deploy
deploy: build typechain
	yarn deploy