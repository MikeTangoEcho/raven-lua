package = "mte-raven"
 version = "1.0-1"
 source = {
    url = "git://github.com/MikeTangoEcho/raven-lua",
 }
 description = {
    summary = "Lua (openresty) client for Sentry.",
    detailed = [[
       Send sentry events/alerts.
    ]],
    homepage = "https://github.com/MikeTangoEcho/raven-lua",
    license = "MIT"
 }
 dependencies = {
    "lua 5.3",
    "lua-cjson 2.1.0",
    "luaposix",
    "luasocket",
    "luasec",
 }
 build = {
    type = "builtin",
    modules = {
      ["raven"] = "raven/init.lua",
      ["raven.util"] = "raven/util.lua",
      ["raven.senders.luasocket"] = "raven/senders/luasocket.lua",
    }
 }
