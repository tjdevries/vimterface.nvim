# vinterface.nvim

Some ideas about making plugins in neovim

```lua
-- file: `config/test_plug.lua`
--
-- This returns a table that represents the configuration for the plugin.
-- To see the plugin, see `scratch/test_plug.lua`

return {
  enabled = true,

  map = {
  n = {
    ["<space>kj"] = "TestPlugMappingOne",
    },
  },
}
```

## Thoughts

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
