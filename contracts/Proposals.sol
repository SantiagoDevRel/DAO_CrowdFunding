//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;
import "./Dao.sol";
import "./Factory.sol";

contract Proposal{

    address public applicant;
    address public thisProposal;
    string public title;
    string public content;
    uint256 public balanceProposal;
    uint256 public limit;
    bool public reachLimit = false;
    uint256 public date;
    //##anadir fecha limite
    address[] public donators;
    mapping (address => uint256) mapBalanceDonators;


    constructor(string memory _title, string memory _content, uint256 _limit){
        applicant = msg.sender;
        thisProposal = address(this);
        title = _title;
        content = _content;
        balanceProposal = 0;
        limit = _limit;
        date = uint256(block.timestamp);
    }

    function addBalance () public payable {
        require(!reachLimit, "Amount exceeds the limit of this proposal");
        balanceProposal+= msg.value;
        mapBalanceDonators[msg.sender]+= msg.value;
        if(balanceProposal >= limit){
            reachLimit = true;
        }
    }

    function getBalance() public view returns (uint256){
        return address(this).balance;
    }

    function getInfo() public view returns (address, address, string memory, string memory, uint256, uint256, uint256){
        return (applicant, thisProposal, title,content,balanceProposal,limit, date);
    }

}