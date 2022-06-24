import hre from 'hardhat';
const { waffle } = hre;

import { AnteElementVaultsRugTest__factory, AnteElementVaultsRugTest } from '../../typechain';

import { evmSnapshot, evmRevert } from '../helpers';
import { expect } from 'chai';

describe('AnteElementVaultsRugTest', function () {
  let test: AnteElementVaultsRugTest;

  let globalSnapshotId: string;

  before(async () => {
    globalSnapshotId = await evmSnapshot();

    const [deployer] = waffle.provider.getWallets();
    const factory = (await hre.ethers.getContractFactory(
      'AnteElementVaultsRugTest',
      deployer
    )) as AnteElementVaultsRugTest__factory;
    test = await factory.deploy();
    await test.deployed();
  });

  after(async () => {
    await evmRevert(globalSnapshotId);
  });

  it('should pass', async () => {
    expect(await test.checkTestPasses()).to.be.true;
  });
});
