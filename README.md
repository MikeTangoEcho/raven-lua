raven-lua
=========

[![Build Status](https://travis-ci.org/cloudflare/raven-lua.svg?branch=master)](https://travis-ci.org/cloudflare/raven-lua)

A small Lua interface to [Sentry](https://sentry.readthedocs.org/) that also
has a helpful wrapper function `call()` that takes any arbitrary Lua function
(with arguments) and executes it, traps any errors and reports it automatically
to Sentry.

Synopsis
========

```lua

    local raven = require "raven"

    -- http://pub:secret@127.0.0.1:8080/sentry/proj-id
    local rvn = raven.new {
        -- multiple senders are available for different networking backends,
        -- doing a custom one is also very easy.
        sender = require("raven.senders.luasocket").new {
            dsn = "http://pub:secret@127.0.0.1:8080/sentry/proj-id",
        },
        tags = { foo = "bar" },
    }

    -- Send a message to sentry
    local id, err = rvn:captureMessage(
      "Sentry is a realtime event logging and aggregation platform.",
      { tags = { abc = "def" } } -- optional
    )
    if not id then
       print(err)
    end

    -- Send an exception to sentry
    local exception = {{
       ["type"]= "SyntaxError",
       ["value"]= "Wattttt!",
       ["module"]= "__builtins__"
    }}
    local id, err = rvn:captureException(
       exception,
       { tags = { abc = "def" } } -- optional
    )
    if not id then
       print(err)
    end

    -- Catch an exception and send it to sentry
    function bad_func(n)
       return not_defined_func(n)
    end

    -- variable 'ok' should be false, and an exception will be sent to sentry
    local ok = rvn:call(bad_func, 1)

```

Documentation
=============

See docs/index.html for more details.

Prerequisites
=============
To run the tests:
```
    luarocks install lunit
    luarocks install lua-cjson
    luarocks install luaposix
    luarocks install luasocket
    luarocks install luasec

    make test
```

To generate the docs:
```
    luarocks install ldoc

    make doc
```

Memo Docker HAPROXY 1.8 with lua5.3
=============
Install lua5.3 before luarocks since didnt yet find a way to modifiy it on the fly without using env, else it will install 5.1
Install lua-cjson 2.1.0 because last version require lua5.3 to be build with 5.1 compat, and the lua in the repo was not built this way
```
    apt-get update
    apt-get install lua5.3 liblua5.3-dev
    apt-get install luarocks
    apt-get install libssl-dev
    luarocks install lua-cjson 2.1.0
    luarocks install luaposix
    luarocks install luasocket
    luarocks install luasec
```

