# Editor Configuration

Configuration files for various editors and coding style standards.

## How It Works

The editor configuration system has three layers:

1. **EditorConfig (.editorconfig)** — Basic formatting (indentation, line endings, whitespace)
2. **Tool-Specific Configs** — Advanced rules and style enforcement (linting, type checking, formatting)
3. **Editor-Specific Settings** — UI and editor behavior (themes, fonts, keybindings)

### Layer 1: EditorConfig

The `.editorconfig` file at the repository root handles fundamental formatting across all editors and languages:
- **Indentation**: 2 spaces (JS/TS), 4 spaces (Python/.NET)
- **Line endings**: LF (Unix) for most, CRLF for Windows/.NET files
- **Whitespace**: Trim trailing, insert final newline
- **Line length**: 120 (JS/TS/.NET), 88 (Python), 100 (Rust)

**Automatic**: Most modern editors (VSCode, JetBrains IDEs, Vim) support EditorConfig out of the box. No setup needed—just clone the repo.

### Layer 2: Tool-Specific Configurations

Each language has dedicated tool configuration files that enforce detailed style rules, type checking, and linting:

#### [Python](python/) — `pyproject.toml`
- **Black** — Code formatter (line length: 88)
- **isort** — Import sorter (Black-compatible)
- **ruff** — Fast linter (flake8, pyupgrade, etc.)
- **mypy** — Type checker (strict mode)
- **pytest** — Test runner
- **coverage** — Code coverage

See [editor/python/README.md](python/README.md) for setup and usage.

#### [JavaScript](javascript/) — `.eslintrc.json` + `.prettierrc`
- **ESLint** — Comprehensive linting rules
- **Prettier** — Code formatter

See [editor/javascript/README.md](javascript/README.md) for setup and usage.

#### [TypeScript](typescript/) — `.eslintrc.json` + `.prettierrc` + `tsconfig.json`
- **TypeScript Compiler** — Type checking (strict mode)
- **ESLint + @typescript-eslint** — TypeScript linting
- **Prettier** — Code formatter

See [editor/typescript/README.md](typescript/README.md) for setup and usage.

#### C# — `.editorconfig` (embedded)
- **Roslyn Analyzers** — Integrated into .editorconfig
- **dotnet format** — Code formatter
- **StyleCop** — Optional static analysis

See [CSHARP_STYLE.md](CSHARP_STYLE.md) for conventions and setup.

### Layer 3: Editor-Specific Configuration

Configurations for individual editors with UI preferences and keybindings.

#### [Vim](vim/)
- Traditional Vi IMproved configuration
- Smart indentation, syntax highlighting, split management
- See [vim/README.md](vim/README.md)

#### [Neovim](nvim/)
- Modern Vim fork with Lua support
- Both VimScript (init.vim) and Lua (init.lua) configs
- See [nvim/README.md](nvim/README.md)

#### [Visual Studio Code](vscode/)
- Editor settings (formatting, indentation, colors)
- Custom keybindings
- Extension recommendations
- See [vscode/README.md](vscode/README.md)

## Language Style Guides

Comprehensive coding conventions for each language with examples, best practices, and tooling recommendations.

### [PYTHON_STYLE.md](PYTHON_STYLE.md)
Python coding standards following PEP 8 and Black formatter:
- Type hints and docstrings
- Naming conventions
- Import organization
- Context managers and comprehensions
- Tools: Black, isort, ruff, mypy

### [JAVASCRIPT_STYLE.md](JAVASCRIPT_STYLE.md)
JavaScript conventions following ESLint and Prettier:
- Modern ES6+ features (arrow functions, destructuring, async/await)
- Naming conventions
- Class and function definitions
- Error handling
- Tools: ESLint, Prettier

### [TYPESCRIPT_STYLE.md](TYPESCRIPT_STYLE.md)
TypeScript best practices with strict type safety:
- Type annotations and interfaces
- Generics and utility types
- Strict mode configuration
- Decorators and enums
- Tools: TypeScript compiler, ESLint, Prettier

### [CSHARP_STYLE.md](CSHARP_STYLE.md)
C# modern conventions including latest language features:
- Primary constructors (C# 12)
- Switch expressions (C# 8+)
- Pattern matching
- Naming conventions
- Tools: .editorconfig, StyleCop, dotnet format

## Quick Start

### For Projects Using Python, JavaScript, or TypeScript

Copy the tool configuration files to your project root:

```bash
# Python
cp editor/python/pyproject.toml .

# JavaScript
cp editor/javascript/{.eslintrc.json,.prettierrc} .

# TypeScript
cp editor/typescript/{.eslintrc.json,.prettierrc,tsconfig.json} .
```

Then install and run the tools:

```bash
# Python
pip install black isort ruff mypy

# JavaScript/TypeScript
npm install --save-dev eslint prettier @typescript-eslint/eslint-plugin
```

### For All Projects

Copy `.editorconfig` to your project root for basic formatting consistency across editors.

## File Structure

```
editor/
├── .editorconfig              # Universal formatting rules
├── PYTHON_STYLE.md            # Python conventions guide
├── JAVASCRIPT_STYLE.md        # JavaScript conventions guide
├── TYPESCRIPT_STYLE.md        # TypeScript conventions guide
├── CSHARP_STYLE.md            # C# conventions guide
├── python/
│   ├── pyproject.toml         # Python tools config
│   └── README.md
├── javascript/
│   ├── .eslintrc.json         # ESLint config
│   ├── .prettierrc            # Prettier config
│   └── README.md
├── typescript/
│   ├── .eslintrc.json         # TypeScript ESLint config
│   ├── .prettierrc            # Prettier config
│   ├── tsconfig.json          # TypeScript compiler config
│   └── README.md
├── vim/
│   ├── .vimrc
│   └── README.md
├── nvim/
│   ├── init.vim
│   ├── init.lua
│   └── README.md
└── vscode/
    ├── settings.json
    ├── keybindings.json
    └── README.md
```

## Tool Installation

### Python Tools

```bash
# All-in-one installation
pip install black isort ruff mypy pytest coverage

# Or with poetry
poetry add --group dev black isort ruff mypy pytest coverage
```

### JavaScript/TypeScript Tools

```bash
# npm
npm install --save-dev eslint prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser

# yarn
yarn add --dev eslint prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser

# pnpm
pnpm add -D eslint prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser
```

### C# Tools

```bash
# .NET CLI
dotnet tool install -g dotnet-format
dotnet tool install -g dotnet-roslynator
```

## Integration with CI/CD

Check formatting and linting in your CI pipeline:

```bash
# Python
black --check .
isort --check-only .
ruff check .
mypy .

# JavaScript/TypeScript
eslint .
prettier --check .

# C#
dotnet format --verify-no-changes
```

## Customization

Each tool config file includes comments explaining key settings. Edit them to customize behavior for your project:
- Change line length limits
- Enable/disable specific rules
- Add project-specific overrides
- Configure type-checking strictness

See individual README files in each language directory for details.

## Quick Start

```bash
# Vim
ln -s ~/.dotfiles/editor/vim/.vimrc ~/.vimrc

# Neovim (choose one)
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/editor/nvim/init.lua ~/.config/nvim/init.lua

# VSCode - see vscode/README.md for platform-specific instructions
```

## Features

All configurations share common settings:
- 2-space indentation (except Python which uses 4)
- Syntax highlighting
- Line number display
- Search highlighting
- File-type detection
- Local overrides support

## Adding More Editors

To add configurations for other editors (Emacs, Sublime, etc.):
1. Create a new subdirectory under `editor/`
2. Add configuration files
3. Create a README.md with setup instructions
4. Update this README with the new editor
