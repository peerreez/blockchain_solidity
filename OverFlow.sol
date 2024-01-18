// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;
contract OverFlow{

    // el resultado devuelto es 0 debido a que me excedo a la cantidad maxima
    function overflow() public view returns(uint8){
        uint8 big = 255 + uint8(1);
        return big;
    }
}
