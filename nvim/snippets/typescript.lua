-- ~/.config/nvim/snippets/typescript.lua
local ls = require("luasnip")

-- Shorthand functions
local s = ls.s
local i = ls.i
local t = ls.t
local rep = ls.extras.rep
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Console log with type
  s("clog", {
    t("console.log('"),
    i(1, "variable"),
    t(":', "),
    rep(1),
    t(")"),
    i(0),
  }),

  -- Simple console.log
  s("cl", {
    t("console.log("),
    i(1),
    t(")"),
    i(0),
  }),

  -- TypeScript interface
  s("interface", fmt([[
interface {} {{
  {}
}}
  ]], {
    i(1, "InterfaceName"),
    i(0, "// properties"),
  })),

  -- TypeScript type
  s("type", fmt([[
type {} = {}
  ]], {
    i(1, "TypeName"),
    i(0, "{}"),
  })),

  -- Arrow function
  s("af", fmt([[
const {} = ({}) => {{
  {}
}}
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(0, "// body"),
  })),

  -- Async arrow function
  s("aaf", fmt([[
const {} = async ({}) => {{
  {}
}}
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(0, "// body"),
  })),

  -- Export named function
  s("expf", fmt([[
export const {} = ({}) => {{
  {}
}}
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(0, "// body"),
  })),

  -- Export async function
  s("expaf", fmt([[
export const {} = async ({}) => {{
  {}
}}
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(0, "// body"),
  })),

  -- Import statement
  s("imp", fmt([[
import {{ {} }} from '{}'
  ]], {
    i(1, "module"),
    i(2, "./path"),
  })),

  -- Import default
  s("impd", fmt([[
import {} from '{}'
  ]], {
    i(1, "module"),
    i(2, "./path"),
  })),

  -- Try-catch block
  s("try", fmt([[
try {{
  {}
}} catch (error) {{
  console.error('{}:', error)
  {}
}}
  ]], {
    i(1, "// code"),
    i(2, "Error message"),
    i(0),
  })),

  -- Async try-catch
  s("atry", fmt([[
try {{
  {}
}} catch (error) {{
  console.error('{}:', error)
  {}
}}
  ]], {
    i(1, "await someFunction()"),
    i(2, "Error message"),
    i(0),
  })),

  -- Class component
  s("class", fmt([[
class {} {{
  constructor({}) {{
    {}
  }}

  {}
}}
  ]], {
    i(1, "ClassName"),
    i(2, "params"),
    i(3, "// constructor body"),
    i(0, "// methods"),
  })),

  -- TypeScript enum
  s("enum", fmt([[
enum {} {{
  {} = '{}',
  {}
}}
  ]], {
    i(1, "EnumName"),
    i(2, "VALUE"),
    rep(2),
    i(0),
  })),

  -- Describe test block
  s("desc", fmt([[
describe('{}', () => {{
  {}
}})
  ]], {
    i(1, "test suite"),
    i(0, "// tests"),
  })),

  -- It test block
  s("it", fmt([[
it('{}', () => {{
  {}
}})
  ]], {
    i(1, "test description"),
    i(0, "// test body"),
  })),

  -- Async it test
  s("ait", fmt([[
it('{}', async () => {{
  {}
}})
  ]], {
    i(1, "test description"),
    i(0, "// test body"),
  })),

  -- React useState
  s("us", fmt([[
const [{}, set{}] = useState({})
  ]], {
    i(1, "state"),
    rep(1),
    i(0, "initialValue"),
  })),

  -- React useEffect
  s("ue", fmt([[
useEffect(() => {{
  {}
}}, [{}])
  ]], {
    i(1, "// effect"),
    i(0, "dependencies"),
  })),

  -- React useCallback
  s("ucb", fmt([[
const {} = useCallback(({}) => {{
  {}
}}, [{}])
  ]], {
    i(1, "memoizedCallback"),
    i(2, "params"),
    i(3, "// callback body"),
    i(0, "dependencies"),
  })),

  -- React useMemo
  s("um", fmt([[
const {} = useMemo(() => {}, [{}])
  ]], {
    i(1, "memoizedValue"),
    i(2, "computeValue()"),
    i(0, "dependencies"),
  })),

  -- Promise
  s("prom", fmt([[
new Promise((resolve, reject) => {{
  {}
}})
  ]], {
    i(0, "// promise body"),
  })),

  -- Ternary operator
  s("tern", fmt([[
{} ? {} : {}
  ]], {
    i(1, "condition"),
    i(2, "true"),
    i(3, "false"),
  })),
}
