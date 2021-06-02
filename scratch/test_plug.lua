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

plugin:map {
  name = "EchoHello",
  fn = function()
    count = count + 1
    return vim.api.nvim_replace_termcodes(string.format(":echo 'Hello %d'<CR>", count), true, true, true)
  end,
  opts = { expr = true, silent = true, noremap = true },
  default = { "n", "kj" },
}

plugin:map {
  name = "UsesCommand",
  cmd = "<cmd>echo 'Hi From Vim Commands'<CR>",
}

-- condition = ...

-- default_mapping
--  { "mode", "keymap", "opts" }
plugin:map_group("lsp", {
  declaration = { "<cmd>lua vim.lsp.buf.declaration()<CR>", default = { "n", "gD" } },
  definition = { "<cmd>lua vim.lsp.buf.definition()<CR>", default = "gd" },
  -- ...
})

--[[
autocmd *.py :lua require('myplugin').plugin:apply_group("python_mappings", 0)
--]]

-- TODO:
-- plugin:command { ... }
-- OR
-- does it go in register?

-- TODO:
-- plugin:autocmd { ... }
-- OR
-- doees it go in register?
