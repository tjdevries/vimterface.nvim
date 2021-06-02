-- file: `config/plugin_one.lua`
return {
  enabled = true,

  -- Change settings of the plugin
  settings = {
    debug = true,
  },

  -- Set the mappings
  -- Other possible values could be: maps = { default = true }, or similar (not yet decided)
  -- so that you just grab the default values for a plugin.
  --
  -- Invalid mapping names will error (or something like that)
  maps = {
    n = {
      ["<space>ff"] = "TestPlugMappingOne",
      ["<space>fd"] = "TestPlugMappingTwo",
    },
  },
}
