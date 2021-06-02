local a = vim.api

local map = {}
map._store = {}

local _mapping_key_id = 0
local get_next_id = function()
  _mapping_key_id = _mapping_key_id + 1
  return _mapping_key_id
end

local assign_function = function(func)
  local func_id = get_next_id()

  map._store[func_id] = func

  return func_id
end

-- TODO: buffer
map.apply = function(mode, key_bind, key_func, opts)
  print("APPLYING", mode, key_bind, key_func)
  if not key_func then
    return
  end

  opts = opts or {}
  if opts.noremap == nil then
    opts.noremap = true
  end
  if opts.silent == nil then
    opts.silent = true
  end

  if type(key_func) == "string" then
    a.nvim_set_keymap(mode, key_bind, key_func, opts)
  else
    local key_id = assign_function(key_func)

    local map_string
    if opts.expr then
      map_string = string.format([[luaeval("require('vimterface.map').execute(%s)")]], key_id)
    else
      local prefix

      if mode == "i" and not opts.expr then
        prefix = "<cmd>"
      elseif mode == "n" then
        prefix = ":<C-U>"
      else
        prefix = ":"
      end

      map_string = string.format([[%slua require('vimterface.map').execute(%s)<CR>]], prefix, key_id)
    end

    a.nvim_set_keymap(mode, key_bind, map_string, opts)
  end
end

map.execute = function(keymap_identifier)
  local key_func = assert(
    map._store[keymap_identifier],
    string.format("Unsure of how we got this failure: %s", keymap_identifier)
  )

  key_func()
end

return map
