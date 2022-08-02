// SPDX-License-Identifier: MIT;
pragma solidity 0.8.15;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract TokenSwap {
    address owner;
    address token1;
    address token2;
    uint k;

    function init(
        address _token1Address, 
        address _token2Address, 
        uint _token1Amount, 
        uint _token2Amount
        ) public payable {
        owner = msg.sender;
        // 주소저장
        token1 = _token1Address;
        token2 = _token2Address;

        // Token 전송
        IERC20(token1).transferFrom(msg.sender, address(this), _token1Amount);
        IERC20(token2).transferFrom(msg.sender, address(this), _token2Amount);

        // Token Approve
        IERC20(token1).approve(address(this), _token1Amount);
        IERC20(token2).approve(address(this), _token2Amount);

        k = _token1Amount * _token2Amount;
    }

    // AMM(CPMM) 계산
    // @ withdrawType 0 = token1 -> token2;
    // @ withdrawType 1 = token2 -> token1;
    function calculateCPMM(
        uint _withdrawType, 
        uint _amount
        ) public view returns(uint) {
        uint token1CurrentBalance = IERC20(token1).balanceOf(address(this));
        uint token2CurrentBalance = IERC20(token2).balanceOf(address(this));

        // # Logic
        // @ Token 1 -> Token 2;
        if(_withdrawType == 0){
            uint EST_token1Balance = token1CurrentBalance + _amount;
            uint EST_token2WithdrawAmount = token2CurrentBalance - (k / EST_token1Balance);
            return EST_token2WithdrawAmount;
        } else {
            // @ Token 2 -> Token 1;
            uint EST_token2Balance = token2CurrentBalance + _amount;
            uint EST_token1WithdrawAmount = token1CurrentBalance - (k / EST_token2Balance);
            return EST_token1WithdrawAmount;
        }
    }

    // 동일 네트워크 토큰스왑;
    // @ withdrawType 0 = token1 -> token2;
    // @ withdrawType 1 = token2 -> token1;
    function swapToken(
        uint _withdrawType,
        uint _depositTokenAmount,
        uint _withdrawTokenAmount
        ) public payable {
            // Token 1 -> Token 2;
            if(_withdrawType == 0) {
                IERC20(token1).transferFrom(address(msg.sender), address(this), _depositTokenAmount);
                IERC20(token1).approve(address(this), _depositTokenAmount);
                IERC20(token2).transferFrom(address(this), address(msg.sender), _withdrawTokenAmount);
            } else {
                IERC20(token2).transferFrom(address(msg.sender), address(this), _depositTokenAmount);
                IERC20(token2).approve(address(this), _depositTokenAmount);
                IERC20(token1).transferFrom(address(this), address(msg.sender), _withdrawTokenAmount);
            }
    }

    // Token1 & 2 잔고확인;
    function checkBalance() public view returns(uint, uint){
        return(IERC20(token1).balanceOf(address(this)), IERC20(token2).balanceOf(address(this)));
    }
}
