module erc20::mycoin {
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// The type identifier of coin. The coin will have a type
    /// tag of kind: `Coin<package_object::mycoin::MYCOIN>`
    /// Make sure that the name of the type matches the module's name.
    struct MYCOIN has drop {}

    /// Module initializer is called once on module publish. A treasury
    /// cap is sent to the publisher, who then controls minting and burning
    fun init(witness: MYCOIN, ctx: &mut TxContext) {
        let cap = coin::create_currency(witness, ctx);
        let admin = tx_context::sender(ctx);
        coin::mint_and_transfer(&mut cap, 100, admin, ctx);
        let coin1 = coin::mint(&mut cap, 100, ctx);
        let coin2 = coin::mint(&mut cap, 1000, ctx);

        transfer::transfer(c, @0xd3897fcf3a5f72cdd328982521eca14ff684e5a7);
        transfer::transfer(c2, @0xd3897fcf3a5f72cdd328982521eca14ff684e5a7);
        transfer::transfer(cap, admin);

    }


}