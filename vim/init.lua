--[[
 TODO:
- copilot setup
  Plug 'github/copilot.vim', { 'branch': 'release' }
  " autocmd VimEnter * Copilot setup
  Plug 'MunifTanjim/nui.nvim'
  Plug 'dense-analysis/neural'
- vim bbye
- tpope/vim-fugitive
- junegunn/gv.vim
- airblade/vim-gitgutter

- syntax checking?
Plug 'dense-analysis/ale'
let b:ale_fixers = {'python': ['black', 'pylint']}
" don't check line length
let g:ale_python_flake8_options = '--ignore=E501'

--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- Relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.opt.clipboard = 'unnamedplus'
-- end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--[[
MY CUSTOM STUFF
--]]

vim.keymap.set('n', 'n', 'nzz', { noremap = true, desc = 'search centers screen' })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true, desc = 'search centers screen' })

vim.keymap.set('n', 'K', 'i<cr><esc>', { desc = 'Split at cursor' })
vim.keymap.set('n', '>', '>>', { desc = 'Faster indent' })
vim.keymap.set('n', '<', '<<', { desc = 'Faster indent' })

vim.keymap.set('n', '<C-c>', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Yank to clipboard' })

vim.keymap.set('n', '<leader>fx', '<cmd>w<CR><cmd>bd<CR>', { desc = 'Save and quit' })
vim.keymap.set('n', '<leader>fs', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>fS', '<cmd>w !sudo tee %<CR>', { desc = 'Sudo write' })
vim.keymap.set('n', '<leader>fl', '<cmd>e<CR>', { desc = 'Reload file' })
vim.keymap.set('n', '<leader>fr', '<cmd>so $MYVIMRC<CR>', { desc = 'Reload configuration' })
vim.keymap.set('n', '<tab>', '<cmd>b#<CR>', { desc = 'Last buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bp<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>bd<CR>', { desc = 'Force close buffer' })
vim.keymap.set('n', '<leader>xx', '<cmd>wqa<CR>', { desc = 'Save quit all' })
vim.keymap.set('n', '<leader>qs', '<cmd>xall<CR>', { desc = 'Save quit all' })
vim.keymap.set('n', '<leader>qq', '<cmd>quitall<CR>', { desc = 'Quit all' })
vim.keymap.set('n', '<leader>qQ', '<cmd>quitall!<CR>', { desc = 'Quit all unprompted' })

vim.keymap.set('n', '!', ':! ', { desc = 'run shell command' })

vim.keymap.set('n', '<leader>i;', 'mzA;<esc>`z', { desc = 'Insert semicolon' })
vim.keymap.set('n', '<leader>i,', 'mzA,<esc>`z', { desc = 'Insert comma' })
vim.keymap.set('n', '<leader>i.', 'mzA.<esc>`z', { desc = 'Insert period' })
vim.keymap.set('n', '<leader>i?', 'mzA?<esc>`z', { desc = 'Insert question mark' })
vim.keymap.set('n', '<leader>i!', 'mzA!<esc>`z', { desc = 'Insert exclamation mark' })
vim.keymap.set('n', '<leader>i<cr>', 'o<esc>', { desc = 'Insert return' })

-- NOTE: debug conflicting mappings with eg ':verbose nmap gb'
vim.keymap.set('n', '<leader>hh', '<cmd>checkhealth<CR>', { desc = 'Check neovim health' })

-- vim.keymap.set('n', '<leader>ws', '<cmd>split<CR><cmd>wincmd w<CR>', { desc = 'Split window bottom' })
-- vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR><cmd>wincmd w<CR>', { desc = 'Split window right' })
vim.keymap.set('n', '<leader>ws', '<cmd>split<CR>', { desc = 'Split window bottom' })
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Split window right' })
vim.keymap.set('n', '<leader>wj', '<C-w>-', { desc = 'Resize window taller' })
vim.keymap.set('n', '<leader>wk', '<C-w>+', { desc = 'Resize window shorter' })
vim.keymap.set('n', '<leader>wh', '<C-w><', { desc = 'Resize window narrower' })
vim.keymap.set('n', '<leader>wl', '<C-w>>', { desc = 'Resize window wider' })
vim.keymap.set('n', '<leader>w=', '<cmd>wincmd =<CR>', { desc = 'Balance windows' })
vim.keymap.set('n', '<leader>wc', '<cmd>q<CR>', { desc = 'Close window' })

vim.keymap.set('n', '<leader>tn', '<cmd>setlocal invnumber<CR><cmd>setlocal invrelativenumber<CR>', { desc = 'Toggle line numbers' })
vim.keymap.set('n', '<leader>tr', '<cmd>setlocal invrelativenumber<CR>', { desc = 'Toggle relative line numbers' })
vim.keymap.set('n', '<leader>t\\', '<cmd>set list!<CR>', { desc = 'Toggle invisible chars' })
-- not needed for neovim?
vim.keymap.set('n', '<leader>tp', '<cmd>set paste!<CR>', { desc = 'Toggle paste' })

--[[
 TODO :
 UNPORTED STUFF FROM SPACEVIM

  call s:spacevim_bind('map', 'el', 'error-list', 'call SpacevimErrorList()', 1)
  call s:spacevim_bind('map', 'en', 'next-error', 'call SpacevimErrorNext()', 1)
  call s:spacevim_bind('map', 'eN', 'previous-error', 'call SpacevimErrorPrev()', 1)
  call s:spacevim_bind('map', 'ep', 'previous-error', 'call SpacevimErrorPrev()', 1)
if s:spacevim_is_layer_enabled('git')
  let g:lmap.g = { 'name': '+git/versions-control' }
  call s:spacevim_bind('map', 'gb', 'git-blame', 'Gblame', 1)
  call s:spacevim_bind('map', 'gc', 'git-commit', 'Gcommit', 1)
  call s:spacevim_bind('map', 'gC', 'git-checkout', 'Git checkout', 1)
  call s:spacevim_bind('map', 'gd', 'git-diff', 'Gdiff', 1)
  call s:spacevim_bind('map', 'gD', 'git-diff-head', 'Gdiff HEAD', 1)
  call s:spacevim_bind('map', 'gf', 'git-fetch', 'Gfetch', 1)
  call s:spacevim_bind('map', 'gF', 'git-pull', 'Gpull', 1)
  call s:spacevim_bind('map', 'gi', 'git-init', 'Git init', 1)
  call s:spacevim_bind('map', 'gI', 'git-ignore', 'Gedit .gitignore', 1)
  call s:spacevim_bind('map', 'gl', 'git-log', 'call SpacevimGitLog()', 1)
  call s:spacevim_bind('map', 'gL', 'git-log-buffer-file', 'GV!', 1)
  call s:spacevim_bind('map', 'gr', 'git-checkout-current-file', 'Gread', 1)
  call s:spacevim_bind('map', 'gR', 'git-remove-current-file', 'Gremove', 1)
  call s:spacevim_bind('map', 'gs', 'git-status', 'Gstatus', 1)
  call s:spacevim_bind('map', 'gS', 'git-stage-file', 'call feedkeys(":Git add -- ")', 1)
  call s:spacevim_bind('map', 'gw', 'git-stage-current-file', 'Gwrite', 1)

  if s:spacevim_is_layer_enabled('git/vcs-micro-state')
    let g:lmap.g['.'] = { 'name': '+vcs-micro-state' }
    call s:spacevim_bind('nmap', 'g.s', 'stage', 'GitGutterStageHunk', 1)
    call s:spacevim_bind('nmap', 'g.r', 'revert', 'GitGutterRevertHunk', 1)
    call s:spacevim_bind('nmap', 'g.h', 'show-hunk', 'GitGutterPreviewHunk', 1)
    call s:spacevim_bind('nmap', 'g.n', 'next', 'GitGutterNextHunk', 1)
    call s:spacevim_bind('nmap', 'g.N', 'previous', 'GitGutterPrevHunk', 1)
    call s:spacevim_bind('nmap', 'g.p', 'previous', 'GitGutterPrevHunk', 1)
    call s:spacevim_bind('nmap', 'g.t', 'toggle margin', 'GitGutterSignsToggle', 1)
  endif
nnoremap <Leader>ga :Git add --all<CR>
nnoremap <Leader>gp :Git push<CR>
endif
" }}}

  call s:spacevim_bind('map', 'sc', 'highlight-persist-remove-all', 'noh', 1)
  call s:spacevim_bind('map', 'sp', 'smart-search', 'Ag', 1)
  call s:spacevim_bind('nmap', 'ss', 'vim-swoop', 'call Swoop()', 1)
  call s:spacevim_bind('vmap', 'ss', 'vim-swoop', 'call SwoopSelection()', 1)
 call s:spacevim_bind('map', 'ts', 'syntax', 'call SpacevimToggleSyntax()', 1)

function! spacemacs#toggleAlleFolds()
  if &foldlevel
    normal! zM<CR>
    " set foldlevel=0
  else
    normal! zR<CR>
    " set foldlevel=20
  endif
endfunction
" Just copying from http://vimdoc.sourceforge.net/htmldoc/fold.html
call s:spacevim_bind('map', 'z', 'toggle-all-folds', "call spacemacs#toggleAlleFolds()", 1)
" NOTE: for some reason these are slow!
" call s:spacevim_bind('map', 'zz', 'toggle-all-folds', "call spacemacs#toggleAlleFolds()", 1)
"" call s:spacevim_bind('map', 'za', 'toggle-fold', "normal! za", 1)
" call s:spacevim_bind('map', 'za', 'toggle-fold', "za", 0)
" call s:spacevim_bind('map', 'zA', 'toggle-fold-recursive', "zA", 0)
" call s:spacevim_bind('map', 'zf', 'create-fold', "zf", 0)
" call s:spacevim_bind('map', 'zd', 'delete-fold', "zd", 0)
" call s:spacevim_bind('map', 'zD', 'delete-fold-recursive', "zD", 0)
" call s:spacevim_bind('map', 'zE', 'delete-all-folds', "zE", 0)
" call s:spacevim_bind('map', 'zR', 'open-all-folds', "zR", 0)
" call s:spacevim_bind('map', 'zM', 'close-all-folds', "zM", 0)
" call s:spacevim_bind('map', 'zo', 'open-fold', "zo", 0)
" call s:spacevim_bind('map', 'zO', 'open-fold-recursive', "zO", 0)
" call s:spacevim_bind('map', 'zc', 'close-fold', "zc", 0)
" call s:spacevim_bind('map', 'zC', 'close-fold-recursive', "zC", 0)

PLUGINS NEEDED

maybe: 'Chiel92/vim-autoformat'


--[[
END OF MY CUSTOM STUFF
--]]

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      -- vim.keymap.set('n', 'go', builtin.find_files, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>go', builtin.find_files, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '*', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      -- vim.keymap.set('n', 'gb', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      -- vim.keymap.set('n', '<leader>/', function()
      --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = false,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>sb', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch in all [b]uffers' })

      -- Shortcut for searching your Neovim configuration files
      -- vim.keymap.set('n', '<leader>sn', function()
      --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
      -- end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup {}
      vim.keymap.set('n', 'go', require('fzf-lua').files, { silent = true, desc = 'FZF Git Files' })
      vim.keymap.set('n', 'gb', require('fzf-lua').buffers, { silent = true, desc = 'FZF Buffers' })
      vim.keymap.set('n', 'gl', require('fzf-lua').lines, { silent = true, desc = 'FZF Lines' })
    end,
  },

  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    config = function()
      -- don't want the default mappings
      -- require('Comment').setup()
      local api = require 'Comment.api'
      vim.keymap.set('n', '<leader><cr>', api.toggle.linewise.current, { desc = 'Toggle comment' })
      vim.keymap.set('x', '<leader><cr>', function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = 'Toggle comment visual' })
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    'tpope/vim-repeat',
    version = '*',
  },

  {
    -- TODO: actual configuration?
    'Houl/repmo-vim',
    version = '*',
  },

  {
    'Yggdroot/indentLine',
    version = '*',
    config = function()
      vim.g.indentLine_enabled = 0
      vim.keymap.set('n', '<leader>ti', '<cmd>IndentLinesToggle<CR>', { desc = 'Toggle indentation lines' })
    end,
  },

  {
    --  displays marks in gutter
    'kshenoy/vim-signature',
    version = '*',
  },

  {
    'gbprod/yanky.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      require('yanky').setup()
      -- Configuration here, or leave empty to use defaults
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
      vim.keymap.set({ 'n', 'x' }, ']', '<Plug>(YankyNextEntry)')
      vim.keymap.set({ 'n', 'x' }, '[', '<Plug>(YankyPreviousEntry)')
    end,
  },

  {
    'junegunn/vim-easy-align',
    version = '*',
    config = function()
      vim.cmd [[nmap ga <Plug>(EasyAlign)]]
      vim.cmd [[xmap ga <Plug>(EasyAlign)]]
    end,
  },

  {
    'mbbill/undotree',
    version = '*',
    config = function()
      vim.keymap.set('n', '<leader>au', '<cmd>UndotreeToggle<cr>', { desc = 'Visualize undo tree' })
    end,
  },

  {
    'ervandew/supertab',
    version = '*',
  },

  {
    -- maximize and restore windows
    'szw/vim-maximizer',
    version = '*',
    config = function()
      vim.keymap.set('n', '<leader>wm', '<cmd>MaximizerToggle<cr>', { desc = 'Toggle maximize buffer' })
    end,
  },

  {
    -- make C-J etc work with tmux + vim
    'christoomey/vim-tmux-navigator',
    version = '*',
  },

  {
    'preservim/vimux',
    config = function()
      -- Helper function to set keybindings
      local function set_keymap(mode, lhs, rhs, desc)
        vim.keymap.set(mode, '<leader>' .. lhs, rhs, { desc = desc, silent = true, noremap = true })
      end

      -- Open Vimux runner
      set_keymap('n', 'rs', '<cmd>VimuxOpenRunner<CR>', 'Open Vimux runner')

      -- Function to send text in normal mode
      local function send_normal_vimux()
        local line = vim.api.nvim_get_current_line()
        vim.fn.VimuxSendText(line)
        vim.fn.VimuxSendKeys 'Enter'
      end

      -- Bind 'rl' in normal mode to run the current line
      set_keymap('n', 'rl', send_normal_vimux, 'Run current line in Vimux')

      -- Function to send text in visual mode
      local function send_visual_vimux()
        local saved_reg = vim.fn.getreg 'v'
        vim.cmd 'normal! gv"vy'
        local selected_text = vim.fn.getreg 'v'
        vim.fn.VimuxSendText(selected_text)
        vim.fn.VimuxSendKeys 'Enter'
        vim.fn.setreg('v', saved_reg)
      end

      -- Bind 'rl' in visual mode to run the selected lines
      vim.keymap.set('x', '<LocalLeader>rl', send_visual_vimux, { desc = 'Run selected lines in Vimux', silent = true })
    end,
  },

  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- DISABLED DUE TO polyglot having its own

  -- LANGUAGE SPECIFIC
  -- many languages
  -- NOTE: has trouble with conflict with 'tpope/vim-sleuth'?
  'sheerun/vim-polyglot',

  -- Python
  {
    'davidhalter/jedi-vim',
    ft = 'python',
    config = function()
      vim.g['jedi#popup_on_dot'] = l
    end,
    lazy = true,
  },
  { 'integralist/vim-mypy', ft = 'python', lazy = true },

  -- JavaScript
  { 'pangloss/vim-javascript', ft = 'javascript', lazy = true },

  -- TypeScript
  { 'ianks/vim-tsx', ft = { 'typescript', 'typescriptreact' }, lazy = true },
  {
    'Quramy/tsuquyomi',
    ft = 'typescript',
    dependencies = { 'Shougo/vimproc.vim' },
    lazy = true,
  },
  { 'leafgarland/typescript-vim', ft = 'typescript', lazy = true },

  -- Svelte
  {
    'evanleck/vim-svelte',
    branch = 'main',
    ft = 'svelte',
    config = function()
      vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
        pattern = { '*.svelte', '*.sve' },
        command = 'set syntax=html',
      })
    end,
    lazy = true,
  },

  -- Elm
  {
    'ElmCast/elm-vim',
    ft = 'elm',
    config = function()
      vim.g.elm_format_autosave = 1
    end,
    lazy = true,
  },

  -- Rust
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    config = function()
      -- NOTE: C-J and C-K cause issues with rust, has something to do with delimitMate
      vim.g.rustfmt_autosave = 0 -- Set to 1 if you want to enable auto formatting on save
    end,
    lazy = true,
  },

  -- JSON
  {
    'elzr/vim-json',
    ft = 'json',
    config = function()
      vim.g.vim_json_syntax_conceal = 0
    end,
    lazy = true,
  },

  -- Markdown
  { 'tpope/vim-markdown', ft = 'markdown', lazy = true },

  -- LaTeX
  {
    -- causes issues with mapping <C-j> due to IMAP
    'vim-latex/vim-latex',
    ft = 'tex',
    config = function()
      vim.g.tex_flavor = 'latex'
      -- IMPORTANT: grep will sometimes skip displaying the file name if you
      -- search in a single file. This will confuse Latex-Suite. Set your grep
      -- program to always generate a file-name.
      vim.opt.grepprg = 'grep -nH $*'
    end,
    lazy = true,
  },

  -- Lean
  {
    'Julian/lean.nvim',
    ft = 'lean',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      -- Optional Dependencies:
      'hrsh7th/nvim-cmp', -- for LSP
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/vim-vsnip', -- for snippets
      'andrewradev/switch.vim', -- for Lean switch support
      'tomtom/tcomment_vim', -- for commeting motions
      'nvim-telescope/telescope.nvim', -- for Loogle search
    },
    lazy = true,
  },

  -- disabled for now
  -- { 'cohama/lexima.vim', { ft = 'lisp' },
  -- { 'cespare/vim-toml', { ft = 'toml' },
  -- { 'fatih/vim-go', { ft = 'go' },
  -- { 'nsf/gocode', { ft = 'go' },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>sd', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'slate'
      -- vim.cmd.colorscheme 'desert'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'

      vim.keymap.set('n', '<leader>cs', '<cmd>Telescope colorscheme<CR>', { desc = 'Change colorscheme' })
    end,
  },

  -- Highlight todo, notes, etc in comments
  -- NOTE: by default only matches with a colon to avoid false positives
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- don't show signs in the gutter
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
