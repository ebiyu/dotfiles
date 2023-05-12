-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- load base vimrc
vim.api.nvim_exec([[source $HOME/.vim/vimrc]], false)

vim.o.inccommand = "split"
vim.o.laststatus = 3
vim.o.cmdheight = 0
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    -- colorscheme
    {
        "nvimdev/zephyr-nvim",
        requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
        config = function()
            require('zephyr')
        end
    },
    'editorconfig/editorconfig-vim',
    "tpope/vim-surround",

    -- filer
    -- fern
    -- {
    --     "lambdalisue/fern.vim",
    --     config = function()
    --         vim.keymap.set('n', '<C-b>', '<cmd>Fern . -reveal=% <CR>')
    --     end
    -- },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require('nvim-tree').setup {
                view = {
                    float = {
                        enable = false,
                    }
                }
            }
            vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeFindFile<CR>')
        end
    },
    "nvim-tree/nvim-web-devicons",

    -- file finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- lsp
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },
    "williamboman/mason-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",

    {
        "nvim-treesitter/nvim-treesitter",
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 0,
                    ignore_whitespace = false,
                },
            }
        end
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    "RRethy/vim-illuminate",
})


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

local masonconfig = require('mason-lspconfig')
masonconfig.setup {
    ensure_installed = {
        'bashls',
        'jedi_language_server',
        'gopls',
        'lua_ls',
        'quick_lint_js',
        'tsserver',
        'jsonls',
        'html',
        'cssls',
        'eslint',
    },
    automatic_installation = {},
}

masonconfig.setup_handlers {
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

        -- setup keymaps handlers
        vim.keymap.set('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', { buffer = true })
    end,
}
vim.keymap.set('n', '<space><space>', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
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
require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
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
