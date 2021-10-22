pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

//Прим.: во всех функциях сделал по умолчанию bounce = true, вроде как защитить от переводов на заблокированные кошельки и т. п.
contract Wallet {
   
    constructor() public {      
        require(tvm.pubkey() != 0, 101);
        
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);

		tvm.accept();
		_;
	}

    function sendWithCommissionAtOwnExpense(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, true, 1);
    }

    function sendWithoutCommissionAtOwnExpense(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, true, 0);
    }

    function sendAllMoneyAndDestroyWallet(address dest) public pure checkOwnerAndAccept {
        dest.transfer(0, true, 160);
    }
}