local plugin = vim.plugin.register {
  name = "test_plug",
}

plugin:map {
  name = "TestPlugMappingOne",
  fn = function()
    print "Yoo, dawg, we did it. Part 2"
  end,
  -- condition = ...
}
