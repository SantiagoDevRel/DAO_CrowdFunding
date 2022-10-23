//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;
import "./Dao.sol";
import "./Proposals.sol";

contract Factory {

    mapping (address => Proposal) mapProposals;
    Proposal[] public arrProposals;

    function createProposal(string memory _title, string memory _content, uint256 _limit) public {    //modifier onlyapplicants 
        Proposal proposal = new Proposal(_title, _content, _limit);
        address addProposal = address(proposal);
        mapProposals[addProposal] = proposal;
        arrProposals.push(proposal);
    }

    function getSpecificProposal(address _addProposal) public view returns (Proposal){
        return (mapProposals[_addProposal]);
    }

    function getProposals() public view returns (Proposal[] memory){
        return arrProposals;
    }

}

