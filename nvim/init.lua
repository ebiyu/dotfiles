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
    "tpope/vim-surround",
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },
    "williamboman/mason-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "tpope/vim-commentary",
    {
        "nvim-treesitter/nvim-treesitter",
    },
    {
        "nvimdev/zephyr-nvim",
        requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
})

-- colorscheme
require('zephyr')

-- fern
vim.keymap.set('n', '<C-b>', '<cmd>Fern . -reveal=% <CR>', { noremap = true, silent = true })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})

-- nvim-cmp
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
        end
    },

    mapping = {
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<c-n>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<c-p>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'cmdline' },
        { name = 'git' },
    }),
}

-- lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

require("mason").setup()
require('mason-lspconfig').setup_handlers {
    function(server_name)
        local opts = {
            capabilities = capabilities,
        }
        if server_name == "lua_ls" then
            opts.settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                }
            }
        end
        lspconfig[server_name].setup(opts)
    end,
}

vim.keymap.set('n', '<space><space>', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- tree sitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
