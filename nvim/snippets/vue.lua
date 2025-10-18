-- ~/.config/nvim/snippets/vue.lua
local ls = require("luasnip")
-- Snippet shorthand functions
local s = ls.s
local i = ls.i
local t = ls.t

-- This function will be called by your main config
return {
  -- This is your Vue component snippet
  s("com", {
    t({ "<template>", "  <div>", "    " }),
    i(1, "component content"), -- i(1) is the first placeholder
    t({ "", "  </div>", "</template>", "" }),
    t({ "<script>", "" }),
    i(2), -- i(2) is the second placeholder
    t({ "", "</script>", "" }),
    t({ "<style lang="scss" scoped>", "" }),
    i(3), -- i(3) is the third placeholder
    t({ "", "</style>", "" }),
    i(0), -- i(0) is the final cursor position after jumping through all placeholders
  }),
}
