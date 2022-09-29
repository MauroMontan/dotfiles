local use = require('packer').use
-- TODO: Refactor all the code !!!!

require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use "williamboman/nvim-lsp-installer"
  use 'xiyaowong/nvim-transparent'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim"
  }
  use 'norcalli/nvim-colorizer.lua'
  use 'simrat39/symbols-outline.nvim'
  use 'folke/lsp-colors.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use "onsails/lspkind-nvim"
  use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'kyazdani42/nvim-web-devicons'
  use 'kevinhwang91/rnvimr'
  use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'windwp/nvim-autopairs'
  use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end }
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'numToStr/Comment.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-lualine/lualine.nvim'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use "rafamadriz/friendly-snippets"
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
end)

vim.wo.cursorline = true

local set = vim.opt -- set options
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
vim.opt.expandtab = true
local customKeymap = vim.api.nvim_set_keymap
local custom_opts = { noremap = true }

require("symbols-outline").setup()
customKeymap('n', '<c-j>', '<c-w>j', custom_opts)
customKeymap('n', '<c-h>', '<c-w>h', custom_opts)
customKeymap('n', '<c-k>', '<c-w>k', custom_opts)
customKeymap('n', '<c-l>', '<c-w>l', custom_opts)

local lspkind = require('lspkind')
require("trouble").setup {}

-- Lua
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

require("transparent").setup({
  enable = true, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be cleared
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude = {}, -- table: groups yaou don't want to clear
})


vim.cmd [[autocmd BufWritePost *.ts,*.js EslintFixAll]]
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
customKeymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
customKeymap('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<cr>', {})
customKeymap('n', '<c-s>', '<cmd>w<cr>', { noremap = true, silent = true })
customKeymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
customKeymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })



require("nvim-lsp-installer").setup {}
require('nvim-autopairs').setup {}
require("todo-comments").setup {}
--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = false

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.o.termguicolors = true

vim.o.clipboard = "unnamedplus"

require 'colorizer'.setup()

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })



require 'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  }
}


require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}


vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

require("catppuccin").setup()

vim.cmd [[colorscheme catppuccin]]



--Set statusbar
require('lualine').setup {
  theme = 'catppuccin',
  options = {
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
  },
}


-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gdscript', 'sumneko_lua', 'eslint', 'gopls', 'prismals', 'rust_analyzer', 'html', 'jsonls', 'cssls',
  'dockerls', 'clangd',
  'prismals',
  'volar', 'pyright', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python", "css", "prisma", "cpp", "html", "dockerfile", "markdown", "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "vue" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}



-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = "treesitter" },
    { name = 'luasnip' },
    { name = 'ultisnips' },
    { name = 'cmp_tabnine' }
  },

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end
    })
  }

}

require("luasnip.loaders.from_vscode").lazy_load()



require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "ios/", "build/", "node_modules/", ".git/", ".dart_tool/", ".idea/", "macos/" },
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",


      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

require("telescope").load_extension("flutter")
require('telescope').load_extension('fzf')
--Add leader shortcuts
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', 'fc', ":Telescope flutter commands<cr>")

vim.keymap.set('n', '<leader>f', function()
  require('telescope.builtin').find_files { hidden = true }
end)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>so', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require 'nvim-tree'.setup {
  view = {
    side = "left",

  }
}
require("flutter-tools").setup {} -- use defaults
