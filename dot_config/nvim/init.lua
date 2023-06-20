-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- load base vimrc
vim.api.nvim_exec([[source $HOME/.vimrc]], false)

vim.o.inccommand = "split"
vim.o.laststatus = 3
-- vim.o.cmdheight = 0 -- TODO: skkeleton with cmdheight=1
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
                actions = {
                    open_file = {
                        quit_on_open = true
                    }
                }
            }
            vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeFindFile<CR>')
        end
    },
    "nvim-tree/nvim-web-devicons",
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            "SmiteshP/nvim-navic",
            "nvimdev/zephyr-nvim",
            'nvim-lua/lsp-status.nvim',
        },
        config = function()
            local lsp_names = function()
                local clients = {}
                for _, client in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
                    if client.name == 'null-ls' then
                        local sources = {}
                        for _, source in ipairs(require('null-ls.sources').get_available(vim.bo.filetype)) do
                            table.insert(sources, source.name)
                        end
                        table.insert(clients, 'null-ls(' .. table.concat(sources, ', ') .. ')')
                    else
                        table.insert(clients, client.name)
                    end
                end
                return ' ' .. table.concat(clients, ', ')
            end
            require('lualine').setup {
                options = {
                    colored = true,
                    icons_enabled = true,
                    theme = 'nord',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
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
                    lualine_c = { 'filename', 'navic' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { lsp_names, 'progress' },
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
                tabline = {
                    lualine_a = {
                        {
                            'buffers',
                            buffers_color = {
                                active = 'lualine_a_active',
                                inactive = 'lualine_a_inactive',
                            },
                            symbols = { modified = '[+]', alternate_file = '', directory = ' ' },
                        },
                    },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {
                        'diff'
                    },
                    lualine_y = {
                        'branch'
                    },
                    lualine_z = {
                        { 'tabs' },
                    },
                },
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
        config = function()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { ".venv/", ".git/", "node_modules" }
                }
            }
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<c-p>', function() builtin.find_files { hidden = true } end, {})
            vim.keymap.set('n', '<c-;>', builtin.keymaps, {})
        end
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require "telescope".load_extension("frecency")
            vim.api.nvim_set_keymap("n", "<c-f>",
                "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", { noremap = true, silent = true })
        end,
        dependencies = { "kkharji/sqlite.lua", 'nvim-telescope/telescope.nvim' }
    },
    {
        "img-paste-devs/img-paste.vim",
        config = function()
            vim.api.nvim_exec([[
                autocmd FileType markdown nmap <buffer><silent> <space>p :call mdip#MarkdownClipboardImage()<CR>
                " there are some defaults for image directory and image name, you can change them
                " let g:mdip_imgdir = 'img'
                " let g:mdip_imgname = 'image'
            ]], false)
        end
    },


    -- lsp
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig",
    'L3MON4D3/LuaSnip',
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    'saadparwaiz1/cmp_luasnip',
    'nvim-lua/lsp-status.nvim',

    {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            local navic = require("nvim-navic")
            navic.setup {
                lsp = {
                    auto_attach = true,
                    preference = nil,
                },
                highlight = true,

            }
        end
    },

    {
        'monaqa/dial.nvim',
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group {
                -- default augends used when no group name is specified
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
                },
            }

            vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
            vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
            vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), { noremap = true })
            vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), { noremap = true })
            vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
            vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
            vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
            vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
        end
    },

    {
        "github/copilot.vim",
        config = function()
            -- workaround: ignore error
            pcall(function()
                -- check Node version for copilot.vim
                -- cf. https://rcmdnk.com/blog/2022/09/28/computer-vim/
                local ver = io.popen('node --version'):read('*a')
                local node_version = string.gmatch(ver, "%w+")
                local nodev_table = {}
                for match in node_version do
                    table.insert(nodev_table, match)
                end
                local ver_major = nodev_table[1]
                if string.find(ver_major, 'v', 1, true) == 1 then
                    ver_major = string.sub(ver_major, 2)
                end

                -- if not supported, check nodenv and use latest version
                if tonumber(ver_major) < 16 then
                    ver = io.popen('nodenv whence node|sort -n|tail -n1|tr -d "\n"'):read('*a')
                    vim.g.copilot_node_command = io.popen('NODENV_VERSION=' .. ver .. ' nodenv which node|tr -d "\n"')
                        :read(
                            '*a')
                end
            end)
        end
    },
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
                    vim.keymap.set('n', '<space>gs', gs.stage_hunk, { desc = '[git] Stage hunk' })
                    vim.keymap.set('n', '<space>gr', gs.reset_hunk, { desc = '[git] Reset hunk' })
                    vim.keymap.set('v', '<space>gs', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                        { desc = '[git] Stage hunk' })
                    vim.keymap.set('v', '<space>gr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                        { desc = '[git] Reset hunk' })
                    vim.keymap.set('n', '<space>gS', gs.stage_buffer, { desc = '[git] Stage buffer' })
                    vim.keymap.set('n', '<space>gu', gs.undo_stage_hunk, { desc = '[git] Undo stage hunk' })
                    vim.keymap.set('n', '<space>gR', gs.reset_buffer, { desc = '[git] Reset buffer' })
                    vim.keymap.set('n', '<space>gp', gs.preview_hunk, { desc = '[git] Preview hunk' })
                    vim.keymap.set('n', '<space>gb', function() gs.blame_line { full = true } end,
                        { desc = '[git] Blame line' })
                    vim.keymap.set('n', '<space>gd', gs.diffthis, { desc = '[git] Diff this' })
                    vim.keymap.set('n', '<space>gD', function() gs.diffthis('~') end,
                        { desc = '[git] Diff this (against HEAD)' })
                    vim.keymap.set('n', '<space>gd', gs.toggle_deleted, { desc = '[git] Toggle deleted' })
                end
            }
        end
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
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

    {
        "vim-skk/skkeleton",
        dependencies = {
            "vim-denops/denops.vim",
        },
        config = function()
            vim.keymap.set('i', '<c-j>', '<Plug>(skkeleton-enable)')
            vim.keymap.set('c', '<c-j>', '<Plug>(skkeleton-enable)')

            local dictpath = vim.fn.expand("$HOME/.skk/SKK-JISYO.L")
            if vim.loop.fs_stat(dictpath) then
                vim.api.nvim_exec([[
                    call skkeleton#config({ 'globalJisyo': '~/.skk/SKK-JISYO.L' })
                ]], false)
            end
        end
    },
    {
        "tani/hey.vim",
        dependencies = {
            "vim-denops/denops.vim",
        },
    },


    {
        'prettier/vim-prettier',
        build = 'yarn install --frozen-lockfile --production',
        config = function()
            vim.api.nvim_create_augroup('vimrc_augroup', {})
            vim.api.nvim_create_autocmd('FileType', {
                group = 'vimrc_augroup',
                pattern = '*',
                callback = function(args)
                    local prettier_types = { "typescript", "typescriptreact", "javascript", "javascriptreact", "css",
                        "html" }
                    for i = 1, #prettier_types do
                        if args.match == prettier_types[i] then
                            vim.keymap.set('n', '<space>lf', "<cmd>Prettier<cr>",
                                { desc = '[LSP] Format (prettier)', buffer = true })
                            break
                        end
                    end
                end
            })
        end
    },
})

vim.api.nvim_create_augroup('vimrc_lsp', {})
vim.api.nvim_create_autocmd('FileType', {
    group = 'vimrc_lsp',
    pattern = '*',
    callback = function(args)
        local function ts_rename_file()
            local source_file, target_file

            source_file = vim.api.nvim_buf_get_name(0)

            vim.ui.input({
                    prompt = "Target : ",
                    completion = "file",
                    default = source_file
                },
                function(input)
                    target_file = input
                end
            )

            local params = {
                command = "_typescript.applyRenameFile",
                arguments = {
                    {
                        sourceUri = source_file,
                        targetUri = target_file,
                    },
                },
                title = ""
            }

            vim.lsp.util.rename(source_file, target_file)
            vim.lsp.buf.execute_command(params)
        end
        local ts_types = { "typescript", "typescriptreact" }
        for i = 1, #ts_types do
            if args.match == ts_types[i] then
                vim.keymap.set('n', '<space>lN', ts_rename_file,
                    { desc = '[LSP] Rename file (typescript)', buffer = true })
            end
        end
    end
})


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
        --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'nvim_lsp_signature_help' },
        -- { name = 'path' },
        { name = 'buffer' },
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

-- map frequently used
-- vim.keymap.set('n', '<space><space>', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', { desc = '[LSP] Format' })

-- map key prefix
local wk = require("which-key")
wk.register({
    l = { name = "+LSP" },
    g = { name = "+git" },
}, { prefix = "<space>", mode = "n" })

wk.register({
    g = { name = "+git" },
}, { prefix = "<space>", mode = "v" })

vim.keymap.set('n', '<space>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = '[LSP] Hover' })
vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, { desc = '[LSP] Format' })
vim.keymap.set('n', '<space>lr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = '[LSP] References' })
vim.keymap.set('n', '<space>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = '[LSP] Go to definition' })
vim.keymap.set('n', '<space>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = '[LSP] Go to declaration' })
vim.keymap.set('n', '<space>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = '[LSP] Go to implementation' })
vim.keymap.set('n', '<space>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = '[LSP] Go to type definition' })
vim.keymap.set('n', '<space>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = '[LSP] Rename symbol' })
vim.keymap.set('n', '<space>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = '[LSP] Code action' })
vim.keymap.set('n', '<space>le', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = '[LSP] Open diagnostics' })
vim.keymap.set('n', '<space>l]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = '[LSP] Go to next diagnostic' })
vim.keymap.set('n', '<space>l[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = '[LSP] Go to previous diagnostic' })

vim.keymap.set('v', '<space>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = '[LSP] Hover' })
vim.keymap.set('v', '<space>lf', function() vim.lsp.buf.format { async = true } end, { desc = '[LSP] Format' })
vim.keymap.set('v', '<space>lr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = '[LSP] References' })
vim.keymap.set('v', '<space>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = '[LSP] Go to definition' })
vim.keymap.set('v', '<space>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = '[LSP] Go to declaration' })
vim.keymap.set('v', '<space>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = '[LSP] Go to implementation' })
vim.keymap.set('v', '<space>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = '[LSP] Go to type definition' })
vim.keymap.set('v', '<space>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = '[LSP] Rename symbol' })
vim.keymap.set('v', '<space>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = '[LSP] Code action' })
vim.keymap.set('v', '<space>le', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = '[LSP] Open diagnostics' })
vim.keymap.set('v', '<space>l]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = '[LSP] Go to next diagnostic' })
vim.keymap.set('v', '<space>l[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = '[LSP] Go to previous diagnostic' })

-- tree sitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
}

-- clipboard
-- from. https://zenn.dev/skanehira/articles/2021-11-29-vim-paste-clipboard-link
vim.api.nvim_exec([[
    let s:clipboard_register = has('linux') || has('unix') ? '+' : '*'
    function! InsertMarkdownLink() abort
      " use register `9`
      let old = getreg('9')
      let link = trim(getreg(s:clipboard_register))
      if link !~# '^http.*'
        normal! gvp
        return
      endif

      " replace `[text](link)` to selected text
      normal! gv"9y
      let word = getreg(9)
      let newtext = printf('[%s](%s)', word, link)
      call setreg(9, newtext)
      normal! gv"9p

      " restore old data
      call setreg(9, old)
    endfunction

    augroup markdown-insert-link
      au!
      au FileType markdown vnoremap <buffer> <silent> p :<C-u>call InsertMarkdownLink()<CR>
    augroup END
]], false)
