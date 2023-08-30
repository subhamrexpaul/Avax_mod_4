// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 1. To mint tokens = _mint()
// 2. To transfer tokens = _transfer()
// 3. To burn tokens = _burn()

contract DegenToken is ERC20 {

    string public tokenName = "DEGEN";
    string public tokenSymbol = "REX";
    mapping (address => string[]) purchases;
    address public owner;


    constructor() ERC20(tokenName, tokenSymbol){
        _mint(msg.sender, 10000);
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Sorry! only owner can mint REX!");
        _;
    }

    // Mint function
    function mintTokens(address _receiver, uint256 _tokens) public onlyOwner{
        require(_receiver != address(0), "This address doesn't exist");
        require(_tokens > 0, "You can't mint negative number of REX");
        _mint(_receiver, _tokens);
    }   

    // Food Shop
    function foodShop() public pure returns(string memory) {
        return "1. Biryani [150 REX] 2. Tandoori Chicken [250 REX] 3. Butter Chicken [200 REX] 4. Noodles [110 REX]";
    }

    // Function to redeem REX
    function redeemTokens(uint _ch) external{
        require(_ch <= 4,"Wrong option selected!");

        if(_ch == 1){
            require(balanceOf(msg.sender)>=150, "Oops! Insufficient REX");
            _burn(msg.sender, 150);
            purchases[msg.sender].push("Biryani");
        }

        else if(_ch ==2){
            require(balanceOf(msg.sender) >= 250, "Oops! Insufficient REX");
            _burn(msg.sender, 250);
            purchases[msg.sender].push("Tandoori Chicken");
        }

        else if(_ch == 3){
            require(balanceOf(msg.sender) >= 200, "Oops! Insufficient REX");
            _burn(msg.sender, 200);
            purchases[msg.sender].push("Butter Chicken");
        }

        else{
            require(balanceOf(msg.sender) >= 110, "Oops! Insufficient REX");
            _burn(msg.sender, 110);
            purchases[msg.sender].push("Noodles");
        }

    }

    function foodPurchases() public view returns (string[] memory, uint256){
        uint256 length = purchases[msg.sender].length;
        require(length > 0, "No purchases found for this address");
        return (purchases[msg.sender], length);
    }
    
    // Transfer Tokens Function
    function transferTokens(address _reciever, uint _tokens) external{
        require(balanceOf(msg.sender) >= _tokens, "Sorry, not enough balance in wallet.");
        transfer(_reciever, _tokens);
    }

    // Function to check token balance
    function checkTokenBalance() external view returns(uint){
        return balanceOf(msg.sender);
    }

    // Function to burn tokens
    function burnTokens(uint _tokens) external{
        require(balanceOf(msg.sender)>= _tokens, "You don't have enough REX!");
        _burn(msg.sender, _tokens);
    }

}
