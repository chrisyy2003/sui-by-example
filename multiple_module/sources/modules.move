module multiple_module::module1 {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct Res has key, store{
        id: UID,
        counter: u64,
    } 

    fun init(ctx: &mut TxContext) {
        transfer::transfer(Res {
            id : object::new(ctx),
            counter: 0,
        }, tx_context::sender(ctx));
    }

}

module multiple_module::module2 {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct Res has key, store{
        id: UID,
        counter: u64,
    } 

    fun init(ctx: &mut TxContext) {
        transfer::transfer(Res {
            id : object::new(ctx),
            counter: 0,
        }, tx_context::sender(ctx));
    }
}