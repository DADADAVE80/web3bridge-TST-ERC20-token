// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ICOToken{
    mapping(address account => uint256) private _balances;
    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply = 50 * 10 ** 18;

    string private _name;
    string private _symbol;

    constructor(){
        _name = "ICOToken";
        _symbol = "ICO";
    }

    function name() public view returns (string memory){
        return _name;
    }

    function symbol() public view returns (string memory){
        return _symbol;
    }

    function decimals() public view returns (uint8){
        return 18;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256){
        return _balances[account];
    }
}