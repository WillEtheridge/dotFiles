-- Turner Venice colorscheme - inspired by J.M.W. Turner's "Venice - The Dogana and San Giorgio Maggiore"
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "turner-venice"

-- Color palette extracted from Turner's Venice painting - optimized for dark background
local colors = {
  -- Background
  bg_main = "#0d0f08", -- Deep dark background
  bg_subtle = "#1a1d12", -- Slightly lighter background
  bg_highlight = "#252820", -- Highlighted background

  -- Sky and atmosphere - bright and clear
  sky_blue = "#6db4e8", -- Bright clear blue
  pale_blue = "#a8d4f0", -- Very light blue

  -- Water reflections - vibrant
  water = "#7ec4d0", -- Bright cyan-blue water
  water_bright = "#b0e4e8", -- Very bright water highlights

  -- Architecture and structures - bright warm tones
  white_stone = "#f8f4e8", -- Bright warm white
  terracotta = "#e88860", -- Vibrant bright terracotta
  warm_stone = "#f0d8b0", -- Warm golden stone

  -- Boats and details - vibrant oranges
  sail_orange = "#f0b060", -- Bright warm orange
  sail_bright = "#ffd090", -- Very bright sail highlights
  boat_timber = "#c09070", -- Light warm timber

  -- Golden light - bright yellows
  gold_light = "#ffe8a8", -- Bright golden light
  gold_warm = "#ffd878", -- Warm golden glow

  -- Text colors - high contrast
  fg_main = "#e8e4d8", -- Main text - bright warm white
  fg_bright = "#f8f4e8", -- Very bright text
  fg_subtle = "#b8b0a0", -- Dimmer text

  -- Accent colors - vibrant and distinct
  accent_red = "#f06850", -- Bright red
  accent_pink = "#ff9880", -- Bright pink-red
}

-- Helper function to set highlights
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor UI
hl("Normal", { fg = colors.fg_main, bg = "NONE" })
hl("NormalFloat", { fg = colors.fg_main, bg = "NONE" })
hl("FloatBorder", { fg = colors.sky_blue, bg = "NONE" })
hl("ColorColumn", { bg = colors.bg_highlight })
hl("Cursor", { fg = colors.bg_main, bg = colors.fg_bright })
hl("CursorLine", { bg = "NONE" }) -- Transparent, no highlight
hl("CursorLineNr", { fg = colors.gold_warm, bold = true })
hl("LineNr", { fg = colors.fg_subtle })
hl("SignColumn", { bg = "NONE" })
hl("VertSplit", { fg = colors.bg_highlight, bg = colors.bg_main })
hl("WinSeparator", { fg = colors.sky_blue, bg = "NONE" })
hl("Folded", { fg = colors.fg_subtle, bg = colors.bg_highlight })
hl("FoldColumn", { fg = colors.fg_subtle, bg = colors.bg_main })
hl("MatchParen", { fg = colors.accent_pink, bold = true, underline = true })
hl("Visual", { bg = colors.gold_warm, fg = colors.bg_main })
hl("Search", { fg = colors.bg_main, bg = colors.gold_warm })
hl("IncSearch", { fg = colors.bg_main, bg = colors.sail_orange })
hl("Pmenu", { fg = colors.fg_main, bg = colors.bg_subtle })
hl("PmenuSel", { fg = colors.fg_bright, bg = colors.sky_blue })
hl("PmenuSbar", { bg = colors.bg_highlight })
hl("PmenuThumb", { bg = colors.water })

-- Status line
hl("StatusLine", { fg = colors.fg_main, bg = colors.bg_highlight })
hl("StatusLineNC", { fg = colors.fg_subtle, bg = colors.bg_subtle })
hl("TabLine", { fg = colors.fg_subtle, bg = colors.bg_subtle })
hl("TabLineFill", { bg = "NONE" })
hl("TabLineSel", { fg = colors.fg_bright, bg = colors.bg_highlight })

-- Messages
hl("ErrorMsg", { fg = colors.accent_red, bold = true })
hl("WarningMsg", { fg = colors.sail_orange })
hl("ModeMsg", { fg = colors.water })
hl("MoreMsg", { fg = colors.sky_blue })
hl("Question", { fg = colors.pale_blue })

-- Syntax highlighting
hl("Comment", { fg = colors.fg_subtle, italic = true })
hl("Constant", { fg = colors.terracotta })
hl("String", { fg = colors.water })
hl("Character", { fg = colors.water_bright })
hl("Number", { fg = colors.terracotta })
hl("Boolean", { fg = colors.accent_pink })
hl("Float", { fg = colors.terracotta })
hl("Identifier", { fg = colors.fg_main })
hl("Function", { fg = colors.sky_blue })
hl("Statement", { fg = colors.accent_red })
hl("Conditional", { fg = colors.accent_red })
hl("Repeat", { fg = colors.accent_red })
hl("Label", { fg = colors.accent_pink })
hl("Operator", { fg = colors.sail_orange })
hl("Keyword", { fg = colors.accent_red })
hl("Exception", { fg = colors.accent_pink })
hl("PreProc", { fg = colors.boat_timber })
hl("Include", { fg = colors.warm_stone })
hl("Define", { fg = colors.warm_stone })
hl("Macro", { fg = colors.boat_timber })
hl("PreCondit", { fg = colors.boat_timber })
hl("Type", { fg = colors.gold_warm })
hl("StorageClass", { fg = colors.gold_warm })
hl("Structure", { fg = colors.sail_orange })
hl("Typedef", { fg = colors.gold_warm })
hl("Special", { fg = colors.sail_bright })
hl("SpecialChar", { fg = colors.sail_bright })
hl("Tag", { fg = colors.accent_red })
hl("Delimiter", { fg = colors.fg_main })
hl("SpecialComment", { fg = colors.pale_blue })
hl("Debug", { fg = colors.accent_pink })
hl("Underlined", { fg = colors.sky_blue, underline = true })
hl("Ignore", { fg = colors.fg_subtle })
hl("Error", { fg = colors.accent_red, bg = colors.bg_main })
hl("Todo", { fg = colors.bg_main, bg = colors.gold_warm, bold = true })

-- Treesitter
hl("@variable", { fg = colors.fg_main })
hl("@variable.builtin", { fg = colors.accent_pink })
hl("@variable.parameter", { fg = colors.warm_stone })
hl("@variable.member", { fg = colors.fg_bright })
hl("@constant", { fg = colors.terracotta })
hl("@constant.builtin", { fg = colors.accent_pink })
hl("@module", { fg = colors.boat_timber })
hl("@string", { fg = colors.water })
hl("@character", { fg = colors.water_bright })
hl("@number", { fg = colors.terracotta })
hl("@boolean", { fg = colors.accent_pink })
hl("@function", { fg = colors.sky_blue })
hl("@function.builtin", { fg = colors.pale_blue })
hl("@function.macro", { fg = colors.boat_timber })
hl("@keyword", { fg = colors.accent_red })
hl("@keyword.function", { fg = colors.accent_red })
hl("@keyword.operator", { fg = colors.accent_red })
hl("@keyword.return", { fg = colors.accent_pink })
hl("@operator", { fg = colors.sail_orange })
hl("@type", { fg = colors.gold_warm })
hl("@type.builtin", { fg = colors.gold_light })
hl("@attribute", { fg = colors.warm_stone })
hl("@property", { fg = colors.fg_bright })
hl("@constructor", { fg = colors.sail_bright })
hl("@tag", { fg = colors.accent_red })
hl("@tag.attribute", { fg = colors.gold_warm })
hl("@tag.delimiter", { fg = colors.fg_subtle })

-- LSP
hl("DiagnosticError", { fg = colors.accent_red })
hl("DiagnosticWarn", { fg = colors.sail_orange })
hl("DiagnosticInfo", { fg = colors.sky_blue })
hl("DiagnosticHint", { fg = colors.water })
hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.accent_red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.sail_orange })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.sky_blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = colors.water })

-- Git signs
hl("GitSignsAdd", { fg = colors.water })
hl("GitSignsChange", { fg = colors.gold_warm })
hl("GitSignsDelete", { fg = colors.accent_red })

-- Diff
hl("DiffAdd", { fg = colors.sky_blue, bg = colors.bg_highlight })
hl("DiffChange", { fg = colors.gold_warm, bg = colors.bg_highlight })
hl("DiffDelete", { fg = colors.accent_red, bg = colors.bg_highlight })
hl("DiffText", { fg = colors.sail_bright, bg = colors.bg_subtle })

-- Telescope
hl("TelescopeBorder", { fg = colors.sky_blue })
hl("TelescopePromptBorder", { fg = colors.water })
hl("TelescopeResultsBorder", { fg = colors.sky_blue })
hl("TelescopePreviewBorder", { fg = colors.pale_blue })
hl("TelescopeSelection", { fg = colors.fg_bright, bg = colors.bg_highlight })
hl("TelescopeSelectionCaret", { fg = colors.sail_orange })
hl("TelescopeMatching", { fg = colors.gold_light, bold = true })

-- Neo-tree
hl("NeoTreeNormal", { fg = colors.fg_main, bg = "NONE" })
hl("NeoTreeDirectoryIcon", { fg = colors.sky_blue })
hl("NeoTreeDirectoryName", { fg = colors.sky_blue })
hl("Directory", { fg = colors.sky_blue })
hl("NeoTreeFileName", { fg = colors.fg_main })
hl("NeoTreeFileIcon", { fg = colors.fg_subtle })
hl("NeoTreeGitAdded", { fg = colors.gold_warm })
hl("NeoTreeGitModified", { fg = colors.gold_warm })
hl("NeoTreeGitDeleted", { fg = colors.accent_red })
hl("SnacksPickerGitAdded", { fg = colors.gold_warm })
hl("SnacksPickerGitStatusUntracked", { fg = colors.terracotta })
hl("SnacksPickerGitStatusAdded", { fg = colors.gold_warm })

-- Which-key
hl("WhichKey", { fg = colors.sky_blue })
hl("WhichKeyGroup", { fg = colors.boat_timber })
hl("WhichKeyDesc", { fg = colors.fg_main })
hl("WhichKeySeparator", { fg = colors.fg_subtle })
hl("WhichKeyFloat", { bg = colors.bg_subtle })
