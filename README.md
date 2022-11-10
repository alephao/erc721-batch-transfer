### Solidity Starter Template

Opinionated solidity template with too many tools.

**Configuration**

- Compile using solidity `0.8.17`
- Imports relative to the root folder using `$` e.g.: `import "$/src/Contract.sol";`
- Imports relative to lib fodler using `@` e.g.: `import "@ds-test/test.sol";`

**Tooling**

- **[foundry](https://github.com/foundry-rs/foundry)'s `forge`** for building, testing, and gas snapshots
- **[solhint](https://github.com/protofire/solhint)** for linting
- **[slither](https://github.com/crytic/slither)** for static analysis and linting
- **[solcery](https://github.com/alephao/solcery)** for code-generating type-safe errors for tests and error signature comments
- GitHub Actions CI with three workflows: test, lint, and analyze.
- Makefile with common commands
- Deployment script using typescript, ethersjs and typechain

**Support Contracts**

- **[ds-test](https://github.com/dapphub/ds-test)** for testing
- **[forge-std](https://github.com/foundry-rs/forge-std)** for HEVM interface and some type-safe evm errors

**CI**

There are three GitHub Actions workflows configured.

- **Test**: Will run `make test`, running the unit-tests with forge.
- **Lint**: Will run `make lint`, running solhint and prettier.
- **Analyze**: Will run `make analyze`, running the slither analyzer.

### Makefile Commands

* **build**: force build with optimization
* **test**: run only test contracts suffixed with `UnitTest`
* **snapshot**: create .gas-snapshot, running only tests suffixed with `BenchmarkTest`
* **codegen**: generate Errors.sol and error's sighash comments
* **format**: format codebase using prettier
* **lint**: lint using solhint
* **analyze**: run analyzer (slither)
* **typechain**: run analyzer (slither)
* **deploy**: re-build, re-run typechain, and run deployment script `scripts/deploy.ts`

### Tests

* Unit test contracts should be suffixed with UnitTest
* Gas/Benchmark test contracts should be suffixed with BenchmarkTest