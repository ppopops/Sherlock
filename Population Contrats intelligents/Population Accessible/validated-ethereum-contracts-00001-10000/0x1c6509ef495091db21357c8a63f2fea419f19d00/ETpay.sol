/* ????????????? */
pragma solidity ^0.4.16;
/* ??????? ????? */
contract owned {

    address public owner;

    function owned() public {
    owner = msg.sender;
    }

    /* modifier????? */
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    /* ???????? onlyOwner????????????? */
    function transferOwnership(address newOwner) onlyOwner public {
        owner = newOwner;
    }   
}

/* receiveApproval???????????????????????????????????????? */
interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public; }

contract TokenERC20 {
    // ???token??????
    string public name;             //????
    string public symbol;           //????
    uint8 public decimals = 18;     //???????? 18???? ??????

    uint256 public totalSupply;     //????

    // ???????????
    mapping (address => uint256) public balanceOf;

    // A????B????
    mapping (address => mapping (address => uint256)) public allowance;

    // ??????
    event Transfer(address indexed from, address indexed to, uint256 value);

    // ????????
    event Burn(address indexed from, uint256 value);

    /* ???? */
    function TokenERC20(
        uint256 initialSupply,
        string tokenName,
        string tokenSymbol
    ) public {
        totalSupply = initialSupply * 10 ** uint256(decimals);  // ??decimals???????
        balanceOf[msg.sender] = totalSupply;                    // ???????????
        name = tokenName;                                       // ???????
        symbol = tokenSymbol;                                   // ???????
    }

    /* ??????? */
    function _transfer(address _from, address _to, uint _value) internal {
        // ?????0x0? ?burn??????
        require(_to != 0x0);
        // ?????????????
        require(balanceOf[_from] >= _value);
        // ???????????????
        require(balanceOf[_to] + _value > balanceOf[_to]);
        // ??????????? ??????????
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        // ???????
        balanceOf[_from] -= _value;
        // ????????
        balanceOf[_to] += _value;
        Transfer(_from, _to, _value);
        // ????? ?????
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    /* ??tokens */
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    /* ????????? */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);     // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    /*  ????????????????????transferFrom()????????????? */
    function approve(address _spender, uint256 _value) public
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    /*
    ?????????? ???
    ?????????, ??????????receiveApproval, ????????????????????????????????????????transferFrom)
    */

    function approveAndCall(address _spender, uint256 _value, bytes _extraData)
        public
        returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }

    /**
    * ????
    */
    function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);   // Check if the sender has enough
        balanceOf[msg.sender] -= _value;            // Subtract from the sender
        totalSupply -= _value;                      // Updates totalSupply
        Burn(msg.sender, _value);
        return true;
    }

    /**
    * ?????????
    */
    function burnFrom(address _from, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value);                // Check if the targeted balance is enough
        require(_value <= allowance[_from][msg.sender]);    // Check allowance
        balanceOf[_from] -= _value;                         // Subtract from the targeted balance
        allowance[_from][msg.sender] -= _value;             // Subtract from the sender's allowance
        totalSupply -= _value;                              // Update totalSupply
        Burn(_from, _value);
        return true;
    }
}

/******************************************/
/*       ADVANCED TOKEN STARTS HERE       */
/******************************************/

contract ETpay is owned, TokenERC20 {

    uint256 public sellPrice;
    uint256 public buyPrice;

    /* ???? */
    mapping (address => bool) public frozenAccount;

    /* This generates a public event on the blockchain that will notify clients */
    event FrozenFunds(address target, bool frozen);

    /* ???? */
    function ETpay(
        uint256 initialSupply,
        string tokenName,
        string tokenSymbol
    ) TokenERC20(initialSupply, tokenName, tokenSymbol) public {}

    /* ??? ?????????? */
    function _transfer(address _from, address _to, uint _value) internal {
        require (_to != 0x0);                               // Prevent transfer to 0x0 address. Use burn() instead
        require (balanceOf[_from] >= _value);               // Check if the sender has enough
        require (balanceOf[_to] + _value > balanceOf[_to]); // Check for overflows
        require(!frozenAccount[_from]);                     // Check if sender is frozen
        require(!frozenAccount[_to]);                       // Check if recipient is frozen
        balanceOf[_from] -= _value;                         // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
        Transfer(_from, _to, _value);
    }

/// ?????????
    function mintToken(address target, uint256 mintedAmount) onlyOwner public {
        balanceOf[target] += mintedAmount;
        //totalSupply += mintedAmount;
        Transfer(0, this, mintedAmount);
        Transfer(this, target, mintedAmount);

    }


    /// ?? or ????
    function freezeAccount(address target, bool freeze) onlyOwner public {
        frozenAccount[target] = freeze;
        FrozenFunds(target, freeze);
    }

  

}