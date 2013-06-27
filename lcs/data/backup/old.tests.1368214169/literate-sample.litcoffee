# Gebeurtenissen (events)

Event handlers in DocPad receive two arguments. The first is `opts`
which is an object filled with properties that the event may provide to
you. The second is `next` which is a completion callback. Both arguments
are **optional**.

    console.log 'hello world'

Events are fired in a synchronous serial fashion, meaning fire the first
handler, wait for it to finish, fire the next handler, wait for it to
finish, and so on.

