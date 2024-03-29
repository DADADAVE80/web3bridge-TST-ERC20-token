// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract TSTToken{
    mapping(address account => uint256) private _balances;
    mapping(address account => mapping(address spender => uint256)) private _allowances;

    address private _owner = msg.sender;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    constructor(){
        _name = "TSTToken";
        _symbol = "TST";
    }

    function name() external view returns (string memory){
        return _name;
    }

    function symbol() external view returns (string memory){
        return _symbol;
    }

    function decimals() external view returns (uint8){
        return 18;
    }

    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256){
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external returns (bool){
        uint transferFee = amount / 10;
        require(msg.sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        require(amount > 0, "ERC20: transfer amount must be greater than zero");
        uint256 senderBalance = _balances[msg.sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

        _balances[msg.sender] -= amount + transferFee;
        _balances[recipient] += amount;

        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return _allowances[owner][spender];
    }

    function approve(address owner, address spender, uint256 amount) external returns (bool){
        require(owner != address(0), "ERC20: approve to the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
        uint transferFee = amount / 10;
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        uint256 senderAllowance = _allowances[sender][msg.sender];
        require(senderAllowance >= amount, "ERC20: transfer amount exceeds allowance");

        _balances[sender] -= amount + transferFee;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;

        return true;
    }

    function mint(address account, uint256 amount) external {
        require(msg.sender != address(0), "ERC20: mint from the zero address");

        _totalSupply += amount;
        _balances[account] += amount;
    }

    function burn(address account, uint256 amount) external {
        require(msg.sender != address(0), "ERC20: burn from the zero address");

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");

        _balances[account] -= amount;
        _totalSupply -= amount;
    }
}