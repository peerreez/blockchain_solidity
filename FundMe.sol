// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6 <0.9.9;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe{

    using SafeMathChainlink for uint256;
    address public owner;
    // queremos llevar un registro sobre que wallets nos estan enviando dinero
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    constructor() public{
        owner = msg.sender;
    }

    // cuando declaramos payable es una funcion que puedes ser usada para pagar por cosas
    function fund() public payable{
        uint256 minimumUSD = 50 *10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more eth!");
        // msg.sender indicativo para saber desde que wallet se esta enviando esa transaccion
        // msg.value valor asociado con esa transaccion 
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
            (,int price,,,) = priceFeed.latestRoundData();
              return uint256(price * 10000000000);
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        // indaca que despues de la confirmacion se ejecute el resto del codigo
        _;
    }

    function withdraw() payable onlyOwner public{
        // this se refiere al contrato
        // balance indica cual es el valance de los activos del contrato
        // solo el owner
        msg.sender.transfer(address(this).balance);
        for(uint256 funderIndex; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; 
        }
        funders = new address[](0);

    }
 
}
