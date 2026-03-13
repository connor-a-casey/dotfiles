vim.opt.termguicolors = true

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = false,
  integrations = {
    cmp = true,
    gitsigns = true,
    treesitter = true,
    telescope = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
  color_overrides = {
    mocha = {
      base = "#000000",
      mantle = "#0A0A0A",
      crust = "#000000",

      text = "#f8f8f0",
      subtext1 = "#d0d0d0",
      subtext0 = "#a8a8a8",

      overlay2 = "#b3b3b3",
      overlay1 = "#8a8a8a",
      overlay0 = "#5f5f5f",

      surface2 = "#2c313a",
      surface1 = "#1E1E1E",
      surface0 = "#141414",

      pink = "#ff7edb",
      mauve = "#e040fb",
      red = "#ff5252",
      maroon = "#f73232",
      peach = "#ff8b39",
      yellow = "#fede5d",
      green = "#47ffa0",
      teal = "#72f1b8",
      sky = "#40c4ff",
      sapphire = "#36f9f6",
      blue = "#2ee2fa",
      lavender = "#848bbd",
      flamingo = "#ff3366",
      rosewater = "#ffffff",
    },
  },
  custom_highlights = function(c)
    return {
      Normal = { fg = "#f8f8f0", bg = "#000000" },
      NormalNC = { fg = "#f8f8f0", bg = "#000000" },
      EndOfBuffer = { fg = "#000000", bg = "#000000" },
      SignColumn = { bg = "#000000" },

      CursorLine = { bg = "#101010" },
      CursorLineNr = { fg = "#ffffff", bold = true },
      LineNr = { fg = "#5f5f5f" },

      Visual = { bg = "#264dff" },
      Search = { fg = "#000000", bg = "#40c4ff", bold = true },
      IncSearch = { fg = "#000000", bg = "#ff3366", bold = true },

      Comment = { fg = "#848bbd", italic = true },

      String = { fg = "#ff8b39" },
      Character = { fg = "#36f9f6" },
      Number = { fg = "#f97e72" },
      Boolean = { fg = "#1afc65", bold = true },
      Constant = { fg = "#f97e72" },

      Identifier = { fg = "#f73232" },
      Function = { fg = "#36f9f6" },
      Type = { fg = "#fe4450" },
      Keyword = { fg = "#fede5d" },
      Conditional = { fg = "#fede5d" },
      Repeat = { fg = "#fede5d" },
      Operator = { fg = "#fede5d" },

      Statement = { fg = "#fede5d" },
      PreProc = { fg = "#72f1b8" },
      Special = { fg = "#ff7edb" },
      Delimiter = { fg = "#b6b1b1" },

      DiagnosticError = { fg = "#ff5252" },
      DiagnosticWarn = { fg = "#ffab40" },
      DiagnosticInfo = { fg = "#40c4ff" },
      DiagnosticHint = { fg = "#47ffa0" },

      Pmenu = { fg = "#f8f8f0", bg = "#1E1E1E" },
      PmenuSel = { fg = "#ffffff", bg = "#2c313a", bold = true },
      PmenuSbar = { bg = "#141414" },
      PmenuThumb = { bg = "#8a8a8a" },

      NormalFloat = { fg = "#f8f8f0", bg = "#1E1E1E" },
      FloatBorder = { fg = "#1E1E1E", bg = "#1E1E1E" },

      TelescopeNormal = { fg = "#f8f8f0", bg = "#1E1E1E" },
      TelescopeBorder = { fg = "#1E1E1E", bg = "#1E1E1E" },
      TelescopePromptNormal = { fg = "#f8f8f0", bg = "#0A0A0A" },
      TelescopePromptBorder = { fg = "#ff3366", bg = "#0A0A0A" },
      TelescopeSelection = { bg = "#2c313a" },

      StatusLine = { fg = "#ffffff", bg = "#000000" },
      StatusLineNC = { fg = "#b3b3b3", bg = "#000000" },

      WinSeparator = { fg = "#181A1F" },
      VertSplit = { fg = "#181A1F" },

      Directory = { fg = "#40c4ff" },
      Title = { fg = "#ffffff", bold = true },
      ErrorMsg = { fg = "#ff5252", bold = true },
      WarningMsg = { fg = "#ffab40", bold = true },
    }
  end,
})

vim.cmd.colorscheme("catppuccin")
