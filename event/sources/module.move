module event::my_event {
    use sui::event;
    use sui::tx_context::{Self, TxContext};

    struct EVENT has copy, drop {
        sender: address,
        value: u64
    }

    fun init(ctx: &mut TxContext) {
        event::emit(EVENT {
            sender: tx_context::sender(ctx),
            value: 100
        });
        event::emit(EVENT {
            sender: tx_context::sender(ctx),
            value: 200
        })
    }
}