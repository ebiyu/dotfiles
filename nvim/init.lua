vim.api.nvim_exec([[

source $HOME/.vim/vimrc

set inccommand=split
tnoremap <esc> <c-\><c-n>
"set cmdheight=0

]], false)

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    "lambdalisue/fern.vim",
})
vim.api.nvim_set_keymap('n', '<C-b>', ':Fern . -reveal=% <CR>', { noremap = true, silent = true })
