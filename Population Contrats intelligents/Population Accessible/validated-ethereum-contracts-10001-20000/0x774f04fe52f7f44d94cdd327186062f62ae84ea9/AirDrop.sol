// ???????????! ??? ??? ????? ?? ?????????? ???????. ????????? ? ???????: https://echarge.io, ??????? ??????? ? ???? ICO
// ?? ????????? ???????? ????? ?? ????????? ? ???????????? ????? 50 000 ??????????? ???????? ??????? ??? ?????????????? ?? ????????????? ?????????, ? ?????? ??????? ? ??????, ?????? ? ???????? ???????. ????????? ? ??????? ?????? ???????? ?? 
// ?????????? ????????, ??? ????????? ????????? ?????????? ???????????? ???? ?????????? ? ???????? ???????????? ?? ???????, ????? ???????? ??????? ?? ?????? ????, ? ????????? ?? ???????.
//
// Congratulations! Its your free airdrop token. More about project at: https://echarge.io, Bonustable and ICO dates
// we will install, own and operate more 50.000 eCharging stations for electrical cars on an exclusive contract starting in hotels, offices and malls and make the money our of the usage. the backend and payment system is based on blockchain 
// to allow the car owner to use his car as and battery on wheals to buy energy at low price and sell energy at hight price.
//
// ?????????????????????????????https://echarge.io?????? ICO ??
// ??????????????????? 50,000 ? eCharge ?????????? ????????????????????????????????????????? ??????????????????????????????????
//
// ???????! ???? ????? ?? ??????? ??????? ???????? ????????. ?????? ?? ????????? ?? ??????? ??? ??????: https://echarge.io? ????? ???????? ??????? ????? ?????? ??????
// ????? ?????? ??????? ?????? ?? ???? ?? 50000 ???? ????? ????????? ???????? ?????????? ????? ??? ??? ???? ?? ??????? ???????? ?????? ?????? ?? ??????? ???? ????? ?????? ?? ??? ?????????. ????? ???? ???????? ??????? ????? ????? ??? ????? ???? ???? ?????? ?????? ????????
// ???????? ???????? ??????? ???? ??? ????? ????? ?????? ???? ????? ?????? ???? ?????.
//
// ?????! ?? ???? ??? ???????. ??? ?? ??, ICO?? ? ? ?? ??? echarge.io?? ???? ? ????.
// ??? ??, ???, ???? ?? ??? ?? ???? ??? ? ?? eCharge ??? 50,000?? ? ???? ??, ??? ????, ??? ??? ??? ????. ???? ?? ???? ????? ???? ????, ? ???? ? ???? ???? ??? ??? ???? ???? ??? 
// ??? ????, ?? ??? ??? ? ????.
//
// F�licitations! Voici votre token airdrop gratuit. Pour en savoir plus sur le projet: https://echarge.io, Tableau des bonus et dates de l'ICO.
// Nous installerons, poss�derons et g�rerons plus de 50 000 bornes de recharge pour voitures �lectriques sur la base d'un contrat exclusif d�butant en h�tels, bureaux et centres commerciaux pour g�n�rer des recettes gr�ce � l'usage de ces
// bornes. Le syst�me logiciel et de paiement est bas� sur la blockchain pour permettre au propri�taire de la voiture
// d'utiliser sa voiture comme une batterie pour acheter de l'�nergie � bas prix et vendre de l'�nergie � un prix �lev�. 
                                                                                                              
pragma solidity 0.4.18;

contract Ownable {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() { require(msg.sender == owner); _; }

    function Ownable() public {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        owner = newOwner;
        OwnershipTransferred(owner, newOwner);
    }
}

contract Withdrawable is Ownable {
    function withdrawEther(address _to, uint _value) onlyOwner public returns(bool) {
        require(_to != address(0));
        require(this.balance >= _value);

        _to.transfer(_value);

        return true;
    }

    function withdrawTokens(ERC20 _token, address _to, uint _value) onlyOwner public returns(bool) {
        require(_to != address(0));

        return _token.transfer(_to, _value);
    }
}

contract ERC20 {
    uint256 public totalSupply;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function balanceOf(address who) public view returns(uint256);
    function transfer(address to, uint256 value) public returns(bool);
    function transferFrom(address from, address to, uint256 value) public returns(bool);
    function allowance(address owner, address spender) public view returns(uint256);
    function approve(address spender, uint256 value) public returns(bool);
}

contract AirDrop is Withdrawable {
    event TransferEther(address indexed to, uint256 value);

    function tokenBalanceOf(ERC20 _token) public view returns(uint256) {
        return _token.balanceOf(this);
    }

    function tokenAllowance(ERC20 _token, address spender) public view returns(uint256) {
        return _token.allowance(this, spender);
    }
    
    function tokenTransfer(ERC20 _token, uint _value, address[] _to) onlyOwner public {
        require(_token != address(0));

        for(uint i = 0; i < _to.length; i++) {
            require(_token.transfer(_to[i], _value));
        }
    }
    
    function tokenTransferFrom(ERC20 _token, address spender, uint _value, address[] _to) onlyOwner public {
        require(_token != address(0));

        for(uint i = 0; i < _to.length; i++) {
            require(_token.transferFrom(spender, _to[i], _value));
        }
    }

    function etherTransfer(uint _value, address[] _to) onlyOwner payable public {
        for(uint i = 0; i < _to.length; i++) {
            _to[i].transfer(_value);
            TransferEther(_to[i], _value);
        }
    }
}