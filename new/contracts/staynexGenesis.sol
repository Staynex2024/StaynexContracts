pragma solidity ^0.5.17;
pragma experimental ABIEncoderV2;

// SPDX-License-Identifier: Creative Commons
// @author: Srihari Kapu <sri@sriharikapu.com>
// @author-website: http://www.sriharikapu.com
// SPDX-License-Identifier: CC-BY-4.0

// File: contracts/Strings.sol 
library Strings {
  // via https://github.com/oraclize/ethereum-api/blob/master/oraclizeAPI_0.5.sol
  function strConcat(string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) internal pure returns (string memory) {
    bytes memory _ba = bytes(_a);
    bytes memory _bb = bytes(_b);
    bytes memory _bc = bytes(_c);
    bytes memory _bd = bytes(_d);
    bytes memory _be = bytes(_e);
    string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
    bytes memory babcde = bytes(abcde);
    uint k = 0;
    for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
    for (uint i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
    for (uint i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
    for (uint i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
    for (uint i = 0; i < _be.length; i++) babcde[k++] = _be[i];
    return string(babcde);
  }

  function strConcat(string memory _a, string memory _b, string memory _c, string memory _d) internal pure returns (string memory) {
    return strConcat(_a, _b, _c, _d, "");
  }

  function strConcat(string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
    return strConcat(_a, _b, _c, "", "");
  }

  function strConcat(string memory _a, string memory _b) internal pure returns (string memory) {
    return strConcat(_a, _b, "", "", "");
  }

  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
    if (_i == 0) {
      return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
      len++;
      j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (_i != 0) {
      bstr[k--] = byte(uint8(48 + _i % 10));
      _i /= 10;
    }
    return string(bstr);
  }

  function fromAddress(address addr) internal pure returns(string memory) {
    bytes20 addrBytes = bytes20(addr);
    bytes16 hexAlphabet = "0123456789abcdef";
    bytes memory result = new bytes(42);
    result[0] = '0';
    result[1] = 'x';
    for (uint i = 0; i < 20; i++) {
      result[i * 2 + 2] = hexAlphabet[uint8(addrBytes[i] >> 4)];
      result[i * 2 + 3] = hexAlphabet[uint8(addrBytes[i] & 0x0f)];
    }
    return string(result);
  }
}

// File: openzeppelin-solidity/contracts/introspection/IERC165.sol

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721.sol

contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    function balanceOf(address owner) public view returns (uint256 balance);
    function ownerOf(uint256 tokenId) public view returns (address owner);
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);
    function transferFrom(address from, address to, uint256 tokenId) public;
    function safeTransferFrom(address from, address to, uint256 tokenId) public;
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721Receiver.sol

contract IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);
}

// File: openzeppelin-solidity/contracts/math/SafeMath.sol

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;
        return c;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }

    function pow(uint256 base, uint256 exponent) internal pure returns (uint256) {
        if (exponent == 0) {
            return 1;
        }
        else if (exponent == 1) {
            return base;
        }
        else if (base == 0 && exponent != 0) {
            return 0;
        }
        else {
            uint256 z = base;
            for (uint256 i = 1; i < exponent; i++){
                 z = mul(z, base);                
            }
            return z;
      }
    }
    

}

// File: openzeppelin-solidity/contracts/utils/Address.sol

library logicalMath {
    
    function and(bytes32 a, bytes32 b) internal pure returns (bytes32) {
        return a & b;
    }
    
    function or(bytes32 a, bytes32 b) internal pure returns (bytes32) {
        return a | b;
    }
    
    function xor(bytes32 a, bytes32 b) internal pure returns (bytes32) {
        return a ^ b;
    }
    
}

/**
 * Utility library of inline functions on addresses
 */
library Address {

    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

// File: openzeppelin-solidity/contracts/drafts/Counters.sol


library Counters {
    using SafeMath for uint256;

    struct Counter {

        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

// File: openzeppelin-solidity/contracts/introspection/ERC165.sol

contract ERC165 is IERC165 {
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff);
        _supportedInterfaces[interfaceId] = true;
    }
}

interface IERC2981  {

    function royaltyInfo(uint256 tokenId, uint256 salePrice) external view returns (address receiver, uint256 royaltyAmount);
}

contract ERC2981 is IERC2981, IERC165 {
    struct RoyaltyInfo {
        address receiver;
        uint96 royaltyFraction;
    }

    RoyaltyInfo private _defaultRoyaltyInfo;
    mapping(uint256 => RoyaltyInfo) private _tokenRoyaltyInfo;


    function royaltyInfo(uint256 tokenId, uint256 salePrice) public view returns (address, uint256) {
        RoyaltyInfo memory royalty = _tokenRoyaltyInfo[tokenId];

        if (royalty.receiver == address(0)) {
            royalty = _defaultRoyaltyInfo;
        }

        uint256 royaltyAmount = (salePrice * uint256(royalty.royaltyFraction)) / _feeDenominator();

        return (royalty.receiver, royaltyAmount);
    }

    function _feeDenominator() internal pure returns (uint96) {
        return 10000;
    }

    function _setDefaultRoyalty(address receiver, uint96 feeNumerator) internal {
        uint256 denominator = _feeDenominator();
        require(feeNumerator <= denominator, "Invalid default royalty");
        require(receiver != address(0), "Invalid default royalty receiver");

        _defaultRoyaltyInfo = RoyaltyInfo(receiver, feeNumerator);
    }

    function _deleteDefaultRoyalty() internal {
        delete _defaultRoyaltyInfo;
    }

    function _setTokenRoyalty(uint256 tokenId, address receiver, uint96 feeNumerator) internal {
        uint256 denominator = _feeDenominator();
        require(feeNumerator <= denominator, "Invalid token royalty");
        require(receiver != address(0), "Invalid token royalty receiver");

        _tokenRoyaltyInfo[tokenId] = RoyaltyInfo(receiver, feeNumerator);
    }

    function _resetTokenRoyalty(uint256 tokenId) internal {
        delete _tokenRoyaltyInfo[tokenId];
    }
}

// File: openzeppelin-solidity/contracts/token/ERC721/ERC721.sol

contract ERC721 is ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
    mapping (uint256 => address) private _tokenOwner;
    mapping (uint256 => address) private _tokenApprovals;
    mapping (address => Counters.Counter) private _ownedTokensCount;
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
    constructor () public {
        _registerInterface(_INTERFACE_ID_ERC721);
    }

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0));
        return _ownedTokensCount[owner].current();
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0));
        return owner;
    }

    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender));

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId));
        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender);
        _operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId));

        _transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data));
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0));
        require(!_exists(tokenId));

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner);

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from);
        require(to != address(0));

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
        internal returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
        return (retval == _ERC721_RECEIVED);
    }

    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721Enumerable.sol

contract IERC721Enumerable is IERC721 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

// File: openzeppelin-solidity/contracts/token/ERC721/ERC721Enumerable.sol

contract ERC721Enumerable is ERC165, ERC721, IERC721Enumerable {
    mapping(address => uint256[]) public _ownedTokens;
    mapping(uint256 => uint256) private _ownedTokensIndex;
    uint256[] private _allTokens;
    mapping(uint256 => uint256) private _allTokensIndex;
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;
    
    constructor () public {
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
    }
    
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256) {
        require(index < balanceOf(owner));
        return _ownedTokens[owner][index];
    }
    
    function ListOFtokensOwned(address owner) public view returns (uint256[] memory) {
        return _ownedTokens[owner];
    }
    
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply());
        return _allTokens[index];
    }
    
    function getTokenList() public view returns (uint256[] memory){
        return _allTokens;
    }

    function _transferFrom(address from, address to, uint256 tokenId) internal {
        super._transferFrom(from, to, tokenId);
        _removeTokenFromOwnerEnumeration(from, tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);
    }

    function _mint(address to, uint256 tokenId) internal {
        super._mint(to, tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);
        _addTokenToAllTokensEnumeration(tokenId);
    }

    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);
        _removeTokenFromOwnerEnumeration(owner, tokenId);
        _ownedTokensIndex[tokenId] = 0;
        _removeTokenFromAllTokensEnumeration(tokenId);
    }

    function _tokensOfOwner(address owner) internal view returns (uint256[] storage) {
        return _ownedTokens[owner];
    }

    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId) private {
        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[tokenId];
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }
        _ownedTokens[from].length--;
    }

    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[tokenId];
        uint256 lastTokenId = _allTokens[lastTokenIndex];
        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        _allTokens.length--;
        _allTokensIndex[tokenId] = 0;
    }
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721Metadata.sol

contract IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function supply() external view returns (uint256);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

// File: openzeppelin-solidity/contracts/token/ERC721/ERC721Metadata.sol

contract ERC721Metadata is ERC165, ERC721, IERC721Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;
    
    uint256 private _supply;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

    constructor (string memory name, string memory symbol, uint256 supply) public {
        _name = name;
        _symbol = symbol;
        _supply = supply;
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }
    
    function supply()external view returns (uint256) {
        return _supply;
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId));
        return _tokenURIs[tokenId];
    }

    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId));
        _tokenURIs[tokenId] = uri;
    }

    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

// File: openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol

contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
    constructor (string memory name, string memory symbol, uint256 supply) public ERC721Metadata(name, symbol, supply) {
    }
}

// File: openzeppelin-solidity/contracts/ownership/Ownable.sol

contract Ownable {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    function owner() public view returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract ReentrancyGuard {
    bool private _notEntered;
    constructor () internal {
        _notEntered = true;
    }

    modifier nonReentrant() {
        require(_notEntered, "ReentrancyGuard: reentrant call");
        _notEntered = false;
        _;
        _notEntered = true;
    }
}

// File: contracts/TradeableERC721Token.sol


contract ERC20 {
    function transfer(address to, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public  returns (bool success);
}

/**
 * @title STAYNEXGENESIS - ERC721 contract that whitelists a trading address, and has minting functionality.
 */
contract STAYNEXGENESIS is ERC721Full, Ownable, ERC2981, ReentrancyGuard {
  using Strings for string;
  using logicalMath for bytes32;
  string private _baseTokenURI;
  uint256 public chargeRate;
  uint256 private _currentTokenId = 0;
  uint256 private tsupply;
  string public _Version;
  uint256 public GRAVITY_LOCKED;
  string private IPFS_HASH;
  string private metadataDetails;
  ERC20 public token;    
  uint256[] private BurntTokens;
  uint256 private Time;
  uint256 private MAX;
  uint256 private RedeemTimeLimit;
  address payable propertyowner;
  address payable superAdmin;
  uint256 private superAdminPoroportion;

  constructor(string memory _name, string memory _symbol, uint256 _supply,  string memory _version, uint256 _GRAVITY_LOCKED, address _ERC20_, uint256 _Time, uint256 _redeemTimeLimit, uint256 _maxDaysRedeemable, string memory baseURI) ERC721Full(_name, _symbol, _supply) public {
    tsupply = _supply.sub(1);
    _Version = _version;
    GRAVITY_LOCKED = SafeMath.div(_GRAVITY_LOCKED,_supply);
    token = ERC20(_ERC20_);
    superAdmin = 0x7A48001Cc143051feD84fb3A619bfe8E947Be4c3; // replace with staynex admin wallet address
    superAdminPoroportion = 20; // set the 20% of funds that super admin should receive
    chargeRate = 0.1 ether;
    Time = _Time; // timestamp used for burn
    RedeemTimeLimit = _redeemTimeLimit;
    MAX = _maxDaysRedeemable++;
    propertyowner = msg.sender;
    _setDefaultRoyalty(superAdmin, 500); // 5% (500 / 10000) of the sale price of the NFT
    _baseTokenURI = Strings.strConcat(baseURI, Strings.fromAddress(address(this)), "/");

    emit RoyaltyFunction("setRoyality", 500, block.timestamp);
    
  }

  function setMax(uint256 _upperLimit) public onlyOwner{
      MAX = _upperLimit;
  }

    event NFTMint(uint256 indexed tokenId, address indexed creator, uint256 value, uint256 timestamp);
    event NFTBurn(uint256 indexed tokenId, address indexed owner, string method, uint256 timestamp);
    event RedeemNights(address indexed creator, string method, uint256 nights, uint256 timestamp);
    event RefundNights(address indexed creator, string method, uint256 nights, uint256 timestamp);
    event RoyaltyFunction(string method, uint256 royalty, uint256 timestamp);

  function supportsInterface(bytes4 interfaceId) public view returns (bool) {
    return interfaceId == 0x01ffc9a7 || // IERC165:  bytes4(keccak256('supportsInterface(bytes4)'))
           interfaceId == 0x80ac58cd || // IERC721:  bytes4(keccak256('balanceOf(address)')) ^ bytes4(keccak256('ownerOf(uint256)')) ^ bytes4(keccak256('approve(address,uint256)')) ^ bytes4(keccak256('getApproved(uint256)')) ^ bytes4(keccak256('setApprovalForAll(address,bool)')) ^ bytes4(keccak256('isApprovedForAll(address,address)')) ^ bytes4(keccak256('transferFrom(address,address,uint256)')) ^ bytes4(keccak256('safeTransferFrom(address,address,uint256)')) ^ bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)'))
           interfaceId == 0x2a55205a;   // IERC2981: bytes4(keccak256('royaltyInfo(uint256,uint256)'))
  }
  
  function mintTo(address _to) public onlyOwner {
    require(_currentTokenId <= tsupply);
    uint256 newTokenId = _currentTokenId;  
    _mint(_to, newTokenId);
    setInitials(msg.sender,newTokenId);
    _incrementTokenId();
    emit NFTMint( newTokenId, msg.sender, 0, block.timestamp);
  }

  function changeChargeRate(uint256 _amount) public onlyOwner {
      require(_amount != 0,"Amount cant be zero");
      chargeRate = _amount;
  }

  function publicMint(address _to) public payable {
    // chargeRate = 0.1 ether;
    require(_currentTokenId <= tsupply, "Token supply exceeded");
    require(msg.value == chargeRate, "Insufficient funds");

    uint256 newTokenId = _currentTokenId;
    _mint(_to, newTokenId);
    _incrementTokenId();
    setInitials(msg.sender,newTokenId);
    // Transfer the payment to the payment address if there is any
    uint256 superAdminAmount = ((chargeRate).div(100)).mul(superAdminPoroportion);
    uint256 propertyOwnerAmount = (chargeRate).sub(superAdminAmount);
    propertyowner.transfer(propertyOwnerAmount);
    superAdmin.transfer(superAdminAmount);
    emit NFTMint( newTokenId, msg.sender, msg.value, block.timestamp);
    
    }
  
  function bulkMint(address _to, uint256 _numberofTokens) public onlyOwner {
      uint256 detailsLength = _currentTokenId.add(_numberofTokens);
      require(detailsLength <= tsupply);
      for(uint256 i = 0 ; i < detailsLength; i++){
          mintTo(_to);
      }
   }
    
  function burn(uint256 _tokenidentiy) public {
      require(block.timestamp > Time);
      uint256 decimal = SafeMath.pow(10,18);
      uint256 IXI_LOCKED_PER_NFT = SafeMath.mul(GRAVITY_LOCKED, decimal);
      _burn(msg.sender, _tokenidentiy);
      token.transfer(msg.sender, IXI_LOCKED_PER_NFT);
      BurntTokens.push(_tokenidentiy);
      emit NFTBurn(_tokenidentiy, msg.sender, "Burn", block.timestamp);
  }

	uint256 private TS22 = 1650911056;
	uint256 private TS23 = 1672511400;
	uint256 private TS24 = 1704047400;
	uint256 private TS25 = 1735669800;
	uint256 private TS26 = 1767205800;
	uint256 private TS27 = 1798741800;
	uint256 private TS28 = 1830277800;
	uint256 private TS29 = 1861900200;
	uint256 private TS30 = 1893436200;
	uint256 private TS31 = 1924972200;
	uint256 private TS32 = 1956508200;
	uint256 private TS33 = 1988130600;
	uint256 private TS34 = 2019666600;


    struct BookingManager { 
      address _tokenOwner;
      uint _tokenid;
      uint _redeemedNights;
    }    

    BookingManager private RED22;
    BookingManager private RED23;
    BookingManager private RED24;
    BookingManager private RED25;
    BookingManager private RED26;
    BookingManager private RED27;
    BookingManager private RED28;
    BookingManager private RED29;
    BookingManager private RED30;
    BookingManager private RED31;
    BookingManager private RED32;
    BookingManager private RED33;

    function setBookingRED(address _tokenOwner, uint256 _tokenid, uint256 _redeemedNights) public onlyOwner {
        // This Method is used in the case of emergency to reset or set the Records by hotel owner
        if (block.timestamp >= TS22 && block.timestamp < TS23) {
            require(RED22._tokenid == 0, "Booking for RED22 already set");
            RED22 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS23 && block.timestamp < TS24) {
            require(RED23._tokenid == 0, "Booking for RED23 already set");
            RED23 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS24 && block.timestamp < TS25) {
            require(RED24._tokenid == 0, "Booking for RED24 already set");
            RED24 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS25 && block.timestamp < TS26) {
            require(RED25._tokenid == 0, "Booking for RED25 already set");
            RED25 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS26 && block.timestamp < TS27) {
            require(RED26._tokenid == 0, "Booking for RED26 already set");
            RED26 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS27 && block.timestamp < TS28) {
            require(RED27._tokenid == 0, "Booking for RED27 already set");
            RED27 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS28 && block.timestamp < TS29) {
            require(RED28._tokenid == 0, "Booking for RED28 already set");
            RED28 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS29 && block.timestamp < TS30) {
            require(RED29._tokenid == 0, "Booking for RED29 already set");
            RED29 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS30 && block.timestamp < TS31) {
            require(RED30._tokenid == 0, "Booking for RED30 already set");
            RED30 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS31 && block.timestamp < TS32) {
            require(RED31._tokenid == 0, "Booking for RED31 already set");
            RED31 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS32 && block.timestamp < TS33) {
            require(RED32._tokenid == 0, "Booking for RED32 already set");
            RED32 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } else if (block.timestamp >= TS33 && block.timestamp < TS34) {
            require(RED33._tokenid == 0, "Booking for RED33 already set");
            RED33 = BookingManager(_tokenOwner, _tokenid, _redeemedNights);
        } 
    }

    function setInitials(address _sender,uint256 _tokenId) internal {
          RED22 = BookingManager(_sender, _tokenId, 0);
    	    RED23 = BookingManager(_sender, _tokenId, 0);
    	    RED24 = BookingManager(_sender, _tokenId, 0);
    	    RED25 = BookingManager(_sender, _tokenId, 0);
    	    RED26 = BookingManager(_sender, _tokenId, 0);
    	    RED27 = BookingManager(_sender, _tokenId, 0);
    	    RED28 = BookingManager(_sender, _tokenId, 0);
    	    RED29 = BookingManager(_sender, _tokenId, 0);
    	    RED30 = BookingManager(_sender, _tokenId, 0);
    	    RED31 = BookingManager(_sender, _tokenId, 0);
    	    RED32 = BookingManager(_sender, _tokenId, 0);
    	    RED33 = BookingManager(_sender, _tokenId, 0);
    }

    function changeOwnershipRED(uint256 _tokenid) public {
      require(ownerOf(_tokenid) == msg.sender, "INVALID_NEW_OWNER");
      require(block.timestamp > RedeemTimeLimit,"CLAIM_AFTER_REDEEM_TIME_LIMIT");
      require(getTokenOwnerFromRecords(_tokenid) != msg.sender, "CURRENT_OWNER_EXCEPTION");
      approve(msg.sender, _tokenid);

        if (block.timestamp > TS22 && block.timestamp < TS23) {
        	RED22 = BookingManager(msg.sender, _tokenid, RED22._redeemedNights);
    	    RED23 = BookingManager(msg.sender, _tokenid, 0);
    	    RED24 = BookingManager(msg.sender, _tokenid, 0);
    	    RED25 = BookingManager(msg.sender, _tokenid, 0);
    	    RED26 = BookingManager(msg.sender, _tokenid, 0);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS23 && block.timestamp < TS24) {
        	RED23 = BookingManager(msg.sender, _tokenid, RED23._redeemedNights);
    	    RED24 = BookingManager(msg.sender, _tokenid, 0);
    	    RED25 = BookingManager(msg.sender, _tokenid, 0);
    	    RED26 = BookingManager(msg.sender, _tokenid, 0);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS24 &&  block.timestamp < TS25) {
        	RED24 = BookingManager(msg.sender, _tokenid, RED24._redeemedNights);
    	    RED25 = BookingManager(msg.sender, _tokenid, 0);
    	    RED26 = BookingManager(msg.sender, _tokenid, 0);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS25 && block.timestamp < TS26) {
    	    RED25 = BookingManager(msg.sender, _tokenid, RED25._redeemedNights);
    	    RED26 = BookingManager(msg.sender, _tokenid, 0);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS26 && block.timestamp < TS27) {
    	    RED26 = BookingManager(msg.sender, _tokenid, RED26._redeemedNights);
    	    RED27 = BookingManager(msg.sender, _tokenid, 0);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS27 && block.timestamp < TS28) {
    	    RED27 = BookingManager(msg.sender, _tokenid, RED27._redeemedNights);
    	    RED28 = BookingManager(msg.sender, _tokenid, 0);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS28 && block.timestamp < TS29) {
    	    RED28 = BookingManager(msg.sender, _tokenid, RED28._redeemedNights);
    	    RED29 = BookingManager(msg.sender, _tokenid, 0);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS29 && block.timestamp < TS30) {
    	    RED29 = BookingManager(msg.sender, _tokenid, RED29._redeemedNights);
    	    RED30 = BookingManager(msg.sender, _tokenid, 0);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS30 && block.timestamp < TS31) {
    	    RED30 = BookingManager(msg.sender, _tokenid, RED30._redeemedNights);
    	    RED31 = BookingManager(msg.sender, _tokenid, 0);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS31 && block.timestamp < TS32) {
    	    RED31 = BookingManager(msg.sender, _tokenid, RED31._redeemedNights);
    	    RED32 = BookingManager(msg.sender, _tokenid, 0);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS32 && block.timestamp < TS33) {
    	    RED32 = BookingManager(msg.sender, _tokenid, RED32._redeemedNights);
    	    RED33 = BookingManager(msg.sender, _tokenid, 0);
        } else if (block.timestamp > TS33 && block.timestamp < TS34) {
    	    RED33 = BookingManager(msg.sender, _tokenid, RED33._redeemedNights);
        }
        
    }

    function getTokenOwnerFromRecords(uint256 _tokenId) public view returns (address) {
        uint256 currentTimestamp = block.timestamp;
          if (currentTimestamp >= TS22 && currentTimestamp < TS23) {
            require(RED22._tokenid == _tokenId, "Invalid token ID for RED22");
            return RED22._tokenOwner;
          } else if (currentTimestamp >= TS23 && currentTimestamp < TS24) {
            require(RED23._tokenid == _tokenId, "Invalid token ID for RED23");
            return RED23._tokenOwner;
          } else if (currentTimestamp >= TS24 && currentTimestamp < TS25) {
            require(RED24._tokenid == _tokenId, "Invalid token ID for RED24");
            return RED24._tokenOwner;
          } else if (currentTimestamp >= TS25 && currentTimestamp < TS26) {
            require(RED25._tokenid == _tokenId, "Invalid token ID for RED25");
            return RED25._tokenOwner;
          } else if (currentTimestamp >= TS26 && currentTimestamp < TS27) {
            require(RED26._tokenid == _tokenId, "Invalid token ID for RED26");
            return RED26._tokenOwner;
          } else if (currentTimestamp >= TS27 && currentTimestamp < TS28) {
            require(RED27._tokenid == _tokenId, "Invalid token ID for RED27");
            return RED27._tokenOwner;
          } else if (currentTimestamp >= TS28 && currentTimestamp < TS29) {
            require(RED28._tokenid == _tokenId, "Invalid token ID for RED28");
            return RED28._tokenOwner;
          } else if (currentTimestamp >= TS29 && currentTimestamp < TS30) {
            require(RED29._tokenid == _tokenId, "Invalid token ID for RED29");
            return RED29._tokenOwner;
          } else if (currentTimestamp >= TS30 && currentTimestamp < TS31) {
            require(RED30._tokenid == _tokenId, "Invalid token ID for RED30");
            return RED30._tokenOwner;
          } else if (currentTimestamp >= TS31 && currentTimestamp < TS32) {
            require(RED31._tokenid == _tokenId, "Invalid token ID for RED31");
            return RED31._tokenOwner;
          } else if (currentTimestamp >= TS32 && currentTimestamp < TS33) {
            require(RED32._tokenid == _tokenId, "Invalid token ID for RED32");
            return RED32._tokenOwner;
          } else if (currentTimestamp >= TS33 && currentTimestamp < TS34) {
            require(RED33._tokenid == _tokenId, "Invalid token ID for RED33");
            return RED33._tokenOwner;
          } else {
            revert("No RED number available for the current timestamp");
        }
    }

    function getNightsRedeemed(uint256 _tokenId) public view returns (uint256) {
        uint256 currentTimestamp = block.timestamp;
        if (currentTimestamp >= TS22 && currentTimestamp < TS23) {
          require(RED22._tokenid == _tokenId, "Invalid token ID for RED22");
          return RED22._redeemedNights;
        } else if (currentTimestamp >= TS23 && currentTimestamp < TS24) {
            require(RED23._tokenid == _tokenId, "Invalid token ID for RED23");
            return RED23._redeemedNights;
        } else if (currentTimestamp >= TS24 && currentTimestamp < TS25) {
            require(RED24._tokenid == _tokenId, "Invalid token ID for RED24");
            return RED24._redeemedNights;
        } else if (currentTimestamp >= TS25 && currentTimestamp < TS26) {
            require(RED25._tokenid == _tokenId, "Invalid token ID for RED25");
            return RED25._redeemedNights;
        } else if (currentTimestamp >= TS26 && currentTimestamp < TS27) {
            require(RED26._tokenid == _tokenId, "Invalid token ID for RED26");
            return RED26._redeemedNights;
        } else if (currentTimestamp >= TS27 && currentTimestamp < TS28) {
            require(RED27._tokenid == _tokenId, "Invalid token ID for RED27");
            return RED27._redeemedNights;
        } else if (currentTimestamp >= TS28 && currentTimestamp < TS29) {
            require(RED28._tokenid == _tokenId, "Invalid token ID for RED28");
            return RED28._redeemedNights;
        } else if (currentTimestamp >= TS29 && currentTimestamp < TS30) {
            require(RED29._tokenid == _tokenId, "Invalid token ID for RED29");
            return RED29._redeemedNights;
        } else if (currentTimestamp >= TS30 && currentTimestamp < TS31) {
            require(RED30._tokenid == _tokenId, "Invalid token ID for RED30");
            return RED30._redeemedNights;
        } else if (currentTimestamp >= TS31 && currentTimestamp < TS32) {
            require(RED31._tokenid == _tokenId, "Invalid token ID for RED31");
            return RED31._redeemedNights;
        } else if (currentTimestamp >= TS32 && currentTimestamp < TS33) {
            require(RED32._tokenid == _tokenId, "Invalid token ID for RED32");
            return RED32._redeemedNights;
        } else if (currentTimestamp >= TS33 && currentTimestamp < TS34) {
            require(RED33._tokenid == _tokenId, "Invalid token ID for RED33");
            return RED33._redeemedNights;
        } else {
            revert("No RED number available for the current timestamp");
        }
    }

    function updateRedeemedNights(address _tokenOwner, uint256 _nights, uint256 _flag) internal {
        uint256 currentTimestamp = block.timestamp;
        if (currentTimestamp >= TS22 && currentTimestamp < TS23) {
            require(RED22._tokenOwner == _tokenOwner, "Invalid token owner for RED22");
            if (_flag == 1) {
                RED22._redeemedNights += _nights;
                } else if (_flag == 0) {
                RED22._redeemedNights -= _nights;
                }
        } else if (currentTimestamp >= TS23 && currentTimestamp < TS24) {
            require(RED23._tokenOwner == _tokenOwner, "Invalid token owner for RED23");
            if (_flag == 1) {
                RED23._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED23._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS24 && currentTimestamp < TS25) {
            require(RED24._tokenOwner == _tokenOwner, "Invalid token owner for RED24");
            if (_flag == 1) {
                RED24._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED24._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS25 && currentTimestamp < TS26) {
            require(RED25._tokenOwner == _tokenOwner, "Invalid token owner for RED25");
            if (_flag == 1) {
                RED25._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED25._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS26 && currentTimestamp < TS27) {
            require(RED26._tokenOwner == _tokenOwner, "Invalid token owner for RED26");
            if (_flag == 1) {
                RED26._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED26._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS27 && currentTimestamp < TS28) {
            require(RED27._tokenOwner == _tokenOwner, "Invalid token owner for RED27");
            if (_flag == 1) {
                RED27._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED27._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS28 && currentTimestamp < TS29) {
            require(RED28._tokenOwner == _tokenOwner, "Invalid token owner for RED28");
            if (_flag == 1) {
                RED28._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED28._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS29 && currentTimestamp < TS30) {
            require(RED29._tokenOwner == _tokenOwner, "Invalid token owner for RED29");
            if (_flag == 1) {
              RED29._redeemedNights += _nights;
            } else if (_flag == 0) {
              RED29._redeemedNights -= _nights;
            }
        else if (currentTimestamp >= TS30 && currentTimestamp < TS31) {
        require(RED30._tokenOwner == _tokenOwner, "Invalid token owner for RED30");
            if (_flag == 1) {
                RED30._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED30._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS31 && currentTimestamp < TS32) {
        require(RED31._tokenOwner == _tokenOwner, "Invalid token owner for RED31");
            if (_flag == 1) {
                RED31._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED31._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS32 && currentTimestamp < TS33) {
        require(RED32._tokenOwner == _tokenOwner, "Invalid token owner for RED32");
            if (_flag == 1) {
                RED32._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED32._redeemedNights -= _nights;
            }
        } else if (currentTimestamp >= TS33 && currentTimestamp < TS34) {
        require(RED33._tokenOwner == _tokenOwner, "Invalid token owner for RED33");
            if (_flag == 1) {
                RED33._redeemedNights += _nights;
            } else if (_flag == 0) {
                RED33._redeemedNights -= _nights;
            }
        } else {
            revert("No RED number available for the current timestamp");
        }
        }
    }

    function redeemNights(uint256 _tokenidentiy, uint256 _numberDays) public {
        require(ownerOf(_tokenidentiy) == msg.sender, "Only NFT owner can redeem nights");
        require(getTokenOwnerFromRecords(_tokenidentiy) == msg.sender, "CLAIM_OWNERSHIP_RIGHTS");
        uint256 nRED = getNightsRedeemed(_tokenidentiy) + _numberDays;
        require(nRED < MAX);
        uint256 decimal = SafeMath.pow(10, 18);
        uint256 IXI_PER_REDEEM = SafeMath.mul(_numberDays, decimal);
        token.transfer(msg.sender, IXI_PER_REDEEM);
        updateRedeemedNights(msg.sender, _numberDays, 1);
        emit RedeemNights(msg.sender,"REDEEM_SUCCESS", _numberDays, block.timestamp);
    }

    function refundNights(uint256 _tokenidentiy, address _customerAddress, uint256 _numberDays) public returns(string memory) {
        require(msg.sender == propertyowner, "Only Hotel Owner can revert the nights");
        require(ownerOf(_tokenidentiy) == _customerAddress);

        uint256 nRED = getNightsRedeemed(_tokenidentiy);
        if(nRED > _numberDays ){
            uint256 decimal = SafeMath.pow(10, 18);
            uint256 IXI_PER_REFUND = SafeMath.mul(_numberDays, decimal);
            token.transfer(_customerAddress, IXI_PER_REFUND);
            updateRedeemedNights(_customerAddress, _numberDays, 0);
            emit RefundNights(msg.sender, "REFUND_SUCCESS", _tokenidentiy, block.timestamp);
            return("REFUND_SUCCESSFUL");
        }else if(nRED == _numberDays){
            uint256 decimal = SafeMath.pow(10, 18);
            uint256 IXI_PER_REFUND = SafeMath.mul(_numberDays, decimal);
            token.transfer(_customerAddress, IXI_PER_REFUND);
            updateRedeemedNights(_customerAddress, _numberDays, 0);
            emit RefundNights(_customerAddress, "REFUND_SUCCESS", _tokenidentiy, block.timestamp);
            return("REFUND_SUCCESSFUL");
        }else {
            emit RefundNights(_customerAddress, "REFUND_FAILED", _tokenidentiy, block.timestamp);
            return("INVALID_NUMBER_OF_NIGHTS");
        }

    }
    
  
  function _getDetails() public view returns(string memory _IPFS_HASH, string memory _metadataDetails) {
    (_IPFS_HASH, _metadataDetails) = (IPFS_HASH, metadataDetails);
    return (_IPFS_HASH, _metadataDetails);                
  } 

  function _setDetails(string memory _IPFS_HASH, string memory _metadataDetails) public onlyOwner {
    IPFS_HASH = _IPFS_HASH; 
    metadataDetails = _metadataDetails; 
  } 
  
  function _incrementTokenId() private  {
    _currentTokenId++;
  }
  
  function tokenURI(uint256 _tokenId) external view returns (string memory) {
    return Strings.strConcat(
        baseTokenURI(),
        Strings.uint2str(_tokenId)
    );
  }
  
  function baseTokenURI() public view returns (string memory) {
    return _baseTokenURI;
  }

  function setBaseTokenURI(string memory uri) public onlyOwner {
    _baseTokenURI = uri;
  }


}

// File: contracts/STAYNEX.sol

contract STAYNEX_GENISIS is STAYNEXGENESIS  {

  constructor() STAYNEXGENESIS("STAYNEXNFT", "SNX", 1000, "0.10.15", 10000, 0x48ecD647A2Bb9e736D16fBc63A59Cf4Bc6Fdf83a, 1692717810, 1692717810, 10,"https://staynex.io") public {
  }

}
 