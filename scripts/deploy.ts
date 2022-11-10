import { execSync } from "child_process";
import { BigNumber, ethers, Wallet } from "ethers";
import { formatUnits } from "ethers/lib/utils";
import { exit } from "process";
require("dotenv").config();

const RPC_URL = process.env.RPC_URL!;
const WSS_URL = process.env.WSS_URL!;
const PRIVATE_KEY = process.env.PRIVATE_KEY!;

const gwei = (val: string) => {
  return ethers.utils.parseUnits(val, "gwei");
};


const deploy = (maxFeePerGas: BigNumber) => async () => {
  const provider = new ethers.providers.StaticJsonRpcProvider(RPC_URL);
  const deployer = new Wallet(PRIVATE_KEY, provider);

  // use this as the last argument of factory.deploy()
  const overrides = {
    maxFeePerGas,
    maxPriorityFeePerGas: gwei("1"),
  };

  // ... deployment code
  // const factory = new Contract__factory(deployer);
  // const contract = await factory.deploy(overrides);
  // await contract.deployed();
  exit(0);
};

const runWhenGasIsBelowTarget = (gasTarget: BigNumber, run: () => void) => {
  const wsProvider = new ethers.providers.WebSocketProvider(WSS_URL);

  let done = false;
  // subscribe to every new head on the chain
  wsProvider._subscribe("block", ["newHeads"], (result: any) => {
    if (done) {
      return;
    }

    // curent base gas fee in the chain
    const baseFeePerGas = BigNumber.from(result.baseFeePerGas);

    // Human readable gwei, to print
    const humanReadableBaseFeePerGas = formatUnits(
      baseFeePerGas.toString(),
      "gwei"
    );

    // check if the base fee is below the gas target
    if (baseFeePerGas.lte(gasTarget)) {
      console.log(humanReadableBaseFeePerGas, "✅");
      done = true;
      run();
    } else {
      console.log(humanReadableBaseFeePerGas, "❌");
    }
  });
};

const main = () => {
  // This will run the deploy function when the chain has a base gas fee <= 28 gwei,
  // and the deployment tx will pay at most 30 gwei as the base gas fee.
  runWhenGasIsBelowTarget(
    gwei("28"), 
    deploy(gwei("30"))
  );
};

main();
