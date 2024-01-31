const Spacebear = artifacts.require("Spacebear");
const truffleAssert = require("truffle-assertions");
contract("Spacebear", (accounts) => {
    it("Should credit an nft to a specific account", async() => {
        const spaceBearInstance = await Spacebear.deployed();
        let txResult = await spaceBearInstance.safeMint(accounts[1], "spacebear_1.json");
        //assert.equal(await spaceBearInstance.ownerOf(0), accounts[1], "Owner of token 1 is not equal to account 2");
        console.log(txResult.log[0].args);
        truffleAssert.eventEmitted(txResult, "Transfer", {from: "0x0000000000000000000000000000000000000000", to: accounts[1], tokenId: web3.utils.toBN("0")})
    })
})