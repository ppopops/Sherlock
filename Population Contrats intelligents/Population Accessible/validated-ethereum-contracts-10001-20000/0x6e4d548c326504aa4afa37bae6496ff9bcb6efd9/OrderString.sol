pragma solidity ^0.4.24;

contract OrderString {
 
    string internal _orderString = "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????";
    function getOrderString () view external returns(string) {
        return _orderString;
    }
}