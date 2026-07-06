local dap = require 'dap'
dap.configurations.python = {
  {
    type = 'debugpy',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      return '/usr/bin/python'
    end,
  },
}
