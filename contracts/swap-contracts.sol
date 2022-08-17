//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


//write a swap contract that allow users to swap tokens for tokens

interface IERC20 {
    function transfer(address _to, uint _value) external returns (bool);
    function balanceOf(address _owner) external view returns (uint);
    function allowance(address _owner, address _spender) external view returns (uint);
    function approve(address _spender, uint _value) external returns (bool);
    function transferFrom(address _from, address _to, uint _value) external returns (bool);
    function totalSupply() external view returns (uint);


    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);

}


contract LinkToken is IERC20 {

    string public constant name = "LinkToken";
    string public constant symbol = "$";
    uint8 public  constant decimals = 18;
    uint256 public constant tokenAmount = 50;
    uint public   totalSupply; 
    address public owner;


    mapping (address => uint) public balances;
    mapping (address => mapping (address => uint)) public allowed;


    constructor(uint256 total)  {
        owner = msg.sender;
        totalSupply = total;
        balances[msg.sender] = totalSupply;
    }


    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint _value) public returns (bool success) {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
       emit  Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint remaining) {
        return allowed[_owner][_spender];
    }

    function chekTotalSupply() public view returns (uint _totalSupply) {
        _totalSupply = totalSupply;
    }
  
}


contract Web3Token is IERC20 {
    string public constant name = "Web3Token";
    string public constant symbol = "WEB3";
    uint256 public constant tokenAmount = 300;
    uint public   totalSupply; 
    address public owner;
    mapping (address => uint) public balances;
    mapping (address => mapping (address => uint)) public allowed;
    constructor(uint256 total)  {
        owner = msg.sender;
        totalSupply = total;
        balances[msg.sender] = totalSupply;
    }
    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
    function transfer(address _to, uint _value) public returns (bool success) {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
    function approve(address _spender, uint _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
       emit  Approval(msg.sender, _spender, _value);
        return true;
    }
    function allowance(address _owner, address _spender) public view returns (uint remaining) {
        return allowed[_owner][_spender];
    }
    function chekTotalSupply() public view returns (uint _totalSupply) {
        _totalSupply = totalSupply;
    }
}


// create a contract transfer token from liknTokin to web3Token

contract SwapLinkTokenToWeb3Token {
    LinkToken public linkToken;
    Web3Token public web3Token;
    struct Order {
        address tokenSender;
        address tokenReceiver;
        uint amount;
    }
    constructor(address _linkToken, address _web3Token)  {
        linkToken = LinkToken(_linkToken);
        web3Token = Web3Token(_web3Token);
    }
    function swap(uint _amount) public {
            linkToken.transfer(web3Token.owner(), _amount);
    }

    function getLinkTokenBalance() public view returns (uint balance) {
        return linkToken.balanceOf(msg.sender);
    }

    function getWeb3TokenBalance() public view returns (uint balance) {
        return web3Token.balanceOf(msg.sender);
    }
}






