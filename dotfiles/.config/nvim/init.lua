vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("packer").startup({{
	{ "wbthomason/packer.nvim" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-path" },
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

require('nvim_comment').setup({comment_empty = false})

vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope live_grep<CR>", { noremap = true })

require("hop").setup()
vim.api.nvim_set_keymap("n", "\\", ":HopChar1<CR>", { noremap = true })
vim.api.nvim_set_keymap("o", "\\", ":HopChar1<CR>", { noremap = true })

require("nvim-surround").setup({})

vim.o.background = "dark"
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = false,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  overrides = {
      Comment = { italic = true },
      String = { italic = true },
  },
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


-- Setup buffer-local keymaps / options for LSP buffers
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_attach = function(client, buf)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(buf, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "g[", "<cmd>lua vim.lsp.buf.goto_next()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "g]", "<cmd>lua vim.lsp.buf.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buf, "n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
	vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

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

