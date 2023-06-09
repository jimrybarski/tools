vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("packer").startup({{
	{ "wbthomason/packer.nvim" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
    { "ray-x/lsp_signature.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "simrat39/rust-tools.nvim" },
    { "phaazon/hop.nvim" },
    { "kylechui/nvim-surround" },
    { "nvim-telescope/telescope.nvim", tag = '0.1.0',},
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
    { "terrortylor/nvim-comment" },
    { "lervag/vimtex" },
    { "RRethy/vim-illuminate" },
    { "tpope/vim-fugitive" },
}, config = {}})

require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
    }
})

vim.g.vimtex_view_method = 'zathura'
-- Ignore warnings about relatively trivial things that latex spams us with
vim.g.vimtex_quickfix_ignore_filters = {'Underfull', 'Overfull', 'Marginpar'}
vim.g.vimtex_view_forward_search_on_start = 0
vim.g.vimtex_complete_enabled = 1

require('nvim_comment').setup({comment_empty = false})

vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope live_grep<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>b", 'daW:read !curl -LH "Accept: text/bibliography; style=bibtex" http://dx.doi.org/<C-r>" 2>/dev/null <CR><CR>kdd0x', { noremap = true })

require("hop").setup()
vim.api.nvim_set_keymap("n", "\\", ":HopChar1<CR>", { noremap = true })
vim.api.nvim_set_keymap("o", "\\", ":HopChar1<CR>", { noremap = true })

require("nvim-surround").setup({})

vim.o.background = "dark"
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
      strings = true,
      comments = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  dim_inactive = false,
  transparent_mode = false,
})

vim.cmd("colorscheme gruvbox")
vim.cmd("set number relativenumber")
vim.cmd("set nobackup nowritebackup")
vim.cmd("set signcolumn=yes")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set expandtab")

vim.api.nvim_create_autocmd("FileType", { pattern = { "tsv", "csv" }, command = "set noexpandtab" })

-- Setup cmp
local cmp = require("cmp")
cmp.setup({
    preselect = cmp.PreselectMode.None,
	mapping = cmp.mapping.preset.insert({ 
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		['<CR>'] = cmp.mapping.confirm({ select = false }), 
        ["<Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
            cmp.select_next_item()
	      else
            fallback()
	      end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}),
})



vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
vim.keymap.set("n", "g[", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "g]", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "gr", vim.lsp.buf.rename, {})
vim.keymap.set("n", "ge", vim.lsp.buf.references, {})
vim.keymap.set("n", "gf", vim.lsp.buf.format, {})

-- Setup buffer-local keymaps / options for LSP buffers
-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local lsp_attach = function(client, buf)
-- 	local opts = { noremap = true, silent = true }
-- 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
--     vim.api.nvim_buf_set_keymap(buf, "n", "gt", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- 	vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
-- 	vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
-- 	vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
--     vim.api.nvim_create_autocmd("BufWritePre", { 
--         callback = function()
--             vim.lsp.buf.format()
--         end,
--         buffer = buf,
--     })

    -- require "lsp_signature".on_attach({
    --   bind = true, -- This is mandatory, otherwise border config won't get registered.
    --   handler_opts = {
    --     border = "rounded"
    --   }
    -- }, buf)
-- end

require'lsp_signature'.setup({
  debug = false, -- set to true to enable debug logging
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  doc_lines = 3, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window
  noice = false, -- set to true if you using noice to render markdown
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = false, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
                              -- can be either number or function, see examples

  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
})

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.texlab.setup{}
lspconfig.pylsp.setup({
  root_dir = function(fname)
          local root_files = {
              "pyproject.toml",
              "setup.py",
              "setup.cfg",
              "requirements.txt",
              "Pipfile",
          }
          return util.root_pattern(unpack(root_files))(fname)
              or util.find_git_ancestor(fname)
              or vim.fn.expand("%:p:h")
      end,
})


-- Setup rust_analyzer via rust-tools.nvim
require("rust-tools").setup({
	server = {
		capabilities = capabilities,
		on_attach = lsp_attach,
        settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy"
				}
			}
		}
	}
})
