require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "bash", "bibtex", "c", "cpp", "dockerfile", "git_config", "gitcommit", "gitignore", "html", "json", "lua", "make", "python", "r", "rust", "toml", "vim", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
