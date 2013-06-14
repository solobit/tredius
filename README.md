# Tredius corporate public portal

This is the final refactoring of the portal environment in preparation of the
personal budget household aid. Running on Clojure/ClojureScript cross-over
using the JVM, Google Closure Compiler, many different plugins icw leiningen,
and http-kit.

HTTP Kit is a minimalist, efficient, Ring-compatible HTTP client/server for
Clojure. It uses a event-driven architecture to support highly concurrent
a/synchronous web applications. Feature a unified API for WebSocket and HTTP
long polling/streaming.

Tested with 600.000 concurrent HTTP connections using Clojure and http-kit.

You go girl!

## Prerequisites

You will need [Leiningen][1] 2.0 or above installed.

[1]: https://github.com/technomancy/leiningen

## Running

To start a web server for the application, run:

    ~~lein ring server~~
    lein run

## Tasks

[x] Added c2 data visualization


## License

Tredius BV &amp; Solobit © 2013 All rights reserved.


