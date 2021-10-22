pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract CarsToken {

    struct CarToken {
        string name;
        uint maxSpeed;
        uint price;
    }
   
    CarToken[] tokenCarsArr;

    mapping(uint => uint) tokenCarToOwner;

    function createCarToken(string name, uint maxSpeed) public {

        tvm.accept();
        
        for (uint i = 0; i < tokenCarsArr.length; i++) {
            require(name == tokenCarsArr[i].name, 101);    
        }

        tokenCarsArr.push(CarToken(name, maxSpeed, 0));

        uint keyAsLastNum = tokenCarsArr.length - 1; 

        tokenCarToOwner[keyAsLastNum] = msg.pubkey();
    }

    function setTokenPrice(uint tokenId, uint price) public {
        
        require(msg.pubkey() == tokenCarToOwner[tokenId], 101);
        tvm.accept();

        tokenCarsArr[tokenId].price = price;
    }

    function changeMaxSpeed(uint tokenId, uint maxSpeed) public {
   
        require(msg.pubkey() == tokenCarToOwner[tokenId], 101);
        tvm.accept();

        tokenCarsArr[tokenId].maxSpeed = maxSpeed;        
    }
}
