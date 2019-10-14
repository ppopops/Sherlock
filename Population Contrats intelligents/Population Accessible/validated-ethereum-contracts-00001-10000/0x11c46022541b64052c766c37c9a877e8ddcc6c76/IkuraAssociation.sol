// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.4.23;

// import 'ds-auth/auth.sol';
contract DSAuthority {
    function canCall(
        address src, address dst, bytes4 sig
    ) public view returns (bool);
}

contract DSAuthEvents {
    event LogSetAuthority (address indexed authority);
    event LogSetOwner     (address indexed owner);
}

contract DSAuth is DSAuthEvents {
    DSAuthority  public  authority;
    address      public  owner;

    constructor() public {
        owner = msg.sender;
        emit LogSetOwner(msg.sender);
    }

    function setOwner(address owner_)
        public
        auth
    {
        owner = owner_;
        emit LogSetOwner(owner);
    }

    function setAuthority(DSAuthority authority_)
        public
        auth
    {
        authority = authority_;
        emit LogSetAuthority(authority);
    }

    modifier auth {
        require(isAuthorized(msg.sender, msg.sig));
        _;
    }

    function isAuthorized(address src, bytes4 sig) internal view returns (bool) {
        if (src == address(this)) {
            return true;
        } else if (src == owner) {
            return true;
        } else if (authority == DSAuthority(0)) {
            return false;
        } else {
            return authority.canCall(src, this, sig);
        }
    }
}

// import 'ds-math/math.sol';
contract DSMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x);
    }
    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x);
    }
    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function min(uint x, uint y) internal pure returns (uint z) {
        return x <= y ? x : y;
    }
    function max(uint x, uint y) internal pure returns (uint z) {
        return x >= y ? x : y;
    }
    function imin(int x, int y) internal pure returns (int z) {
        return x <= y ? x : y;
    }
    function imax(int x, int y) internal pure returns (int z) {
        return x >= y ? x : y;
    }

    uint constant WAD = 10 ** 18;
    uint constant RAY = 10 ** 27;

    function wmul(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, y), WAD / 2) / WAD;
    }
    function rmul(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, y), RAY / 2) / RAY;
    }
    function wdiv(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, WAD), y / 2) / y;
    }
    function rdiv(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, RAY), y / 2) / y;
    }

    // This famous algorithm is called "exponentiation by squaring"
    // and calculates x^n with x as fixed-point and n as regular unsigned.
    //
    // It's O(log n), instead of O(n) for naive repeated multiplication.
    //
    // These facts are why it works:
    //
    //  If n is even, then x^n = (x^2)^(n/2).
    //  If n is odd,  then x^n = x * x^(n-1),
    //   and applying the equation for even x gives
    //    x^n = x * (x^2)^((n-1) / 2).
    //
    //  Also, EVM division is flooring and
    //    floor[(n-1) / 2] = floor[n / 2].
    //
    function rpow(uint x, uint n) internal pure returns (uint z) {
        z = n % 2 != 0 ? x : RAY;

        for (n /= 2; n != 0; n /= 2) {
            x = rmul(x, x);

            if (n % 2 != 0) {
                z = rmul(z, x);
            }
        }
    }
}

// import './IkuraStorage.sol';
/**
 *
 * ????????????????????????????
 *
 */
contract IkuraStorage is DSMath, DSAuth {
  // ???????????????
  address[] ownerAddresses;

  // ??????dJPY?????
  mapping(address => uint) coinBalances;

  // ??????SHINJI token?????
  mapping(address => uint) tokenBalances;

  // ???????????????????????????
  mapping(address => mapping (address => uint)) coinAllowances;

  // dJPY????
  uint _totalSupply = 0;

  // ????
  // 0.01pips = 1
  // ?). ???? 0.05% ?????? 500
  uint _transferFeeRate = 500;

  // ??????
  // 1 = 1dJPY
  // amount * ?????????????????????????????????????????????
  uint8 _transferMinimumFee = 5;

  address tokenAddress;
  address multiSigAddress;
  address authorityAddress;

  // @NOTE ??????contract?deploy -> watch contract -> setOwner????
  //??????????????controller??????????????????????
  // ???????????????????????????
  constructor() public DSAuth() {
    /*address controllerAddress = 0x34c5605A4Ef1C98575DB6542179E55eE1f77A188;
    owner = controllerAddress;
    LogSetOwner(controllerAddress);*/
  }

  function changeToken(address tokenAddress_) public auth {
    tokenAddress = tokenAddress_;
  }

  function changeAssociation(address multiSigAddress_) public auth {
    multiSigAddress = multiSigAddress_;
  }

  function changeAuthority(address authorityAddress_) public auth {
    authorityAddress = authorityAddress_;
  }

  // --------------------------------------------------
  // functions for _totalSupply
  // --------------------------------------------------

  /**
   * ???????
   *
   * @return ????
   */
  function totalSupply() public view auth returns (uint) {
    return _totalSupply;
  }

  /**
   * ?????????mint???????????????
   *
   * @param amount ???
   */
  function addTotalSupply(uint amount) public auth {
    _totalSupply = add(_totalSupply, amount);
  }

  /**
   * ?????????burn???????????????
   *
   * @param amount ???
   */
  function subTotalSupply(uint amount) public auth {
    _totalSupply = sub(_totalSupply, amount);
  }

  // --------------------------------------------------
  // functions for _transferFeeRate
  // --------------------------------------------------

  /**
   * ???????
   *
   * @return ???????
   */
  function transferFeeRate() public view auth returns (uint) {
    return _transferFeeRate;
  }

  /**
   * ?????????
   *
   * @param newTransferFeeRate ???????
   *
   * @return ????????true??????false?????????????????
   */
  function setTransferFeeRate(uint newTransferFeeRate) public auth returns (bool) {
    _transferFeeRate = newTransferFeeRate;

    return true;
  }

  // --------------------------------------------------
  // functions for _transferMinimumFee
  // --------------------------------------------------

  /**
   * ???????
   *
   * @return ????????
   */
  function transferMinimumFee() public view auth returns (uint8) {
    return _transferMinimumFee;
  }

  /**
   * ??????????
   *
   * @param newTransferMinimumFee ????????
   *
   * @return ????????true??????false?????????????????
   */
  function setTransferMinimumFee(uint8 newTransferMinimumFee) public auth {
    _transferMinimumFee = newTransferMinimumFee;
  }

  // --------------------------------------------------
  // functions for ownerAddresses
  // --------------------------------------------------

  /**
   * ?????????????????????????
   *
   * ?????????????????????????????????
   * ???????? = ?????????????????????????????????
   * ??????????????????????????????????????????
   *
   * @param addr ?????????
   *
   * @return ????????true??????false
   */
  function addOwnerAddress(address addr) internal returns (bool) {
    ownerAddresses.push(addr);

    return true;
  }

  /**
   * ??????????????????????????
   *
   * ?????????????????????????????????
   *
   * @param addr ?????????????????
   *
   * @return ????????true??????false
   */
  function removeOwnerAddress(address addr) internal returns (bool) {
    uint i = 0;

    while (ownerAddresses[i] != addr) { i++; }

    while (i < ownerAddresses.length - 1) {
      ownerAddresses[i] = ownerAddresses[i + 1];
      i++;
    }

    ownerAddresses.length--;

    return true;
  }

  /**
   * ????????contract?deploy???????????????
   *
   * @return ????????????
   */
  function primaryOwner() public view auth returns (address) {
    return ownerAddresses[0];
  }

  /**
   * ????????????????????????????
   *
   * @param addr ?????????
   *
   * @return ??????????????true???????????false
   */
  function isOwnerAddress(address addr) public view auth returns (bool) {
    for (uint i = 0; i < ownerAddresses.length; i++) {
      if (ownerAddresses[i] == addr) return true;
    }

    return false;
  }

  /**
   * ????????
   *
   * @return ?????
   */
  function numOwnerAddress() public view auth returns (uint) {
    return ownerAddresses.length;
  }

  // --------------------------------------------------
  // functions for coinBalances
  // --------------------------------------------------

  /**
   * ?????????dJPY?????
   *
   * @param addr ?????????
   *
   * @return dJPY??
   */
  function coinBalance(address addr) public view auth returns (uint) {
    return coinBalances[addr];
  }

  /**
   * ?????????dJPY???????
   *
   * @param addr ?????????
   * @param amount ??
   *
   * @return ????????true??????false
   */
  function addCoinBalance(address addr, uint amount) public auth returns (bool) {
    coinBalances[addr] = add(coinBalances[addr], amount);

    return true;
  }

  /**
   * ?????????dJPY???????
   *
   * @param addr ?????????
   * @param amount ??
   *
   * @return ????????true??????false
   */
  function subCoinBalance(address addr, uint amount) public auth returns (bool) {
    coinBalances[addr] = sub(coinBalances[addr], amount);

    return true;
  }

  // --------------------------------------------------
  // functions for tokenBalances
  // --------------------------------------------------

  /**
   * ?????????SHINJI??????????
   *
   * @param addr ?????????
   *
   * @return SHINJI??????
   */
  function tokenBalance(address addr) public view auth returns (uint) {
    return tokenBalances[addr];
  }

  /**
   * ?????????SHINJI???????????
   *
   * @param addr ?????????
   * @param amount ??
   *
   * @return ????????true??????false
   */
  function addTokenBalance(address addr, uint amount) public auth returns (bool) {
    tokenBalances[addr] = add(tokenBalances[addr], amount);

    if (tokenBalances[addr] > 0 && !isOwnerAddress(addr)) {
      addOwnerAddress(addr);
    }

    return true;
  }

  /**
   * ?????????SHINJI???????????
   *
   * @param addr ?????????
   * @param amount ??
   *
   * @return ????????true??????false
   */
  function subTokenBalance(address addr, uint amount) public auth returns (bool) {
    tokenBalances[addr] = sub(tokenBalances[addr], amount);

    if (tokenBalances[addr] <= 0) {
      removeOwnerAddress(addr);
    }

    return true;
  }

  // --------------------------------------------------
  // functions for coinAllowances
  // --------------------------------------------------

  /**
   * ?????????
   *
   * @param owner_ ???
   * @param spender ?????
   *
   * @return ??????
   */
  function coinAllowance(address owner_, address spender) public view auth returns (uint) {
    return coinAllowances[owner_][spender];
  }

  /**
   * ??????????????????
   *
   * @param owner_ ???
   * @param spender ?????
   * @param amount ??
   *
   * @return ????????true??????false
   */
  function addCoinAllowance(address owner_, address spender, uint amount) public auth returns (bool) {
    coinAllowances[owner_][spender] = add(coinAllowances[owner_][spender], amount);

    return true;
  }

  /**
   * ??????????????????
   *
   * @param owner_ ???
   * @param spender ?????
   * @param amount ??
   *
   * @return ????????true??????false
   */
  function subCoinAllowance(address owner_, address spender, uint amount) public auth returns (bool) {
    coinAllowances[owner_][spender] = sub(coinAllowances[owner_][spender], amount);

    return true;
  }

  /**
   * ?????????????????
   *
   * @param owner_ ???
   * @param spender ?????
   * @param amount ??????
   *
   * @return ????????true??????false
   */
  function setCoinAllowance(address owner_, address spender, uint amount) public auth returns (bool) {
    coinAllowances[owner_][spender] = amount;

    return true;
  }

  /**
   * ??????????override
   *
   * @param src ???????
   * @param sig ????????
   *
   * @return ???????????true????????false
   */
  function isAuthorized(address src, bytes4 sig) internal view returns (bool) {
    sig; // #HACK

    return  src == address(this) ||
            src == owner ||
            src == tokenAddress ||
            src == authorityAddress ||
            src == multiSigAddress;
  }
}


// import './IkuraTokenEvent.sol';
/**
 * Token??????????????
 *
 * - ERC20??????????Transfer / Approval?
 * - IkuraToken????????TransferToken / TransferFee?
 */
contract IkuraTokenEvent {
  /** ?????dJPY??????????????? */
  event IkuraMint(address indexed owner, uint);

  /** ?????dJPY??????????????? */
  event IkuraBurn(address indexed owner, uint);

  /** ????????????????? */
  event IkuraTransferToken(address indexed from, address indexed to, uint value);

  /** ??????????????????? */
  event IkuraTransferFee(address indexed from, address indexed to, address indexed owner, uint value);

  /**
   * ???????????????????????????
   * controller????????????????????????IkuraToken????????????????????????????
   */
  event IkuraTransfer(address indexed from, address indexed to, uint value);

  /** ???????? */
  event IkuraApproval(address indexed owner, address indexed spender, uint value);
}


// import './IkuraToken.sol';
/**
 *
 * ????????
 *
 */
contract IkuraToken is IkuraTokenEvent, DSMath, DSAuth {
  //
  // constants
  //

  // ????
  // 0.01pips = 1
  // ?). ???? 0.05% ?????? 500
  uint _transferFeeRate = 0;

  // ??????
  // 1 = 1dJPY
  // amount * ?????????????????????????????????????????????
  uint8 _transferMinimumFee = 0;

  // ?????????
  uint _logicVersion = 2;

  //
  // libraries
  //

  /*using ProposalLibrary for ProposalLibrary.Entity;
  ProposalLibrary.Entity proposalEntity;*/

  //
  // private
  //

  // ????????????
  IkuraStorage _storage;
  IkuraAssociation _association;

  constructor() DSAuth() public {
    // @NOTE ??????contract?deploy -> watch contract -> setOwner????
    //??????????????controller??????????????????????
    // ???????????????????????????
    /*address controllerAddress = 0x34c5605A4Ef1C98575DB6542179E55eE1f77A188;
    owner = controllerAddress;
    LogSetOwner(controllerAddress);*/
  }

  // ----------------------------------------------------------------------------------------------------
  // ???ERC20???????
  // ----------------------------------------------------------------------------------------------------

  /**
   * ERC20 Token Standard???????
   *
   * dJPY???????
   *
   * @return ???
   */
  function totalSupply(address sender) public view returns (uint) {
    sender; // #HACK

    return _storage.totalSupply();
  }

  /**
   * ERC20 Token Standard???????
   *
   * ????????dJPY?????
   *
   * @param sender ??????
   * @param addr ????
   *
   * @return ?????????dJPY??
   */
  function balanceOf(address sender, address addr) public view returns (uint) {
    sender; // #HACK

    return _storage.coinBalance(addr);
  }

  /**
   * ERC20 Token Standard???????
   *
   * ????????????dJPY?????
   * ??????????????
   *
   * - ???????????? >= ???
   * - ??? > 0
   * - ??????????? + ??? > ????????????overflow?????????
   *
   * @param sender ???????
   * @param to ????????
   * @param amount ???
   *
   * @return ?????????????????true????????false
   */
  function transfer(address sender, address to, uint amount) public auth returns (bool success) {
    uint fee = transferFee(sender, sender, to, amount);
    uint totalAmount = add(amount, fee);

    require(_storage.coinBalance(sender) >= totalAmount);
    require(amount > 0);

    // ????????amount + fee?????????
    _storage.subCoinBalance(sender, totalAmount);

    // to????amount???????
    _storage.addCoinBalance(to, amount);

    if (fee > 0) {
      // ????????????????????
      address owner = selectOwnerAddressForTransactionFee(sender);

      // ????????fee???????
      _storage.addCoinBalance(owner, fee);
    }

    return true;
  }

  /**
   * ERC20 Token Standard???????
   *
   * from????????????to???????????amount????????
   * ??????????????????????????????????????????????????
   * ?????from??????????????????????????????????????????
   * ?????????approve?????????????
   *
   * ???????????????????
   *
   * - ?????? >= ??
   * - ?????? > 0
   * - ??????????????????? >= ??????
   * - ?????? + ?? > ???????overflow?????????
   # - ???????????????? >= ????????
   *
   * @param sender ??????
   * @param from ???????
   * @param to ???????
   * @param amount ???
   *
   * @return ?????????????????true????????false
   */
  function transferFrom(address sender, address from, address to, uint amount) public auth returns (bool success) {
    uint fee = transferFee(sender, from, to, amount);

    require(_storage.coinBalance(from) >= amount);
    require(_storage.coinAllowance(from, sender) >= amount);
    require(amount > 0);
    require(add(_storage.coinBalance(to), amount) > _storage.coinBalance(to));

    if (fee > 0) {
      require(_storage.coinBalance(sender) >= fee);

      // ????????????????????
      address owner = selectOwnerAddressForTransactionFee(sender);

      // ????????????????????????????????
      _storage.subCoinBalance(sender, fee);

      _storage.addCoinBalance(owner, fee);
    }

    // ???????????
    _storage.subCoinBalance(from, amount);

    // ??????????????
    _storage.subCoinAllowance(from, sender, amount);

    // ???????????
    _storage.addCoinBalance(to, amount);

    return true;
  }

  /**
   * ERC20 Token Standard???????
   *
   * spender????????????sender??????amount????????????
   * ????????????????????????
   *
   * @param sender ??????
   * @param spender ???????
   * @param amount ???
   *
   * @return ????true???
   */
  function approve(address sender, address spender, uint amount) public auth returns (bool success) {
    _storage.setCoinAllowance(sender, spender, amount);

    return true;
  }

  /**
   * ERC20 Token Standard???????
   *
   * ????????????????????????
   *
   * @param sender ??????
   * @param owner ??????????
   * @param spender ?????????
   *
   * @return ??????????
   */
  function allowance(address sender, address owner, address spender) public view returns (uint remaining) {
    sender; // #HACK

    return _storage.coinAllowance(owner, spender);
  }

  // ----------------------------------------------------------------------------------------------------
  // ???ERC20???????
  // ----------------------------------------------------------------------------------------------------

  /**
   * ????????SHINJI?????
   *
   * @param sender ??????
   * @param owner ????
   *
   * @return ?????????SHINJI?????
   */
  function tokenBalanceOf(address sender, address owner) public view returns (uint balance) {
    sender; // #HACK

    return _storage.tokenBalance(owner);
  }

  /**
   * ????????????SHINJI?????????
   *
   * - ?????????? >= ?????
   * - ????????? > 0
   * - ?????? + ?? > ???????overflow??????
   *
   * @param sender ??????
   * @param to ????????
   * @param amount ???
   *
   * @return ?????????????????true????????false
   */
  function transferToken(address sender, address to, uint amount) public auth returns (bool success) {
    require(_storage.tokenBalance(sender) >= amount);
    require(amount > 0);
    require(add(_storage.tokenBalance(to), amount) > _storage.tokenBalance(to));

    _storage.subTokenBalance(sender, amount);
    _storage.addTokenBalance(to, amount);

    emit IkuraTransferToken(sender, to, amount);

    return true;
  }

  /**
   * ????????????????????????????????????
   * ????????????????????????????????max?????
   *
   * @param sender ??????
   * @param from ???
   * @param to ???
   * @param amount ????
   *
   * @return ?????
   */
  function transferFee(address sender, address from, address to, uint amount) public view returns (uint) {
    sender; from; to; // #avoid warning
    if (_transferFeeRate > 0) {
      uint denominator = 1000000; // 0.01 pips ??? 100 * 100 * 100 ? 100?
      uint numerator = mul(amount, _transferFeeRate);

      uint fee = numerator / denominator;
      uint remainder = sub(numerator, mul(denominator, fee));

      // ????????fee?1???
      if (remainder > 0) {
        fee++;
      }

      if (fee < _transferMinimumFee) {
        fee = _transferMinimumFee;
      }

      return fee;
    } else {
      return 0;
    }
  }

  /**
   * ???????
   *
   * @param sender ??????
   *
   * @return ????
   */
  function transferFeeRate(address sender) public view returns (uint) {
    sender; // #HACK

    return _transferFeeRate;
  }

  /**
   * ?????????
   *
   * @param sender ??????
   *
   * @return ??????
   */
  function transferMinimumFee(address sender) public view returns (uint8) {
    sender; // #HACK

    return _transferMinimumFee;
  }

  /**
   * ???????????????
   * #TODO ?????????????????????????????
   *
   * @param sender ??????
   * @return ?????????
   */
  function selectOwnerAddressForTransactionFee(address sender) public view returns (address) {
    sender; // #HACK

    return _storage.primaryOwner();
  }

  /**
   * dJPY?????
   *
   * - ????????????????????
   * - ??????0?????
   *
   * ???????
   *
   * @param sender ??????
   * @param amount ??????
   */
  function mint(address sender, uint amount) public auth returns (bool) {
    require(amount > 0);

    _association.newProposal(keccak256('mint'), sender, amount, '');

    return true;
    /*return proposalEntity.mint(sender, amount);*/
  }

  /**
   * dJPY?????
   *
   * - ????????????????????
   * - ??????0?????
   * - dJPY????amount??????
   * - SHINJI?amount??????
   *
   * ???????
   *
   * @param sender ??????
   * @param amount ??????
   */
  function burn(address sender, uint amount) public auth returns (bool) {
    require(amount > 0);
    require(_storage.coinBalance(sender) >= amount);
    require(_storage.tokenBalance(sender) >= amount);

    _association.newProposal(keccak256('burn'), sender, amount, '');

    return true;
    /*return proposalEntity.burn(sender, amount);*/
  }

  /**
   * ????????
   * #TODO proposalId???????????????proposal???????????
   */
  function confirmProposal(address sender, bytes32 type_, uint proposalId) public auth {
    _association.confirmProposal(type_, sender, proposalId);
    /*proposalEntity.confirmProposal(sender, type_, proposalId);*/
  }

  /**
   * ???????????????
   *
   * @param type_ ??????'mint' | 'burn' | 'transferMinimumFee' | 'transferFeeRate'?
   *
   * @return ??????????????????
   */
  function numberOfProposals(bytes32 type_) public view returns (uint) {
    return _association.numberOfProposals(type_);
    /*return proposalEntity.numberOfProposals(type_);*/
  }

  /**
   * ????????????????
   *
   * @param association_ ?????????
   */
  function changeAssociation(address association_) public auth returns (bool) {
    _association = IkuraAssociation(association_);
    return true;
  }

  /**
   * ?????????????
   *
   * @param storage_ ?????????????????????
   */
  function changeStorage(address storage_) public auth returns (bool) {
    _storage = IkuraStorage(storage_);
    return true;
  }

  /**
   * ?????????????
   *
   * @param sender ???????????
   *
   * @return ???????
   */
  function logicVersion(address sender) public view returns (uint) {
    sender; // #HACK

    return _logicVersion;
  }
}

/**
 * ?????SHINJI Token??????????????????????????
 */
contract IkuraAssociation is DSMath, DSAuth {
  //
  // public
  //

  // ????????????????????
  uint public confirmTotalTokenThreshold = 50;

  //
  // private
  //

  // ????????????
  IkuraStorage _storage;
  IkuraToken _token;

  // ????
  Proposal[] mintProposals;
  Proposal[] burnProposals;

  mapping (bytes32 => Proposal[]) proposals;

  struct Proposal {
    address proposer;                     // ???
    bytes32 digest;                       // ??????
    bool executed;                        // ?????
    uint createdAt;                       // ??????
    uint expireAt;                        // ???????
    address[] confirmers;                 // ???
    uint amount;                          // ???
  }

  //
  // Events
  //

  event MintProposalAdded(uint proposalId, address proposer, uint amount);
  event MintConfirmed(uint proposalId, address confirmer, uint amount);
  event MintExecuted(uint proposalId, address proposer, uint amount);

  event BurnProposalAdded(uint proposalId, address proposer, uint amount);
  event BurnConfirmed(uint proposalId, address confirmer, uint amount);
  event BurnExecuted(uint proposalId, address proposer, uint amount);

  constructor() public {
    proposals[keccak256('mint')] = mintProposals;
    proposals[keccak256('burn')] = burnProposals;

    // @NOTE ??????contract?deploy -> watch contract -> setOwner????
    //??????????????controller??????????????????????
    // ???????????????????????????
    /*address controllerAddress = 0x34c5605A4Ef1C98575DB6542179E55eE1f77A188;
    owner = controllerAddress;
    LogSetOwner(controllerAddress);*/
  }

  /**
   * ?????????????
   *
   * @param newStorage ?????????????????????
   */
  function changeStorage(IkuraStorage newStorage) public auth returns (bool) {
    _storage = newStorage;
    return true;
  }

  function changeToken(IkuraToken token_) public auth returns (bool) {
    _token = token_;
    return true;
  }

  /**
   * ???????
   *
   * @param proposer ????????
   * @param amount ???
   */
  function newProposal(bytes32 type_, address proposer, uint amount, bytes transationBytecode) public returns (uint) {
    uint proposalId = proposals[type_].length++;
    Proposal storage proposal = proposals[type_][proposalId];
    proposal.proposer = proposer;
    proposal.amount = amount;
    proposal.digest = keccak256(proposer, amount, transationBytecode);
    proposal.executed = false;
    proposal.createdAt = now;
    proposal.expireAt = proposal.createdAt + 86400;

    // ???????????????????
    // @NOTE literal_string?bytes????????????keccak256?????????????
    if (type_ == keccak256('mint')) emit MintProposalAdded(proposalId, proposer, amount);
    if (type_ == keccak256('burn')) emit BurnProposalAdded(proposalId, proposer, amount);

    // ???????
    confirmProposal(type_, proposer, proposalId);

    return proposalId;
  }

  /**
   * ??????????????????
   *
   * @param type_ ?????
   * @param confirmer ????????
   * @param proposalId ??ID
   */
  function confirmProposal(bytes32 type_, address confirmer, uint proposalId) public {
    Proposal storage proposal = proposals[type_][proposalId];

    // ????????????????
    require(!hasConfirmed(type_, confirmer, proposalId));

    // ???????????????
    proposal.confirmers.push(confirmer);

    // ???????????????????
    // @NOTE literal_string?bytes????????????keccak256?????????????
    if (type_ == keccak256('mint')) emit MintConfirmed(proposalId, confirmer, proposal.amount);
    if (type_ == keccak256('burn')) emit BurnConfirmed(proposalId, confirmer, proposal.amount);

    if (isProposalExecutable(type_, proposalId, proposal.proposer, '')) {
      proposal.executed = true;

      // ???????????????????
      // @NOTE literal_string?bytes????????????keccak256?????????????
      if (type_ == keccak256('mint')) executeMintProposal(proposalId);
      if (type_ == keccak256('burn')) executeBurnProposal(proposalId);
    }
  }

  /**
   * ????????????????
   *
   * @param type_ ?????
   * @param addr ????????
   * @param proposalId ??ID
   *
   * @return ????????true????????false
   */
  function hasConfirmed(bytes32 type_, address addr, uint proposalId) internal view returns (bool) {
    Proposal storage proposal = proposals[type_][proposalId];
    uint length = proposal.confirmers.length;

    for (uint i = 0; i < length; i++) {
      if (proposal.confirmers[i] == addr) return true;
    }

    return false;
  }

  /**
   * ?????????????????????
   *
   * @param type_ ?????
   * @param proposalId ??ID
   *
   * @return ?????????????
   */
  function confirmedTotalToken(bytes32 type_, uint proposalId) internal view returns (uint) {
    Proposal storage proposal = proposals[type_][proposalId];
    uint length = proposal.confirmers.length;
    uint total = 0;

    for (uint i = 0; i < length; i++) {
      total = add(total, _storage.tokenBalance(proposal.confirmers[i]));
    }

    return total;
  }

  /**
   * ??????????????
   *
   * @param type_ ?????
   * @param proposalId ??ID
   *
   * @return ???????
   */
  function proposalExpireAt(bytes32 type_, uint proposalId) public view returns (uint) {
    Proposal storage proposal = proposals[type_][proposalId];
    return proposal.expireAt;
  }

  /**
   * ??????????????????
   *
   * ??????
   * - ?????????
   * - ???????????
   * - ????????????????????
   *
   * @param proposalId ??ID
   *
   * @return ??????????????true?????????false
   */
  function isProposalExecutable(bytes32 type_, uint proposalId, address proposer, bytes transactionBytecode) internal view returns (bool) {
    Proposal storage proposal = proposals[type_][proposalId];

    // ?????controller???????????????????
    if (_storage.numOwnerAddress() < 2) {
      return true;
    }

    return  proposal.digest == keccak256(proposer, proposal.amount, transactionBytecode) &&
            isProposalNotExpired(type_, proposalId) &&
            mul(100, confirmedTotalToken(type_, proposalId)) / _storage.totalSupply() > confirmTotalTokenThreshold;
  }

  /**
   * ???????????????
   *
   * @param type_ ??????'mint' | 'burn' | 'transferMinimumFee' | 'transferFeeRate'?
   *
   * @return ??????????????????
   */
  function numberOfProposals(bytes32 type_) public constant returns (uint) {
    return proposals[type_].length;
  }

  /**
   * ??????????????????????
   *
   * @param type_ ??????'mint' | 'burn' | 'transferMinimumFee' | 'transferFeeRate'?
   *
   * @return ???
   */
  function numberOfActiveProposals(bytes32 type_) public view returns (uint) {
    uint numActiveProposal = 0;

    for(uint i = 0; i < proposals[type_].length; i++) {
      if (isProposalNotExpired(type_, i)) {
        numActiveProposal++;
      }
    }

    return numActiveProposal;
  }

  /**
   * ?????????????????????
   *
   * - ????????
   * - ???????????
   *
   * ????true???
   */
  function isProposalNotExpired(bytes32 type_, uint proposalId) internal view returns (bool) {
    Proposal storage proposal = proposals[type_][proposalId];

    return  !proposal.executed &&
            now < proposal.expireAt;
  }

  /**
   * dJPY?????
   *
   * - ??????0?????
   *
   * ???????
   *
   * @param proposalId ??ID
   */
  function executeMintProposal(uint proposalId) internal returns (bool) {
    Proposal storage proposal = proposals[keccak256('mint')][proposalId];

    // ????????????????
    require(proposal.amount > 0);

    emit MintExecuted(proposalId, proposal.proposer, proposal.amount);

    // ???? / ????dJPY / ????SHINJI token????
    _storage.addTotalSupply(proposal.amount);
    _storage.addCoinBalance(proposal.proposer, proposal.amount);
    _storage.addTokenBalance(proposal.proposer, proposal.amount);

    return true;
  }

  /**
   * dJPY?????
   *
   * - ??????0?????
   * - ????????dJPY????amount??
   * - ????????SHINJI?amount??????
   *
   * ???????
   *
   * @param proposalId ??ID
   */
  function executeBurnProposal(uint proposalId) internal returns (bool) {
    Proposal storage proposal = proposals[keccak256('burn')][proposalId];

    // ????????????????
    require(proposal.amount > 0);
    require(_storage.coinBalance(proposal.proposer) >= proposal.amount);
    require(_storage.tokenBalance(proposal.proposer) >= proposal.amount);

    emit BurnExecuted(proposalId, proposal.proposer, proposal.amount);

    // ???? / ????dJPY / ????SHINJI token????
    _storage.subTotalSupply(proposal.amount);
    _storage.subCoinBalance(proposal.proposer, proposal.amount);
    _storage.subTokenBalance(proposal.proposer, proposal.amount);

    return true;
  }

  function isAuthorized(address src, bytes4 sig) internal view returns (bool) {
    sig; // #HACK

    return  src == address(this) ||
            src == owner ||
            src == address(_token);
  }
}