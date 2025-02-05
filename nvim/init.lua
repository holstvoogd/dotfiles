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
  {
    "tpope/vim-surround",
    event = "BufRead",
  },
  {
    "tpope/vim-repeat",
    event = "BufRead",
  },
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

  -- Buffer line
  {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          buffer_close_icon = '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 15,
          tab_size = 18,
          diagnostics = false,
          offsets = {{filetype = "NeoTree", text = "File Explorer", text_align = "left"}},
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          separator_style = "slant",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          sort_by = 'id',
        }
      }
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
            hide_dotfiles = true,
            hide_gitignored = true,
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
          virt_text_pos = "right_align"
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
    keys = {
      { "\\cc", ":CopilotChat ", desc = "CopilotChat - Ask about code", mode = { "n", "v" } },
      { "\\cd", "<cmd>CopilotChatDocs<cr>", desc = "CopilotChat - Generate documentation for selected code", mode = "v" },
      { "\\ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code", mode = { "n", "v" } },
      { "\\cf", "<cmd>CopilotChatFix<cr>", desc = "CopilotChat - Fix code", mode = { "n", "v" } },
      { "\\cm", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Write commit message for the change", mode = { "v", "n" } },
      { "\\co", "<cmd>CopilotChatOptimize<cr>", desc = "CopilotChat - Optimize selected code", mode = "v" },
      { "\\cr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review selected code", mode = "v" },
      { "\\ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests", mode = { "n", "v" } },
    },
    opts = {
      show_help = "yes",
      debug = false,
      disable_extra_info = 'no',
      window = {
        layout = 'float',
        relative = 'cursor',
        width = 1,
        height = 0.4,
        row = 1
      },
      prompts = {
        Commit = {
          prompt = '> #git:staged\n\nWrite commit message for the change using the following format:\n<Issue ID if available from the git branch name> <Short description of the change>\n<More detailed description, if necessary>. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
        },
      },
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
keymap('n', '\\d', ':NeoTreeShowToggle<CR>')

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
vim.api.nvim_set_keymap('c', 'sudow', 'w !sudo tee % >/dev/null', { noremap = true, silent = true })

-- Auto generate commit message
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    -- Only run for COMMIT_EDITMSG and not MERGE_MSG or other git files
    if not filename:match("COMMIT_EDITMSG$") then
      return
    end
    -- Check if the buffer only contains default git commit comments
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local is_empty = true
    for _, line in ipairs(lines) do
      if not line:match("^#") and line ~= "" then
        is_empty = false
        break
      end
    end
    if is_empty then
      vim.schedule(function()
        -- Ensure the plugin is loaded
        require('CopilotChat')
        vim.cmd('CopilotChatCommit')
      end)
    end
  end
})
