pragma solidity ^0.8.4;

// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol';
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


// ERC721, -- can remove it since it is parent of ERC721URIStorage
contract MyToken is ERC721URIStorage {
    event NftBought(address _seller, address _buyer, uint256 _price);

    mapping (uint256 => uint256) public tokenIdToPrice;
    mapping (uint256 => address) public tokenIdToTokenAddress;
    mapping (uint256 => uint256) public tokenIdToStartTime;
    mapping (uint256 => uint256) public tokenIdToDepositAmount;

    uint256[] existingTokens;

    struct MarketItem {
    // uint itemId;
    // address nftContract;
    string name;
    uint256 tokenId;
    address payable seller;
    address payable owner;
    uint256 price;
    bool sold;
    uint256 amountLeft;
    uint startDate;
    uint256 deposit;
    uint256 bedrooms;
    uint256 showers;
    uint256 area;
  }

  mapping(uint256 => MarketItem) private idToMarketItem;



    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter private _soldcounter;

    constructor() ERC721('MyToken', 'MyT') {
        // _mint(msg.sender, 1);
        // string memory tokenURI, 
        //                 string memory name,
        //                 uint256 bedrooms,
        //                 uint256 showers,
        //                 uint256 area


        createToken("https://gateway.pinata.cloud/ipfs/QmXb4EEZ77zmXAbLo522EojCQRdP86Dc6j79SFxjo5yX6K?preview=1",
        "Helios Residences",4, 2, 2508);
        createToken("https://gateway.pinata.cloud/ipfs/QmUDeeroAESUokD2omeiRk24KWdxPaaTnyJdJSvXdCbtRE?preview=1",
        "Parc Rosewood",4, 2, 1998);
        createToken("https://gateway.pinata.cloud/ipfs/QmR57qyicD9MQEQTBZ9dQdx1tr43fB3F4ZwQY22ZkJ87zy?preview=1",
        "Buckley Classique",5, 2, 1910);
        createToken("https://gateway.pinata.cloud/ipfs/QmTH5vcxEQWdsJghKiqBfvsrhkvKNkQk1TYgVGso1kjyrn?preview=1", 
        "Sentosa Cove",4, 2, 2620);
        createToken("https://gateway.pinata.cloud/ipfs/QmfRvRtpFHLQaVdP9ii1x7aixs9pU7gKwBaBxr8G2uqu1Q?preview=1",
        "Cluny Park Bungalow",4, 3, 2508);
        
        createToken("https://gateway.pinata.cloud/ipfs/QmWjqoB4nVNALUyrMg828MdML1XaHQ52ifpDur1PqkU8Fz?preview=1",
        "Hillview Villas",4, 2, 2930);
        createToken("https://gateway.pinata.cloud/ipfs/QmPn7N4GaAVMNhdee6ZeGmxDoC56J2nnWa3Fyzsw5ugSby?preview=1",
        "1 Bishan Street 22",5, 3, 1323);
        createToken("https://gateway.pinata.cloud/ipfs/QmYR1SBcyt5JNfcVvoEr2H3ZE8eML1Ja3PXHwyDx2xX77t?preview=1",
        "7 Yishun Avenue 4",4, 2, 2508);

        setPrice(1, 123);
        setPrice(2, 123*2);
        setPrice(3, 123*3);
        setPrice(4, 123*6);
        setPrice(5, 123*8);

        setPrice(6, 123);
        setPrice(7, 123*5);
        setPrice(8, 123*4);

    }

    // function mint(address player, string memory tokenURI)
    //     public
    //     returns (uint256)
    // {
    //     _tokenIds.increment();

    //     uint256 newItemId = _tokenIds.current();
    //     _mint(player, newItemId);
    //     _setTokenURI(newItemId, tokenURI);

    //     return newItemId;
    // }

//     function mintToken(address to, uint256 tokenId, string uri) public virtual payable {
  
//         require(msg.value >= 10, "Not enough ETH sent; check price!"); 
        
//         mint(to, tokenId);
//         _setTokenURI(tokenId, uri);
// }

    function createToken(string memory tokenURI, 
                        string memory name,
                        uint256 bedrooms,
                        uint256 showers,
                        uint256 area
                        ) public returns (uint) {


        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        idToMarketItem[newItemId] =  MarketItem(
                        name,
                        newItemId,
                        payable(msg.sender),
                        payable(address(0)),
                        0,
                        false,
                        0,
                        0,
                        0,
                        bedrooms,
                        showers,
                        area);



        _mint(msg.sender, newItemId);



        // _setTokenURI only available as private method of ERC721URIStorage: 
        _setTokenURI(newItemId, tokenURI);

        // maybe can find existing created tokens??? -- yep can see but cannot create new tokens are see on testing side
        existingTokens.push(newItemId);

    


        // setApprovalForAll(contractAddress, true);
        // maybe can set price one shot here???

        return newItemId;
    }

    // function revealCurrentTokens() view returns (uint) {

    // }

    function revealCurrentTokens() public view returns (uint256[] memory) {
        // uint itemCount = _itemIds.current();
        // uint unsoldItemCount = _itemIds.current() - _itemsSold.current();
        // uint currentIndex = 0;

        // MarketItem[] memory items = new MarketItem[](unsoldItemCount);
        // for (uint i = 0; i < itemCount; i++) {
        // if (idToMarketItem[i + 1].owner == address(0)) {
        //     uint currentId = i + 1;
        //     MarketItem storage currentItem = idToMarketItem[currentId];
        //     items[currentIndex] = currentItem;
        //     currentIndex += 1;
        // }
        // }

        // make a copy of the existing array and return:
        uint256[] memory items = new uint256[](_tokenIds.current());
        uint256 count = _tokenIds.current();
        // uint256 count = 2;
        for (uint i = 0; i < count; i++) {
            items[i] = existingTokens[i];
        }

        return items;
    }    

    /* Returns all unsold market items */
  function fetchListingItems() public view returns (MarketItem[] memory) {
    uint itemCount = _tokenIds.current();
    uint unsoldItemCount = _tokenIds.current() - _soldcounter.current()+2;
    uint currentIndex = 0;

    MarketItem[] memory items = new MarketItem[](unsoldItemCount);
    for (uint i = 0; i < itemCount; i++) {
    //   if (idToMarketItem[i + 1].owner == address(0)) {
        // cuz _tokenIds starts counting from 1:
        if (idToMarketItem[i+1].owner == address(0)) {
        // uint currentId = i + 1;
        uint currentId = i+1;
        MarketItem storage currentItem = idToMarketItem[currentId];
        items[currentIndex] = currentItem;
        currentIndex += 1;
      }
    }
    return items;
  }

  function fetchListingItems2() public view returns (uint itemcount ) {
    uint itemCount = _tokenIds.current();
    uint unsoldItemCount = _tokenIds.current() - _soldcounter.current();
    uint currentIndex = 0;
    return unsoldItemCount;
  }




    function revealPrices() public view returns (uint256[] memory) {
 // make a copy of the existing array and return:
        uint256[] memory items2 = new uint256[](_tokenIds.current());

        uint256 count = _tokenIds.current() ;
        // uint256 count = 2;
        for (uint i = 0; i < count; i++) {
            items2[i] = tokenIdToPrice[i];
        }
        return items2;
    }

// function revealCurrentTokens() public view returns (uint256[] memory) {

    function getDepositAmount() public view returns (uint256[] memory) {
 // make a copy of the existing array and return:
        uint256[] memory items3 = new uint256[](_tokenIds.current());
        uint256 count = _tokenIds.current();
        // uint256 count = 2;
        for (uint i = 0; i < count; i++) {
            items3[i] = tokenIdToDepositAmount[i];
        }
        return items3;
    }
  



// external
    function setPrice(uint256 _tokenId, uint256 _price) public returns (uint256 price) {
             // how to find token address???
        require(msg.sender == ownerOf(_tokenId), 'Not owner of this token');
        tokenIdToPrice[_tokenId] = _price;
        uint256 expectedwalletfunds = ((3 * _price)/10 + (7 * _price)/ 600);
        tokenIdToDepositAmount[_tokenId] = expectedwalletfunds;


        MarketItem storage item = idToMarketItem[_tokenId];
        item.price = _price;
        item.deposit = expectedwalletfunds;
        item.amountLeft = _price - expectedwalletfunds;

        // tokenIdToTokenAddress[_tokenId] = _tokenAddress;
        return _price;
        
    }



    function allowBuy(uint256 _tokenId, uint256 _price) external {
        require(msg.sender == ownerOf(_tokenId), 'Not owner of this token');
        require(_price > 0, 'Price zero');
        tokenIdToPrice[_tokenId] = _price;
    }

    function disallowBuy(uint256 _tokenId) external {
        require(msg.sender == ownerOf(_tokenId), 'Not owner of this token');
        tokenIdToPrice[_tokenId] = 0;
    }


    function pay_deposit() public{

    }

    function revealNow() public view returns(uint currentTime){
        return block.timestamp;
    }

    

    // function buy(uint256 _tokenId, [startTime, currentMockedTime])

    function buy(uint256 _tokenId, uint256 startTime, uint256 currentMockedTime) 
    external payable 
    returns(uint256 testreturn) {
        uint256 nftprice = tokenIdToPrice[_tokenId];
        require(nftprice > 0, 'This token is not for sale');
        require(startTime < currentMockedTime, "untimely payment!");
    
        // (30% x NFT price + 70% x NFT price/ 360 x 6);
        uint256 expectedwalletfunds = ((3 * nftprice)/10 + (7 * nftprice)/ 600);
        
        // balances[msg.sender]

        // require(msg.value >= nftprice, "");
        require(msg.value >= expectedwalletfunds, "Insufficient funds to purchase NFTs!");
        // require(msg.value == price, 'Incorrect value');
        

        MarketItem storage item = idToMarketItem[_tokenId];
        address seller = ownerOf(_tokenId);
        _transfer(seller, msg.sender, _tokenId);
        tokenIdToPrice[_tokenId] = 0; // not for sale anymore
        item.sold = true;
        _soldcounter.increment();

        // paying deposit part is hereeeee:
        uint256 deposit = (3 * nftprice)/10;
        // payable(seller).transfer(msg.value); // send the ETH to the seller
        payable(seller).transfer(deposit); // send the ETH to the seller
        payable(msg.sender).transfer(msg.value - deposit); // send the ETH to the seller

        emit NftBought(seller, msg.sender, msg.value);
        testreturn = msg.value;
        return nftprice;
    }
}
