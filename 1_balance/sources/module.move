module token::my_module {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};


    struct Token has key, store {
        id : UID,
        balance : u64
    } 

    fun init(ctx: &mut TxContext) {
        let init_token = Token {
            id : object::new(ctx),
            balance : 100,
        };
        transfer::transfer(init_token, tx_context::sender(ctx));
    }

    fun balance(self: &Token) : u64 {
        self.balance
    }

    fun add(self: &mut Token, amount: u64) {
        self.balance = self.balance + amount;
    }

    public entry fun mint(token: &mut Token, amount: u64) {
        add(token, amount);
    }

    #[test]
    public fun test_token_create() {
        use sui::tx_context;
        let ctx = tx_context::dummy();

        let token = Token {
            id : object::new(&mut ctx),
            balance : 100,
        };

        assert!(balance(&token) == 100, 0);
        add(&mut token, 100);
        assert!(balance(&token) == 200, 0);

        let dummy_address = @0xCAFE;
        transfer::transfer(token, dummy_address);
    }
}