local mason = require("mason")
local mason_nvim_dap = require("mason-nvim-dap")

mason.setup({})
mason_nvim_dap.setup({ automatic_setup = true })
mason_nvim_dap.setup_handlers({})
