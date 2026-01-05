# 🚀 Neovim TypeScript/JavaScript Development Features

Complete guide to all features and keybindings in your optimized Neovim setup.

---

## 📋 Table of Contents

1. [Core Features](#core-features)
2. [TypeScript/JavaScript Specific](#typescriptjavascript-specific)
3. [LSP & Code Intelligence](#lsp--code-intelligence)
4. [Code Navigation](#code-navigation)
5. [Editing & Refactoring](#editing--refactoring)
6. [Git Integration](#git-integration)
7. [Terminal & Tools](#terminal--tools)
8. [Search & Find](#search--find)
9. [Debugging & Diagnostics](#debugging--diagnostics)
10. [Sessions & Persistence](#sessions--persistence)

---

## ⚙️ Core Features

### Leader Key

- **Leader**: `Space`

### File Operations

- `<leader>w` - Save file
- `<leader>wa` - Save all files
- `<leader>q` - Quit
- `<leader>x` - Save and quit
- `<leader>e` - Toggle file explorer

### Window Management

- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally
- `<leader>se` - Equal width splits
- `<leader>sx` - Close split
- `<C-h/j/k/l>` - Navigate between splits (and tmux panes)
- `<C-Up/Down/Left/Right>` - Resize windows

### Tab Management

- `<leader>to` - Open new tab
- `<leader>tx` - Close tab
- `<leader>tn` - Next tab
- `<leader>tp` - Previous tab

### Buffer Management

- `<leader>bd` - Delete buffer (smart)
- `<leader>bD` - Delete buffer (force)
- `<leader>bo` - Close all buffers except current

### Quick Escape

- `jk` or `jj` - Exit insert mode (faster than ESC)

---

## 💻 TypeScript/JavaScript Specific

### TypeScript Tools Commands

- `<leader>co` - Organize imports
- `<leader>cR` - Rename file (updates imports)
- `<leader>ci` - Add missing imports
- `<leader>cu` - Remove unused imports
- `<leader>cf` - Fix all issues
- `gD` - Go to source definition

### Inlay Hints

Automatically shows:

- Parameter names
- Variable types
- Function return types
- Enum values

### Package.json Management

When in `package.json`:

- `<leader>ns` - Show package versions
- `<leader>nc` - Hide package info
- `<leader>nt` - Toggle package info
- `<leader>nu` - Update package to latest
- `<leader>nd` - Delete package
- `<leader>ni` - Install new package
- `<leader>np` - Change package version

### Code Snippets

#### JavaScript/TypeScript

- `clog` → `console.log('variable:', variable)`
- `cl` → `console.log()`
- `interface` → TypeScript interface template
- `type` → TypeScript type alias
- `af` → Arrow function
- `aaf` → Async arrow function
- `expf` → Export named function
- `expaf` → Export async function
- `imp` → Import statement
- `impd` → Import default
- `try` → Try-catch block
- `atry` → Async try-catch
- `class` → Class template
- `enum` → TypeScript enum
- `desc` → Describe test block
- `it` → It test block
- `ait` → Async it test
- `us` → useState hook
- `ue` → useEffect hook
- `ucb` → useCallback hook
- `um` → useMemo hook
- `prom` → Promise template
- `tern` → Ternary operator

#### Vue

- `com` → Complete Vue component template

---

## 🧠 LSP & Code Intelligence

### Navigation

- `gd` - Go to definition (Telescope)
- `gD` - Go to source definition (TS)
- `gr` - Go to references (Telescope)
- `gi` - Go to implementation (Telescope)
- `gt` - Go to type definition (Telescope)

### Code Actions

- `<leader>ca` - Code actions menu
- `<leader>rn` - Rename symbol (LSP)
- `K` - Hover documentation (or peek fold)
- `<C-k>` - Signature help

### Diagnostics

- `<leader>d` - Show diagnostic float
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>dl` - Diagnostics to location list
- `<leader>dq` - Diagnostics to quickfix list

### Formatting

- `<leader>fm` - Format file or range
- `<leader>f` - Format document (LSP)

### Code Context

- Breadcrumbs shown in statusline (via nvim-navic)
- Shows current function/class/method context

---

## 🧭 Code Navigation

### Symbol Outline

- `<leader>cs` - Toggle symbols outline sidebar
- Shows code structure (functions, classes, variables, etc.)

### Navigation Shortcuts

- `H` - Go to beginning of line
- `L` - Go to end of line
- `<C-d>` - Half page down (centered)
- `<C-u>` - Half page up (centered)
- `n` - Next search result (centered)
- `N` - Previous search result (centered)

### Reference Highlighting

- `]]` - Next reference (illuminate)
- `[[` - Previous reference (illuminate)

### Folding (UFO)

- `zR` - Open all folds
- `zM` - Close all folds
- `zr` - Open folds except kinds
- `zm` - Close folds with
- `K` - Peek folded lines (or hover if not folded)

### Quickfix & Location Lists

- `[q` / `]q` - Previous/next quickfix item
- `[l` / `]l` - Previous/next location item

---

## ✏️ Editing & Refactoring

### Refactoring (Visual Mode)

- `<leader>re` - Extract function
- `<leader>rf` - Extract function to file
- `<leader>rv` - Extract variable
- `<leader>ri` - Inline variable
- `<leader>rr` - Open refactoring menu (Telescope)

### Refactoring (Normal Mode)

- `<leader>rb` - Extract block
- `<leader>rbf` - Extract block to file
- `<leader>ri` - Inline variable

### Text Manipulation

- `J` (visual) - Move line down
- `K` (visual) - Move line up
- `<` (visual) - Indent left (repeatable)
- `>` (visual) - Indent right (repeatable)

### Surround Operations (mini.surround)

- `gsa` - Add surrounding
- `gsd` - Delete surrounding
- `gsr` - Replace surrounding
- `gsf` - Find surrounding (right)
- `gsF` - Find surrounding (left)
- `gsh` - Highlight surrounding

Examples:

- `gsa"` - Add double quotes around selection
- `gsd"` - Delete surrounding double quotes
- `gsr"'` - Replace double quotes with single quotes

### Auto-pairs

- Automatically pairs brackets, quotes, etc.

### Commenting

- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc` (visual) - Comment selection

---

## 🔀 Git Integration

### Git Signs

- Inline git blame (shows author, date, message)
- Visual indicators for added/changed/deleted lines

### Git Conflict Resolution

- `<leader>co` - Choose ours
- `<leader>ct` - Choose theirs
- `<leader>cb` - Choose both
- `<leader>c0` - Choose none
- `<leader>cn` - Next conflict
- `<leader>cp` - Previous conflict
- `<leader>cl` - List all conflicts

### LazyGit

- `<leader>gg` - Open LazyGit in floating terminal

---

## 🖥️ Terminal & Tools

### Terminal

- `<C-\>` - Toggle floating terminal
- `<leader>tf` - Open floating terminal
- `<Esc>` (in terminal) - Exit insert mode
- `<C-h/j/k/l>` (in terminal) - Navigate to other windows

### Custom Terminals

- `<leader>gg` - LazyGit
- `<leader>dd` - LazyDocker
- `<leader>gmi` - Gemini CLI

## 🌐 HTTP Client (Kulala)

### Overview

Kulala.nvim is a powerful HTTP client that lets you test APIs directly from Neovim. Create `.http` or `.rest` files to write and execute HTTP requests.

### Keybindings (in `.http` or `.rest` files)

- `<leader>s` - Send request under cursor (or press `<CR>` on request line)
- `<leader>a` - Send all requests in file
- `<leader>b` - Open scratchpad for quick requests
- `<leader>r` - Replay the last request
- `<leader>i` - Inspect current request
- `<leader>c` - Copy request as cURL command
- `<leader>C` - Paste from cURL
- `<leader>e` - Select environment
- `<leader>j` - Open cookies jar
- `<leader>n` - Jump to next request
- `<leader>p` - Jump to previous request
- `<leader>f` - Find/search requests

### Usage Guide

1. **Create an HTTP file**: Create a file with `.http` or `.rest` extension
   ```bash
   nvim api-tests.http
   ```

2. **Write requests**: Use standard HTTP syntax
   ```http
   GET https://api.example.com/users/1
   
   POST https://api.example.com/users
   Content-Type: application/json
   
   {
     "name": "John Doe",
     "email": "john@example.com"
   }
   ```

3. **Use variables**: Define variables at the top of your file
   ```http
   @baseUrl = https://api.example.com
   @token = your-token-here
   
   GET {{baseUrl}}/users/1
   Authorization: Bearer {{token}}
   ```

4. **Send requests**: 
   - Place cursor on any request line
   - Press `<leader>s` to send that request
   - Press `<leader>a` to send all requests sequentially

5. **View responses**: Responses appear in a floating window with syntax highlighting

### Request Syntax

- **Separate requests** with `###` (three hashes)
- **Comments** start with `###`
- **Variables** use `@variableName = value` syntax
- **Use variables** with `{{variableName}}` syntax

### Example File

See `example.http` in your Neovim config directory for comprehensive examples including:
- GET, POST, PUT, PATCH, DELETE requests
- Headers and authentication
- Query parameters
- JSON bodies
- Form data
- File uploads

### Tips

- Keep your API tests organized in `.http` files
- Use variables for base URLs and tokens
- Responses are automatically formatted (JSON)
- You can have multiple requests in one file
- Use comments (`###`) to organize your requests

## 🔍 Search & Find

### Telescope

- `<leader>ff` - Find files (includes hidden)
- `<leader>fg` - Live grep (search text)
- `<leader>fw` - Find word under cursor
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags

In Telescope:

- `<C-j>` - Move down
- `<C-k>` - Move up
- `<C-q>` - Send to quickfix list

### Search

- `<leader>nh` - Clear search highlights
- Word under cursor automatically highlighted (illuminate)

---

## 🐛 Debugging & Diagnostics

### Debug Print

- `<leader>dp` - Debug print below
- `<leader>dP` - Debug print above
- `<leader>dv` - Debug variable below
- `<leader>dV` - Debug variable above
- `<leader>dt` - Toggle debug comments
- `<leader>dd` - Delete all debug prints

### Trouble (Diagnostics Viewer)

- `<leader>xx` - Toggle diagnostics
- `<leader>xX` - Buffer diagnostics only
- `<leader>xL` - Location list
- `<leader>xQ` - Quickfix list

---

## 💾 Sessions & Persistence

### Session Management

- `<leader>qs` - Restore session for current directory
- `<leader>ql` - Restore last session
- `<leader>qd` - Don't save current session

Sessions are automatically saved on exit and can be restored per project.

---

## 🎨 UI Toggles

- `<leader>uw` - Toggle word wrap
- `<leader>ul` - Toggle line numbers
- `<leader>ur` - Toggle relative line numbers

---

## 🔧 Additional Features

### Better Quickfix (BQF)

- Enhanced quickfix window with preview
- FZF filtering in quickfix
- `z,` - Toggle preview mode

### Dressing

- Better UI for input dialogs (uses Telescope)
- Enhanced select menus

### Mini AI

- Enhanced text objects
- Better a/i motions for functions, classes, etc.

---

## 📦 Installed LSP Servers

- **ts_ls** - TypeScript/JavaScript (with Vue plugin)
- **volar** - Vue 3
- **eslint** - JavaScript/TypeScript linting
- **html** - HTML
- **cssls** - CSS
- **tailwindcss** - Tailwind CSS (with cva/cx support)
- **jsonls** - JSON (with schemastore)

---

## 🎯 Tips & Tricks

1. **Fast Navigation**: Use `<C-h/j/k/l>` to move between Neovim splits and tmux panes seamlessly
2. **Quick Edit**: Use `jk` or `jj` to exit insert mode faster
3. **Code Context**: Watch the statusline for breadcrumbs showing where you are in code
4. **Folding**: Use `zR` to open all folds when first opening a file
5. **Package Management**: Open `package.json` to see version indicators automatically
6. **Refactoring**: Select code in visual mode and use `<leader>rr` for refactoring menu
7. **REST Testing**: Create `.http` files for API testing without leaving Neovim
8. **Sessions**: Use `<leader>qs` to restore your workspace exactly as you left it

---

## 🚀 Performance Tips

- Inlay hints are enabled but can be toggled if causing slowness
- Large files (>100k) automatically skip quickfix preview
- Lazy loading for most plugins ensures fast startup
- UFO folding uses treesitter for accurate folds

---

## 📝 Configuration Location

All configs are in `~/.config/nvim/`:

- `init.lua` - Entry point
- `lua/core/` - Core settings and keymaps
- `lua/plugins/` - Plugin configurations
- `snippets/` - Custom snippets

---

**Happy Coding! 🎉**
