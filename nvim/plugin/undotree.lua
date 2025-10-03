vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.g.undotree_SetFocusWhenToggle = true

local map = require('me.keymap').map
map("n", "<leader>u", function() vim.cmd.UndotreeToggle() end, { desc = "Toffle undotree buffer" })
