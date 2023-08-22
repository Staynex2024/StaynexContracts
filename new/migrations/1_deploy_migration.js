var SolidityContract = artifacts.require("STAYNEX_GENISIS");

module.exports = function(deployer) {
  // Deploy the SolidityContract contract as our only task
  deployer.deploy(SolidityContract);
};
