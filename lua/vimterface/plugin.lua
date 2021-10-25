local KeyMap = require("vimterface.map").KeyMap

local Plugin = {}
Plugin.__index = Plugin

function Plugin:new(mod)
  return setmetatable({
    _name = assert(mod.name, "Must have name"),
    _groups = {},
    _settings = mod.settings,

    -- `maps` is a public API
    maps = {},
  }, self)
end

function Plugin:map(t)
  vim.validate {
    name = { t.name, "s" },
    fn = { t.fn, "f", true },
    cmd = { t.cmd, "s", true },
  }

  self.maps[t.name] = KeyMap:new(t)
end

function Plugin:map_group(name, t)
  -- TODO: Validation of table
  self._groups[name] = t
end

return Plugin
