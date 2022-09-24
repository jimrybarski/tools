vim.opt.completeopt = "menu,menuone"

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
}, config = {}})

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
vim.cmd("set signcolumn=yes")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set expandtab")


-- Setup cmp
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({ 
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		['<CR>'] = cmp.mapping.confirm({ select = true }), 
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
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
	}, {
		{ name = "buffer", keyword_length = 3 },
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
	vim.api.nvim_buf_set_keymap(buf, "n", "gf", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
	vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

-- Setup rust_analyzer via rust-tools.nvim
require("rust-tools").setup({
	server = {
		capabilities = capabilities,
		on_attach = lsp_attach,
	}
})

-- Keymaps for Luasnip
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
