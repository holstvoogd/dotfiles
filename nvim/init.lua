-- init.lua

-- Set leader key first, before lazy setup
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
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

-- Basic vim options
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.hidden = true
vim.opt.history = 10000
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.visualbell = true
vim.opt.autoread = true
vim.opt.termguicolors = true

-- Indentation settings
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- Search settings
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- List chars (whitespace visualization)
vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  nbsp = '␣',
  trail = '•',
  extends = '⟩',
  precedes = '⟨'
}

-- Window splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Plugin specifications
require("lazy").setup({
  -- Core plugins from your setup
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "vim-ruby/vim-ruby",
  "godlygeek/tabular",
  'MunifTanjim/nui.nvim',

  -- Solarized Light theme
  {
    'ishan9299/nvim-solarized-lua',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = 'light'
      vim.cmd('colorscheme solarized')
    end,
  },
  
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'solarized',
          icons_enabled = true,
        }
      })
    end
  },
  
-- Modern file explorer
{
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  requires = { 
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
    'MunifTanjim/nui.nvim',
  },
  config = function()
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require('neo-tree').setup({
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "*",
        },
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "",
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
          },
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<2-LeftMouse>"] = "open",
          ["<cr>"] = "open",
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["C"] = "close_node",
          ["R"] = "refresh",
          ["a"] = "add",
          ["d"] = "delete",
          ["r"] = "rename",
          ["c"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["q"] = "close_window",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db"
          },
          never_show = {
            ".DS_Store",
            "thumbs.db"
          },
        },
        follow_current_file = true,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
      },
      buffers = {
        follow_current_file = true,
        group_empty_dirs = true,
        show_unloaded = true,
      },
      git_status = {
        window = {
          position = "float",
        },
      },
    })
  end,
},
  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
          layout_strategy = 'horizontal',
          layout_config = { 
            horizontal = { width = 0.95, height = 0.95 }
          },
        },
      })
      telescope.load_extension('fzf')
    end,
  },

  -- Better buffer deletion
  "famiu/bufdelete.nvim",

  -- Modern git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 300,
        },
      })
    end,
  },

  -- Enhanced text objects
  "wellle/targets.vim",

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt" },
        enable_check_bracket_line = true,
      })
    end,
  },

  -- Better incremental search
  "haya14busa/is.vim",

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "diff" },
        auto_install = true,
      })
    end
  },

  -- Copilot and CopilotChat
  "github/copilot.vim",
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    build = "make tiktoken",
    opts = {
      show_help = "yes",
      debug = false,
      disable_extra_info = 'no',
    },
    keys = {
      { "\\cc", ":CopilotChat ", desc = "CopilotChat - Ask about code" },
      { "\\ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "\\cf", "<cmd>CopilotChatFix<cr>", desc = "CopilotChat - Fix code" },
      { "\\ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      -- Visual mode mappings for selected code
      { "\\ce", ":CopilotChatExplain<cr>", mode = "v", desc = "CopilotChat - Explain selected code" },
      { "\\cf", ":CopilotChatFix<cr>", mode = "v", desc = "CopilotChat - Fix selected code" },
      { "\\ct", ":CopilotChatTests<cr>", mode = "v", desc = "CopilotChat - Generate tests for selected code" },
      { "\\co", ":CopilotChatOptimize<cr>", mode = "v", desc = "CopilotChat - Optimize selected code" },
      { "\\cd", ":CopilotChatDocs<cr>", mode = "v", desc = "CopilotChat - Generate documentation for selected code" },
      { "\\cc", ":CopilotChat ", mode = "v", desc = "CopilotChat - Ask about selected code" },
      { "\\cr", ":CopilotChatReview<cr>", mode = "v", desc = "CopilotChat - Review selected code" },
    },
  },
})

-- Keymaps
local keymap = vim.keymap.set

-- Window navigation
keymap('n', '<C-Left>', '<C-w>h')
keymap('n', '<C-Down>', '<C-w>j')
keymap('n', '<C-Up>', '<C-w>k')
keymap('n', '<C-Right>', '<C-w>l')

-- Buffer navigation
keymap('n', '<C-t>', ':enew<CR>')
keymap('n', '<C-S-Right>', ':bnext<CR>')
keymap('n', '<C-S-Left>', ':bprevious<CR>')
keymap('n', '<C-w>', ':Bdelete<CR>')  -- Using bufdelete.nvim

-- File navigation
keymap('n', '\\d', ':NvimTreeToggle<CR>')

-- Telescope mappings
keymap('n', '\\ff', ':Telescope find_files<CR>')
keymap('n', '\\fg', ':Telescope live_grep<CR>')
keymap('n', '\\fb', ':Telescope buffers<CR>')
keymap('n', '\\fh', ':Telescope help_tags<CR>')

-- Git mappings
keymap('n', '\\gb', ':Gitsigns toggle_current_line_blame<CR>')
keymap('n', '\\hs', ':Gitsigns stage_hunk<CR>')
keymap('n', '\\hr', ':Gitsigns reset_hunk<CR>')

-- Make Y behave like C and D
keymap('n', 'Y', 'y')

-- Clear search highlighting
keymap('n', '<C-c>', ':noh<CR>')

-- Sudo write
vim.cmd([[cnoremap sudow w !sudo tee % >/dev/null]])
