local abbreviations = {
  -- Logic and proofs
  ["\\lam"] = "λ",
  ["\\forall"] = "∀",
  ["\\exists"] = "∃",
  ["\\not"] = "¬",
  ["\\and"] = "∧",
  ["\\or"] = "∨",
  ["\\to"] = "→",
  ["\\gets"] = "←",
  ["\\mapsto"] = "↦",
  ["\\iff"] = "↔",
  ["\\vdash"] = "⊢",
  ["\\models"] = "⊨",
  ["\\top"] = "⊤",
  ["\\bot"] = "⊥",

  -- Relations and sets
  ["\\ne"] = "≠",
  ["\\le"] = "≤",
  ["\\ge"] = "≥",
  ["\\equiv"] = "≡",
  ["\\approx"] = "≈",
  ["\\in"] = "∈",
  ["\\notin"] = "∉",
  ["\\subset"] = "⊂",
  ["\\subseteq"] = "⊆",
  ["\\supset"] = "⊃",
  ["\\supseteq"] = "⊇",
  ["\\union"] = "∪",
  ["\\inter"] = "∩",
  ["\\emptyset"] = "∅",

  -- Number systems and operators
  ["\\nat"] = "ℕ",
  ["\\int"] = "ℤ",
  ["\\rat"] = "ℚ",
  ["\\real"] = "ℝ",
  ["\\complex"] = "ℂ",
  ["\\sum"] = "∑",
  ["\\prod"] = "∏",
  ["\\times"] = "×",
  ["\\cdot"] = "·",
  ["\\circ"] = "∘",
  ["\\infty"] = "∞",
  ["\\partial"] = "∂",
  ["\\nabla"] = "∇",
  ["\\langle"] = "⟨",
  ["\\rangle"] = "⟩",

  -- Greek letters
  ["\\alpha"] = "α",
  ["\\beta"] = "β",
  ["\\gamma"] = "γ",
  ["\\delta"] = "δ",
  ["\\epsilon"] = "ε",
  ["\\theta"] = "θ",
  ["\\kappa"] = "κ",
  ["\\mu"] = "μ",
  ["\\pi"] = "π",
  ["\\rho"] = "ρ",
  ["\\sigma"] = "σ",
  ["\\tau"] = "τ",
  ["\\phi"] = "φ",
  ["\\psi"] = "ψ",
  ["\\omega"] = "ω",
  ["\\Gamma"] = "Γ",
  ["\\Delta"] = "Δ",
  ["\\Theta"] = "Θ",
  ["\\Sigma"] = "Σ",
  ["\\Phi"] = "Φ",
  ["\\Psi"] = "Ψ",
  ["\\Omega"] = "Ω",
}

local disabled_filetypes = {
  plaintex = true,
  tex = true,
}

function _G.UnicodeAbbrev(command)
  if disabled_filetypes[vim.bo.filetype] then
    return command
  end

  local lhs = "\\" .. command
  local before_cursor = vim.fn.getline("."):sub(1, vim.fn.col(".") - 1)

  if before_cursor:sub(-#lhs) == lhs then
    return "\b" .. abbreviations[lhs]
  end

  return command
end

for lhs in pairs(abbreviations) do
  local command = lhs:sub(2)
  vim.cmd(([[iabbrev <expr> %s v:lua.UnicodeAbbrev("%s")]]):format(command, command))
end
