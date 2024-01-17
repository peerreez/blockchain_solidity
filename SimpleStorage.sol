// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SimpleStorage{
    
    uint256 favoriteNumber;
    struct People{
        uint256 favoriteNumber;
        string name;
    }
    mapping(string  => uint256) public nameToFavoriteNumber;
    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber; 
    }

    // view basicamente para obtener el dato que esta declarado dentro de la blockchain
    // pure realizan operacion matematica
    function retrive() public view returns(uint256) {
        return favoriteNumber;
    }

    // memory hace que la variable viva unicamente durante la ejecuccion
    // storage hace que la variable perdure durante el tiempo
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));    
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}
