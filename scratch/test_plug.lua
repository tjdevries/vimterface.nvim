local plugin = vim.plugin.register {
  name = "test_plug",

  setup = function(...)
  end,

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

if plugin.settings.debug then
  print "debug"
end

plugin:map {
  name = "TestPlugMappingOne",
  fn = function()
    count = count + 1
    print("Yoo, dawg, we did it: " .. count)
  end,
  -- condition = ...
  default = {
    "n",
    "gd", --[[opts]]
  },
}

-- TODO:
-- plugin:command { ... }
-- OR
-- does it go in register?

-- TODO:
-- plugin:autocmd { ... }
-- OR
-- doees it go in register?
