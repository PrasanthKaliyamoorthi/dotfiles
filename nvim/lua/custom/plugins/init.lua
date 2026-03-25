-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = { transparent_background = true },
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  {
    'mbbill/undotree',

    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndoTree' })
    end,
    desc = 'undotree',
  },
  {
    'folke/zen-mode.nvim',
    config = function()
      vim.keymap.set('n', '<leader>zz', function()
        require('zen-mode').setup {
          window = {
            width = 90,
            options = {},
          },
        }
        require('zen-mode').toggle()
        vim.wo.wrap = false
        vim.wo.number = true
        vim.wo.rnu = true
      end, { desc = 'Zen Mode (wide)' })

      vim.keymap.set('n', '<leader>zZ', function()
        require('zen-mode').setup {
          window = {
            width = 80,
            options = {},
          },
        }
        require('zen-mode').toggle()
        vim.wo.wrap = false
        vim.wo.number = false
        vim.wo.rnu = false
        vim.opt.colorcolumn = '0'
      end, { desc = 'Zen Mode (narrow)' })
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'git stats' })

      local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup('ThePrimeagen_Fugitive', {})

      local autocmd = vim.api.nvim_create_autocmd
      autocmd('BufWinEnter', {
        group = ThePrimeagen_Fugitive,
        pattern = '*',
        callback = function()
          if vim.bo.ft ~= 'fugitive' then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr, remap = false }

          vim.keymap.set('n', '<leader>ga', function()
            vim.cmd.Git 'add -A'
          end, { desc = 'git add -A' }, opts)

          vim.keymap.set('n', '<leader>gc', function()
            vim.cmd.Git 'commit'
          end, { desc = 'git commit' }, opts)

          vim.keymap.set('n', '<leader>gp', function()
            vim.cmd.Git 'push'
          end, { desc = 'git push' }, opts)

          vim.keymap.set('n', '<leader>gg', function()
            vim.cmd.Git { 'pull' }
          end, { desc = 'git pull ' }, opts)

          -- rebase always
          vim.keymap.set('n', '<leader>gP', function()
            vim.cmd.Git { 'pull', '--rebase' }
          end, { desc = 'git pull + rebase' }, opts)

          -- NOTE: It allows me to easily set the branch i am pushing and any tracking
          -- needed if i did not set the branch up correctly
          vim.keymap.set('n', '<leader>t', ':Git push -u origin ', { desc = 'git push -u origin' }, opts)
        end,
      })

      vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>', { desc = 'git diffget' })
      vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>', { desc = 'git diffget' })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ' '
      else
        vim.o.laststatus = 0
      end
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'folke/snacks.nvim',
    opts = {
      dashboard = {
        preset = {
          header = [[
███████╗ ██████╗ ██╗      █████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
██╔════╝██╔═══██╗██║     ██╔══██╗██╔══██╗██║   ██║██║████╗ ████║
███████╗██║   ██║██║     ███████║██████╔╝██║   ██║██║██╔████╔██║
╚════██║██║   ██║██║     ██╔══██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
███████║╚██████╔╝███████╗██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
 ]],
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ' ', key = 'o', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    keys = {
      { '<leader>nn', '', desc = '+noice' },
      {
        '<S-Enter>',
        function()
          require('noice').redirect(vim.fn.getcmdline())
        end,
        mode = 'c',
        desc = 'Redirect Cmdline',
      },
      {
        '<leader>nnl',
        function()
          require('noice').cmd 'last'
        end,
        desc = 'Noice Last Message',
      },
      {
        '<leader>nnh',
        function()
          require('noice').cmd 'history'
        end,
        desc = 'Noice History',
      },
      {
        '<leader>nna',
        function()
          require('noice').cmd 'all'
        end,
        desc = 'Noice All',
      },
      {
        '<leader>nnd',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = 'Dismiss All',
      },
      {
        '<leader>nnt',
        function()
          require('noice').cmd 'pick'
        end,
        desc = 'Noice Picker (Telescope/FzfLua)',
      },
      {
        '<c-f>',
        function()
          if not require('noice.lsp').scroll(4) then
            return '<c-f>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll Forward',
        mode = { 'i', 'n', 's' },
      },
      {
        '<c-b>',
        function()
          if not require('noice.lsp').scroll(-4) then
            return '<c-b>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll Backward',
        mode = { 'i', 'n', 's' },
      },
    },
    config = function(_, opts)
      if vim.o.filetype == 'lazy' then
        vim.cmd [[messages clear]]
      end
      require('noice').setup(opts)
    end,
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
    specs = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      {
        '<leader>nd',
        function()
          require('notify').dismiss { pending = true, silent = true }
        end,
        desc = 'Dismiss notifications',
        mode = 'n',
      },
    },
    init = function() end,
    opts = function(_, opts)
      opts.icons = {
        DEBUG = '',
        ERROR = '',
        INFO = '󰋼',
        TRACE = '󰌵',
        WARN = '',
      }
      opts.max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end
      opts.max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end
      opts.on_open = function(win)
        -- local astrocore = require 'astrocore'
        -- vim.api.nvim_win_set_config(win, { zindex = 175 })
        -- if not astrocore.config.features.notifications then
        -- vim.api.nvim_win_close(win, true)
        -- return
        -- end
        -- if astrocore.is_available 'nvim-treesitter' then
        --   require('lazy').load { plugins = { 'nvim-treesitter' } }
        -- end
        vim.wo[win].conceallevel = 3
        local buf = vim.api.nvim_win_get_buf(win)
        if not pcall(vim.treesitter.start, buf, 'markdown') then
          vim.bo[buf].syntax = 'markdown'
        end
        vim.wo[win].spell = false
      end
    end,
    config = function(...)
      require 'custom.setup.notify'(...)
    end,
  },
}
