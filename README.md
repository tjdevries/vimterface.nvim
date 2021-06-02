# vimterface.nvim

Some ideas about making plugins in neovim.

Closer to "declarative" style but without introducing another language (`.json`, `.toml`, etc.)
and allows for things like passing Lua functions, upvalues, required values, etc.

Goals:
- Easy to copy & paste in config to get defaults to configure
- Declars settings, mappings, etc. from plugin and user.
  - could be used to make GUI, validator, completion engine, etc.

## Thoughts

### Thoughts: Users

`config/*.lua` gets sourced at startup, after loading.

For example, if you have a file: `config/plugin_one.lua`, this will configure a plugin
registered with the name `plugin_one` (plugin registration is talked about later, but end users
do not have to worry much about it).

```lua
-- file: `config/plugin_one.lua`
return {
  enabled = true,

  -- Change settings of the plugin
  settings = {
    debug  = true,
  },

  -- Set the mappings
  -- Other possible values could be: maps = { default = true }, or similar (not yet decided)
  -- so that you just grab the default values for a plugin.
  --
  -- Invalid mapping names will error (or something like that)
  maps = {
    n = {
      ["<space>kj"] = "TestPlugMappingOne",
    },
  },
}
```

One special file in `config/*.lua`: `init.lua`.

If you have a `config/init.lua` then this file expects a slightly differen structure.

```lua
return {
  plugin_one = {
  },

  plugin_two = {
  },

  ...
}
```

### Thoughts: Plugin

```lua
-- Plugins could do something like this:

local plugin = vim.plugin.register {
  name = "test_plug",

  -- Just some random values from nvim-compe
  settings = {
    debug = {
      type = "boolean",
      desc = "Debug mode.",
      default = false,
    },

    source = {
      type = "table",
      desc = "Sources configuration.",
      default = {
        path = true,
        buffer = true,
      },
      validator = function(t)
        error "validating"
      end,
    },
  },
}

local count = 0

plugin:map {
  name = "TestPlugMappingOne",
  fn = function()
    count = count + 1
    print("Yoo, dawg, we did it: " .. count)
  end,
  -- condition = ...
  -- default = ...
}
```
