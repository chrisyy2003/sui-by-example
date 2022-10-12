module owner::counter {
    use sui::transfer;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};

    /// A shared counter.
    struct ShareCounter has key {
        id: UID,
        owner: address,
        value: u64
    }

    struct Counter has key {
        id: UID,
        owner: address,
        value: u64
    }

    public fun owner(counter: &ShareCounter): address {
        counter.owner
    }

    public fun value(counter: &ShareCounter): u64 {
        counter.value
    }

    /// Create and share a Counter object.
    fun init(ctx: &mut TxContext) {
        transfer::transfer(Counter {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            value: 0
        }, tx_context::sender(ctx));

        transfer::share_object(ShareCounter {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            value: 0
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