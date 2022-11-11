import { execSync } from "child_process";
import { BigNumber, ethers, Wallet } from "ethers";
import { formatUnits } from "ethers/lib/utils";
import { exit } from "process";
import { ERC721BatchTransfer__factory } from "./contracts"
import {
  FlashbotsBundleProvider,
} from "@flashbots/ethers-provider-bundle";
require("dotenv").config();

const RPC_URL = process.env.RPC_URL!;
const WSS_URL = process.env.WSS_URL!;
const PRIVATE_KEY = process.env.PRIVATE_KEY!;

const gwei = (val: string) => {
  return ethers.utils.parseUnits(val, "gwei");
};


const deploy = (maxFeePerGas: BigNumber) => async () => {
  const provider = new ethers.providers.JsonRpcProvider(RPC_URL);
  const deployer = new Wallet(PRIVATE_KEY, provider);

  // use this as the last argument of factory.deploy()
  const overrides = {
    maxFeePerGas,
    maxPriorityFeePerGas: gwei("1"),
  };

  // ... deployment code
  const factory = new ERC721BatchTransfer__factory(deployer);
  const contract = await factory.deploy(overrides);
  console.log("Deploying to", contract.address)
  await contract.deployed();
  console.log("Deployed")
};


const main = async () => {
  // This will run the deploy function when the chain has a base gas fee <= 28 gwei,
  // and the deployment tx will pay at most 30 gwei as the base gas fee.
  await deploy(gwei("20"))()
};

main();
