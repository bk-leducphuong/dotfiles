-- ~/.config/nvim/snippets/javascript.lua
local ls = require("luasnip")

-- Shorthand functions for creating snippets
local s = ls.s         -- 's' for snippet
local i = ls.i         -- 'i' for insert node (placeholder)
local t = ls.t         -- 't' for text node (static text)
local rep = ls.extras.rep -- 'rep' for repeat (repeats a placeholder)

return {
  -- This is the "smart" console.log snippet
  s("clog", {
    t("console.log('"), -- Static text
    i(1, "variable"),  -- Placeholder 1, with "variable" as default text
    t(":', "),         -- Static text
    rep(1),            -- Repeats the text from Placeholder 1
    t(")"),            -- Static text
    i(0)               -- Final cursor position
  }),

  -- Bonus: A simple console.log snippet
  s("cl", {
    t("console.log("),
    i(1),              -- Placeholder 1 (empty)
    t(")"),
    i(0)               -- Final cursor position
  }),
}
