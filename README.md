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
