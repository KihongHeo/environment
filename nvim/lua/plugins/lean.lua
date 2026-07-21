vim.g.lean_config = {
  mappings = true,
  -- Kitty graphics can corrupt split separators when Neovim runs through
  -- tmux/SSH. Infoview keeps its text fallbacks with graphics disabled.
  graphics = {
    enabled = false,
  },
  infoview = {
    update_cooldown = 250,
  },
}
