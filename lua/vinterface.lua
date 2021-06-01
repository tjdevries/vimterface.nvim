local map = R "vinterface.map"

local _user_directory = "config/*.lua"

local Plugin = {}
Plugin.__index = Plugin

function Plugin:new(mod)
  return setmetatable({
    _name = assert(mod.name, "Must have name"),
    _maps = {},
  }, self)
end

function Plugin:map(t)
  self._maps[t.name] = t

  return self
end

vim.plugin = {}

local registry = {}
vim.plugin._registry = registry

vim.plugin.register = function(mod)
  vim.validate {
    name = { mod.name, "s" },
  }

  registry[mod.name] = Plugin:new(mod)
  return registry[mod.name]
end

vim.plugin.setup = function(config)
end

local load_config = function(file)
  local ok, config = pcall(loadfile(file))
  if not ok then
    -- TODO: We will handle this gracefully.
    error("Failed to load..." .. file)
  end

  local mod_name = vim.fn.fnamemodify(file, ":t:r")
  local plug = registry[mod_name]
  if not plug then
    error("Yo, bad registry name:" .. mod_name)
  end

  if not config.enabled then
    return
  end

  -- TODO: Validate mappings
  -- TODO: <expr>
  for mode, mode_mappings in pairs(config.map or {}) do
    mode = string.lower(mode)

    for key, mapping in pairs(mode_mappings) do
      print(mode, key, mapping)

      map.apply(mode, key, plug._maps[mapping].fn)
    end
  end

  print("loaded: ", file, "=>", mod_name, plug)
end

vim.plugin.find_all_configs = function(glob)
  glob = glob or _user_directory
  local config_files = vim.api.nvim_get_runtime_file(glob, false)

  for _, file in ipairs(config_files) do
    load_config(file)
  end
end

vim.cmd [[luafile ./scratch/test_plug.lua]]
vim.plugin.find_all_configs()

return vim.plugin
