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
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('zephyr')
        end
    },
    'editorconfig/editorconfig-vim',
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    },

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
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    },


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
    'L3MON4D3/LuaSnip',
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    'saadparwaiz1/cmp_luasnip',

    {
        "nvim-treesitter/nvim-treesitter",
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
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
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    vim.keymap.set('n', '<space>g', gs.diffthis)
                end
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

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                -- for example, context is off by default, use this to turn it on
                show_current_context = true,
                -- show_current_context_start = true,
            }
        end
    },
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

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    -- mapping = {
    --     ['<Tab>'] = function(fallback)
    --         if cmp.visible() then
    --             cmp.select_next_item()
    --         else
    --             fallback()
    --         end
    --     end,
    --     ['<c-n>'] = function(fallback)
    --         if cmp.visible() then
    --             cmp.select_next_item()
    --         else
    --             fallback()
    --         end
    --     end,
    --     ['<c-p>'] = function(fallback)
    --         if cmp.visible() then
    --             cmp.select_prev_item()
    --         else
    --             fallback()
    --         end
    --     end
    -- },
    --
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'nvim_lsp_signature_help' },
        -- { name = 'path' },
        -- { name = 'buffer' },
        -- { name = 'nvim_lua' },
        { name = 'luasnip' },
        -- { name = 'cmdline' },
        -- { name = 'git' },
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
        'emmet_ls',
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
    },
}
