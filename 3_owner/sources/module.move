module owner::counter {
    use sui::transfer;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::coin::{Self, Coin};

    /// A shared counter.
    struct COUNTER has drop {}

    struct ShareCounter has key {
        id: UID,
        owner: address,
        value: u64,
        insideCoin: Coin<COUNTER>
    }


    struct Counter has key {
        id: UID,
        owner: address,
        value: u64,
    }

    /// Create and share a Counter object.
    fun init(w: COUNTER, ctx: &mut TxContext) {

        let cap = coin::create_currency(w, 2, ctx);
        let coin = coin::mint(&mut cap, 100, ctx);

        transfer::transfer(cap, tx_context::sender(ctx));

        transfer::transfer(Counter {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            value: 0
        }, tx_context::sender(ctx));

        transfer::share_object(ShareCounter {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            value: 0,
            insideCoin: coin
        })
    }

    /// Increment a counter by 1.
    public entry fun incr_share(counter: &mut ShareCounter) {
        counter.value = counter.value + 1;
    }

    public entry fun incr(counter: &mut Counter) {
        counter.value = counter.value + 1;
    } 

    /// Set value (only runnable by the Counter owner)
    public entry fun set_value(counter: &mut ShareCounter, value: u64, ctx: &mut TxContext) {
        assert!(counter.owner == tx_context::sender(ctx), 0);
        counter.value = value;
    }

    /// Assert a value for the counter.
    public entry fun assert_value(counter: &ShareCounter, value: u64) {
        assert!(counter.value == value, 0)
    }

}