const { expect } = require("chai");
const { ethers } = require("hardhat");

// const { EAC, Util } = require('@ethereum-alarm-clock/lib');
// const moment = require('moment');
// const web3 = Util.getWeb3FromProviderUrl('ws://localhost:8545');
// const eac = new EAC(web3);




describe("NFT test", function () {
    let nft
    let market
    let Owner
    let Alice
    let Bob
    let Caleb
    let ListingPrice
    let nftContractAddress
    before( async function() {
        const [owner, alice, bob, caleb] = await ethers.getSigners();
          // console.log("signers: ", owner)
          Owner = owner
          Alice = alice
          Bob = bob
          Caleb = caleb
    
          /* deploy the marketplace */
          const nft2_before = await ethers.getContractFactory("MyToken")
          nft2 = await nft2_before.deploy()
          await nft2.deployed()
          const nft_address = nft2.address
          console.log("nft_address: ", nft_address)
    
      
          
          // ListingPrice = listingPrice
      
    })

    it("6. Scheduling payments ", async function () {

        //  this.skip()
        // revealPrices, revealCurrentTokens, getDepositAmount
        prices = await nft2.revealPrices();
        currentTokens = await nft2.revealCurrentTokens();
        depositAmounts = await nft2.getDepositAmount();

        // console.log("prices: ", prices)
        // console.log("currentTokens: ", currentTokens)
        // console.log("depositAmounts: ", depositAmounts)

        // console.log("-------- BEFORE ANYONE BUYS --------")
        ownerBalance = await nft2.balanceOf(Owner.address);
        // console.log("ownerBalance (aka the number of houses listed by owner): ", ownerBalance)
        let original = await nft2.ownerOf(1);
        // console.log("who owns nft with tokenid 1: ", original, " is the same as ", Owner.address)

        amountFor1 = depositAmounts[1];
        // uint256 _tokenId, uint256 startTime, uint256 currentMockedTime
        // can try subtract by 1 or 2 to make amountFor1 less than required deposit, shd give error:
            
        // console.log("-------- AFTER ALICE BUYS --------")
        ownerBalance = await nft2.balanceOf(Owner.address);
        aliceBalance = await nft2.balanceOf(Alice.address);
        // console.log("Alice's nfts before buying are: ", aliceBalance)
        
        // buying part:
        await nft2.connect(Alice).buy(1, 0, 1, {value : amountFor1});
        // console.log("-------- AFTER ALICE BUYS --------")
        ownerBalance = await nft2.balanceOf(Owner.address);
        aliceBalance = await nft2.balanceOf(Alice.address);
        // console.log("Alice's nfts are: ", aliceBalance)
        // console.log("ownerBalance (aka the number of houses listed by owner): ", ownerBalance)
        // let newowner = await nft2.ownerOf(1);
        // console.log("who owns nft with tokenid 1: ", newowner, " is the same as ", Alice.address)


       

        console.log(`
        
        1. To purchase this NFT, you will have to have 30% of the NFT listing price and at least 6 months worth of monthly instalments.
        

        IF they have enough money to purchase: 
        1. Thank you for paying the deposit. The monthly instalments over the span of 30 years will now be 
            automatically paid from your NFT account. Please keep sufficient funds in your account. Any delayed 
            payment will result in suspension of NFT listing
                NFT successfully transferred!
        
        2. Fast forward 1 month  
        
        3. You are now paying the monthly installment 
        
        4. Fast forward another month 
        
        5. You are now paying the 1% monthly installement`)

    })

    // it("6. Scheduling payments ", async function () {
    //     console.log(`IF they don't have enough money to purchase:
    //     1. To purchase this NFT, you will have to have 30% of the NFT listing price and 
    //         at least 6 months worth of monthly instalments.`)

    // })

    

    it("5. Should throw an error due to insufficient deposit ", async function () {
        this.skip()
        // revealPrices, revealCurrentTokens, getDepositAmount
        prices = await nft2.revealPrices();
        currentTokens = await nft2.revealCurrentTokens();
        depositAmounts = await nft2.getDepositAmount();

        // console.log("prices: ", prices)
        // console.log("currentTokens: ", currentTokens)
        // console.log("depositAmounts: ", depositAmounts)

        // console.log("-------- BEFORE ANYONE BUYS --------")
        ownerBalance = await nft2.balanceOf(Owner.address);
        // console.log("ownerBalance (aka the number of houses listed by owner): ", ownerBalance)
        let original = await nft2.ownerOf(1);
        // console.log("who owns nft with tokenid 1: ", original, " is the same as ", Owner.address)

        amountFor1 = depositAmounts[1];
        // uint256 _tokenId, uint256 startTime, uint256 currentMockedTime
        // can try subtract by 1 or 2 to make amountFor1 less than required deposit, shd give error:
        try{
            await nft2.connect(Alice).buy(1, 0, 1, {value : amountFor1 - 1});
        }catch{
            console.log(`Error occurred: To purchase this NFT, you will have to have 30% of the NFT listing price and 
            at least 6 months worth of monthly instalments.`)
        }
        

        console.log("-------- AFTER ALICE BUYS --------")
        ownerBalance = await nft2.balanceOf(Owner.address);
        aliceBalance = await nft2.balanceOf(Alice.address);
        console.log("Alice's nfts are: ", aliceBalance)
        console.log("ownerBalance (aka the number of houses listed by owner): ", ownerBalance)
        let newowner = await nft2.ownerOf(1);
        console.log("who owns nft with tokenid 1: ", newowner, " is the same as ", Alice.address)


        amountFor2 = depositAmounts[2];
        // uint256 _tokenId, uint256 startTime, uint256 currentMockedTime
        // can try subtract by 1 or 2 to make amountFor1 less than required deposit, shd give error:
        await nft2.connect(Bob).buy(2, 0, 1, {value : amountFor2 + 1});


        console.log("-------- AFTER BOB BUYS --------")
        ownerBalance = await nft2.balanceOf(Owner.address);
        console.log("ownerBalance (aka the number of houses listed by owner): ", ownerBalance)
        let newownerOf2 = await nft2.ownerOf(2);
        console.log("who owns nft with tokenid 2: ", newownerOf2, " is the same as ", Bob.address)
    

    })

    it("4. testing scheduler", async function () {
        this.skip()

        async function fastforward(){
            const month = 30 * 24 * 60 * 60;

        const blockNumBefore = await ethers.provider.getBlockNumber();
        const blockBefore = await ethers.provider.getBlock(blockNumBefore);
        const timestampBefore = blockBefore.timestamp;

        await ethers.provider.send('evm_increaseTime', [month]);
        await ethers.provider.send('evm_mine');

        const blockNumAfter = await ethers.provider.getBlockNumber();
        const blockAfter = await ethers.provider.getBlock(blockNumAfter);
        const timestampAfter = blockAfter.timestamp;

        // expect(blockNumAfter).to.be.equal(blockNumBefore + 1);
        console.log(timestampAfter);
        return [timestampAfter, timestampBefore]
        }
        [newtime, currenttime] = await fastforward();
        console.log(currenttime, newtime)

        // over time checks:

        // await nft2_deployed.buy(1, {value: "400"});
        // function buy(uint256 _tokenId, [startTime, currentMockedTime])
        // expect(newtime).to.be.equal(newtime + month);


        
    })

    // it("3. testing scheduler", async function () {
    //     this.skip()
    //     async function scheduleTransaction() {
    //         const receipt = await eac.schedule({
    //             toAddress: '0xe87529A6123a74320e13A6Dabf3606630683C029',
    //             windowStart: moment().add('1', 'day').unix() // 1 day from now
    //         });
        
    //         console.log(receipt);
    //     }
    //     scheduleTransaction();
        
    // })



    // it("testing buy 2", async function () {
    //     this.skip()
    //     // createToken(string memory tokenURI)
    //     await nft2.createToken("lallll4");
    //     await nft2.createToken("lallll5");
    //     await nft2.createToken("lallll5");
    //     // await nft2.createMarketItem(nftContractAddress, 2, auctionPrice, { value: listingPrice })
    //     // await nft2.createMarketItem(nftContractAddress, 3, auctionPrice, { value: listingPrice })
    //     existingTokens = await nft2.revealCurrentTokens();
    //     console.log("existingTokens: ", existingTokens);
    
    // })

  it("testing buy", async function () {
    this.skip()
    const [owner, alice, bob, caleb] = await ethers.getSigners();
      console.log("signers: ", owner.address)

    const nft2 = await ethers.getContractFactory("MyToken");
    const nft2_deployed = await nft2.deploy();
    await nft2_deployed.deployed();

    // expect(await nft2_deployed.greet()).to.equal("Hello, world!");

    // const setGreetingTx = await nft2_deployed.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    // await setGreetingTx.wait();
    async function fastforward(){
        const month = 30 * 24 * 60 * 60;

    const blockNumBefore = await ethers.provider.getBlockNumber();
    const blockBefore = await ethers.provider.getBlock(blockNumBefore);
    const timestampBefore = blockBefore.timestamp;

    await ethers.provider.send('evm_increaseTime', [month]);
    await ethers.provider.send('evm_mine');

    const blockNumAfter = await ethers.provider.getBlockNumber();
    const blockAfter = await ethers.provider.getBlock(blockNumAfter);
    const timestampAfter = blockAfter.timestamp;

    // expect(blockNumAfter).to.be.equal(blockNumBefore + 1);
    console.log(timestampAfter);
    return [timestampAfter, timestampBefore]
    }
    [newtime, currenttime] = await fastforward();



    const buytx = await nft2_deployed.buy(1, 1000, 1020, {value: "400"});
    console.log(buytx);
    console.log("helloooo")
    // expect(await nft2_deployed.buy(1).to.equal("Hola, mundo!"));


    console.log("helloooo2")
    offeringPrice = await nft2_deployed.buy(2, 1000, 1020, { value: "300"});
    console.log("helloooo3")

    getDepositAmount_ = await nft2_deployed.getDepositAmount();
        console.log("getDepositAmount: ", getDepositAmount_);
    



    // const balance_Alice = await nft2_deployed.balanceOf(alice.address)
    // console.log("alice stuff: ", balance_Alice)

    console.log("this is the offeringPrice: ", offeringPrice.value);
    // if (offeringPrice > price) {
    //     console.log("it is more than!!!")
    // }

    revealPrices = await nft2_deployed.revealPrices();
    console.log("revealPrices: ", revealPrices);


    revealCurrentTokens = await nft2_deployed.revealCurrentTokens();
    console.log("revealCurrentTokens: ", revealCurrentTokens);
    



    // expect(offeringPrice).to.more.than(price);
  });
});
