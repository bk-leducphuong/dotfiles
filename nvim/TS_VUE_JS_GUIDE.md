# TypeScript, Vue, and JavaScript Development Guide

This guide covers all the features and keybindings configured for an optimal TS/Vue/JS development experience.

## ?? Features

### TypeScript Tools Features
- **Inlay Hints**: Inline type annotations for parameters, variables, and return types
- **Auto-imports**: Automatic import suggestions and additions
- **Organize Imports**: Smart import organization and cleanup
- **Code Actions**: Quick fixes, refactoring, and more
- **Go to Source**: Jump to actual implementation, not just type definitions
- **File References**: Find all files that import/use current file
- **Enhanced Completions**: Better autocomplete with snippets and documentation

### Vue Features (Volar)
- **Vue 3 Support**: Full Vue 3 composition API and script setup support
- **TypeScript in Vue**: Full TypeScript support in `<script>` blocks
- **Template Type-checking**: Type checking in Vue templates
- **Auto-imports**: Auto-import Vue components and composables
- **Inlay Hints**: Type hints in Vue components
- **CSS/SCSS Support**: Full styling support with auto-completion

### ESLint Integration
- **Auto-fix on Save**: Automatically fix ESLint errors when saving
- **Inline Diagnostics**: See ESLint errors directly in your code
- **Code Actions**: Quick fixes for ESLint rules

### Formatting (Prettier)
- **Format on Save**: Automatically format files on save
- **Multi-language**: Works with TS, JS, Vue, HTML, CSS, JSON, etc.
- Manual format: `<leader>fm` (in normal or visual mode)

## ?? Keybindings

### General LSP Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to where symbol is defined (Telescope) |
| `gD` | Go to Declaration | Jump to symbol declaration |
| `gr` | Go to References | Show all references (Telescope) |
| `gi` | Go to Implementation | Jump to implementation (Telescope) |
| `gt` | Go to Type Definition | Jump to type definition (Telescope) |
| `K` | Hover | Show documentation/type info |
| `<C-k>` | Signature Help | Show function signature |

### Code Actions & Refactoring
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ca` | Code Action | Show available code actions |
| `<leader>rn` | Rename | Rename symbol across project |

### TypeScript Specific (prefix: `<leader>t`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>to` | Organize Imports | Smart organize imports |
| `<leader>ts` | Sort Imports | Sort imports alphabetically |
| `<leader>tu` | Remove Unused | Remove unused imports |
| `<leader>tf` | Fix All | Apply all auto-fixes |
| `<leader>ta` | Add Missing Imports | Add missing imports |
| `<leader>tg` | Go to Source | Jump to source definition |
| `<leader>tr` | Rename File | Rename file & update imports |
| `<leader>ti` | File References | Show files importing this one |
| `<leader>th` | Toggle Inlay Hints | Show/hide type hints |

### Diagnostics (Errors/Warnings)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>d` | Show Diagnostic | Show diagnostic at cursor |
| `[d` | Previous Diagnostic | Jump to previous error/warning |
| `]d` | Next Diagnostic | Jump to next error/warning |
| `<leader>dl` | Diagnostic List | Open diagnostics in location list |
| `<leader>dq` | Diagnostic Quickfix | Open diagnostics in quickfix |

### Workspace
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>wa` | Add Workspace Folder | Add folder to workspace |
| `<leader>wr` | Remove Workspace Folder | Remove folder from workspace |
| `<leader>wl` | List Workspace Folders | Show all workspace folders |

### Symbols & Search
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ds` | Document Symbols | Browse symbols in current file |
| `<leader>ws` | Workspace Symbols | Search symbols in workspace |

### Formatting
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>fm` | Format | Format file or selection |
| `<leader>lf` | LSP Format | Format using LSP (fallback) |

## ?? Configuration Tips

### Adjusting Inlay Hints
Inlay hints show inline type information. If they're too cluttered, modify in `typescript-tools.lua`:

```lua
includeInlayParameterNameHints = "none", -- Options: "none" | "literals" | "all"
includeInlayVariableTypeHints = false,
includeInlayFunctionLikeReturnTypeHints = false,
```

Or toggle them temporarily with `<leader>th`.

### Memory Settings
For large projects, adjust TypeScript memory limit in `typescript-tools.lua`:

```lua
tsserver_max_memory = 8192, -- Increase if needed (in MB)
```

### Disable Semantic Tokens
If experiencing performance issues, uncomment in `typescript-tools.lua`:

```lua
client.server_capabilities.semanticTokensProvider = nil
```

### ESLint Auto-fix
Auto-fix is enabled by default on save. To disable, comment out the autocmd in `lsp.lua`:

```lua
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   buffer = bufnr,
--   command = "EslintFixAll",
-- })
```

### Prettier Configuration
Custom Prettier settings can be added in `formatter.lua`:

```lua
formatters = {
  prettier = {
    prepend_args = {
      "--single-quote",
      "--no-semi",
      "--tab-width=2",
    },
  },
},
```

## ?? Required Mason Packages

Make sure these are installed via Mason (`:Mason`):
- `volar` - Vue language server
- `eslint` - ESLint LSP
- `html` - HTML language server
- `cssls` - CSS language server
- `jsonls` - JSON language server
- `prettier` - Code formatter
- `eslint_d` - Fast ESLint daemon (optional but recommended)

## ?? Troubleshooting

### TypeScript not working in Vue files
1. Make sure you have a `tsconfig.json` in your project
2. Ensure Vue files are included in tsconfig:
   ```json
   {
     "include": ["src/**/*.ts", "src/**/*.vue"]
   }
   ```

### Inlay hints not showing
1. Requires Neovim 0.10+
2. Check if enabled: `<leader>th` to toggle
3. Restart LSP: `:LspRestart`

### ESLint not auto-fixing
1. Ensure ESLint config exists (`.eslintrc.*`)
2. Check ESLint is running: `:LspInfo`
3. Try manual fix: `:EslintFixAll`

### Volar/TypeScript conflicts
- `typescript-tools.nvim` handles TS/JS files
- `volar` handles Vue files
- Both should coexist peacefully with this config

### Performance issues
1. Increase tsserver memory limit
2. Disable semantic tokens
3. Reduce inlay hints
4. Use `separate_diagnostic_server = true`

## ?? Additional Resources

- [typescript-tools.nvim docs](https://github.com/pmizio/typescript-tools.nvim)
- [Volar docs](https://github.com/vuejs/language-tools)
- [Neovim LSP guide](https://neovim.io/doc/user/lsp.html)

## ?? Workflow Tips

### Quick Import Workflow
1. Type variable/component name
2. Accept autocomplete
3. Import is added automatically

### Refactoring Workflow
1. Place cursor on symbol
2. Press `<leader>rn` to rename
3. Or `<leader>ca` for code actions

### Error Fixing Workflow
1. Jump to error with `]d`
2. Press `<leader>ca` for quick fixes
3. Or `<leader>tf` to fix all TypeScript issues

### Vue Component Development
1. Auto-imports work in `<script setup>`
2. Template type-checking shows errors in real-time
3. CSS/SCSS get full IntelliSense

Enjoy your enhanced TypeScript, Vue, and JavaScript development experience! ??
