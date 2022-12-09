module example::mycoin {
    use sui::transfer;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use std::string::{String, Self};

    struct S has key, store {
        id: UID,
        msg: String
    }

    fun init(ctx: &mut TxContext) {
        let saySomeThing = string::utf8(b"");
        string::append_utf8(&mut saySomeThing, b"My name is Chris");
        transfer::transfer(S {
            id: object::new(ctx),
            msg: saySomeThing
        }, tx_context::sender(ctx));
    }

}