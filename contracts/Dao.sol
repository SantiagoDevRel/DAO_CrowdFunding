// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;
import "./Factory.sol";

contract Dao {

    Factory public factory;

    constructor(string memory _name, string memory _last_name, uint8 age){
        factory = new Factory();
        mapUsers[msg.sender] = User(msg.sender, _name, _last_name, age, true,true,true);
    }

    struct User {
        address id;
        string name;
        string last_name;
        uint8 age;
        bool isAdmin;
        bool isJudge;
        bool isApplicant;
    }
   
    mapping (address => User) public mapUsers; //este mapping para los modifiers

    modifier onlyAdmin {
        require(mapUsers[msg.sender].isAdmin); //aqui estoy llamando la propiedad isAdmin dentro del user?? o como la llamo
        _;
    }

    modifier onlyJudge {
        require(mapUsers[msg.sender].isJudge); //aqui estoy llamando la propiedad isJudge dentro del user?? o como la llamo
        _;
    }

    modifier onlyApplicant {
        require(mapUsers[msg.sender].isApplicant); //aqui estoy llamando la propiedad isApplicant dentro del user?? o como la llamo
        _;
    }

    modifier onlySameUser {
        require(msg.sender == mapUsers[msg.sender].id);
        _;
    }

    //USERS FUNCTION

    function createUser (string memory _name, string memory _last_name, uint8 _age) public {//cualquiera puede crearse un usuario
        mapUsers[msg.sender] = User(msg.sender, _name, _last_name, _age, false, false, false);
    }

    function blockUser (address _user) public onlyAdmin{ //solo admin puede bloquear/eliminar usuario
        delete mapUsers[_user];
        /*//metodo 1
        mapUsers[_user].isAdmin = false;
        mapUsers[_user].isJudge = false;
        mapUsers[_user].isApplicant = false;*/
 
    }

    function editUser (string memory _name, string memory _last_name, uint8 _age) public onlySameUser {
        mapUsers[msg.sender].name = _name;
        mapUsers[msg.sender].last_name = _last_name;
        mapUsers[msg.sender].age = _age;
    } 

    function editPermissions (address _id, bool _isAdmin, bool _isJudge, bool _isApplicant) public onlyAdmin {
        mapUsers[_id].isAdmin = _isAdmin;
        mapUsers[_id].isJudge = _isJudge;
        mapUsers[_id].isApplicant = _isApplicant;
    }

    function showPermissions (address _id) public view returns (address, bool, bool, bool) {
        return 
        (
            mapUsers[_id].id,
            mapUsers[_id].isAdmin,
            mapUsers[_id].isJudge,
            mapUsers[_id].isApplicant
        );
    }

    function createProposal(string memory _title, string memory _content, uint256 _limit) public onlyApplicant {
        factory.createProposal(_title, _content, _limit);
    }

    function getProposals() public view returns (Proposal[] memory){
        return factory.getProposals();
    }

    function getSpecificProposals(address _add) public view returns (Proposal){
        return (factory.getSpecificProposal(_add));
    }

}