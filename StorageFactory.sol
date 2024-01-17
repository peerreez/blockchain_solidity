// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./SimpleStorage1.sol";

// Al hacer herencia me permite tener acceso a todas las funciones del contrato del cual estas heredando
contract StorageFactory is SimpleStorage1{
    SimpleStorage1[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage1 simpleStorage1 = new SimpleStorage1();
        simpleStorageArray.push(simpleStorage1);
    }

    function sfStore(uint _simpleStorageIndex, uint256 _simpleStorageNumber) public {

        // siempre que queramos interactuar con un contrato necesitamos dos cosas
        // address la direccion en la cual fue desplegado
        // ABI traduce nuestras intenciones a un codigo de maquina que la Ethereum Virtual Machine pueda entender
        SimpleStorage1(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);

    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return SimpleStorage1(address(simpleStorageArray[_simpleStorageIndex])).retrive();

    }

}
