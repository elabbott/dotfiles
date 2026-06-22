# Tool Configuration Reference

This document outlines all tool-specific configurations and how they work with `.editorconfig`.

## Configuration Layers

```
┌─────────────────────────────────────────────────────────┐
│  Layer 1: EditorConfig (.editorconfig)                  │
│  Basic formatting, line endings, indentation            │
│  Automatically detected by all modern editors           │
└─────────────────────────────────────────────────────────┘
                            ↓
┌──────────────────────────┬──────────────────────────────┐
│    Python Projects       │   JS/TS Projects            │
├──────────────────────────┼──────────────────────────────┤
│                          │                              │
│  Layer 2: Tool Configs   │  Layer 2: Tool Configs       │
│  ├─ pyproject.toml      │  ├─ .eslintrc.json          │
│  │  (Black, isort,      │  │  (Linting rules)          │
│  │   ruff, mypy,        │  ├─ .prettierrc              │
│  │   pytest)            │  │  (Formatting rules)       │
│  │                      │  └─ tsconfig.json            │
│  │                      │     (TS compiler)            │
│                          │                              │
│  Tool Installation       │  Tool Installation           │
│  pip install ...        │  npm install --save-dev ...  │
│                          │                              │
│  Run Tools               │  Run Tools                   │
│  black .                │  eslint .                    │
│  isort .                │  prettier --write .          │
│  ruff check .           │  tsc --noEmit                │
│  mypy .                 │                              │
│  pytest                 │  CI/CD Integration           │
│                          │  eslint --max-warnings 0    │
│                          │  prettier --check .         │
└──────────────────────────┴──────────────────────────────┘
```

## Python Configuration

### File: `editor/python/pyproject.toml`

**Tools Configured:**
- **Black** — Formatter (line length: 88)
- **isort** — Import sorter
- **ruff** — Linter
- **mypy** — Type checker
- **pytest** — Test runner
- **coverage** — Coverage reporting

**Key Settings:**
```toml
[tool.black]
line-length = 88
target-version = ["py310", "py311", "py312"]

[tool.isort]
profile = "black"
line_length = 88

[tool.ruff]
line-length = 88
target-version = "py310"

[tool.mypy]
python_version = "3.10"
strict = true
```

**Installation:**
```bash
pip install black isort ruff mypy pytest coverage
```

**Usage:**
```bash
black .                    # Format
isort .                    # Sort imports
ruff check --fix .         # Lint and fix
mypy .                     # Type check
pytest                     # Test
```

## JavaScript Configuration

### Files: `editor/javascript/.eslintrc.json` + `.prettierrc`

**Tools Configured:**
- **ESLint** — Linter
- **Prettier** — Formatter

**Key Settings:**
```json
{
  "extends": ["eslint:recommended", "prettier"],
  "rules": {
    "prefer-const": "error",
    "no-var": "error",
    "eqeqeq": ["error", "always"]
  }
}
```

```json
{
  "printWidth": 120,
  "tabWidth": 2,
  "semi": true,
  "singleQuote": false,
  "trailingComma": "es5"
}
```

**Installation:**
```bash
npm install --save-dev eslint prettier
```

**Usage:**
```bash
eslint src/                        # Lint
eslint --fix src/                  # Lint and fix
prettier --write "src/**/*.js"     # Format
prettier --check "src/**/*.js"     # Check format
```

## TypeScript Configuration

### Files: `editor/typescript/.eslintrc.json` + `.prettierrc` + `tsconfig.json`

**Tools Configured:**
- **TypeScript Compiler** — Type checker
- **ESLint + @typescript-eslint** — Linter
- **Prettier** — Formatter

**Key Settings:**
```json
{
  "parser": "@typescript-eslint/parser",
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking",
    "prettier"
  ],
  "rules": {
    "@typescript-eslint/explicit-function-return-types": "error",
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/strict-boolean-expressions": "error"
  }
}
```

```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true
  }
}
```

**Installation:**
```bash
npm install --save-dev typescript eslint prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser
```

**Usage:**
```bash
tsc --noEmit                       # Type check
eslint "src/**/*.ts"               # Lint
eslint --fix "src/**/*.ts"         # Lint and fix
prettier --write "src/**/*.ts"     # Format
```

## C# Configuration

**Tools Configured:**
- **Roslyn Analyzers** (via .editorconfig)
- **dotnet format**
- **StyleCop** (optional)

**Key Settings in `.editorconfig`:**
```
csharp_style_primary_constructors = true:suggestion
csharp_style_switch_expression = true:suggestion
csharp_style_file_scoped_namespaces = true:suggestion
csharp_prefer_braces = true:silent
```

**Installation:**
```bash
dotnet tool install -g dotnet-format
dotnet tool install -g dotnet-roslynator
```

**Usage:**
```bash
dotnet format                      # Format
dotnet format --verify-no-changes  # Check format
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Code Quality

on: [push, pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.10", "3.11"]
    steps:
      - uses: actions/checkout@v3
      
      # Python
      - uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}
      - run: pip install black isort ruff mypy
      - run: black --check .
      - run: isort --check-only .
      - run: ruff check .
      - run: mypy .
      
      # TypeScript
      - uses: actions/setup-node@v3
        with:
          node-version: "18"
      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
```

## Setting Up a New Project

1. **Copy tool configs to project root:**
   ```bash
   # For Python
   cp ~/.dotfiles/editor/python/pyproject.toml .
   
   # For JavaScript
   cp ~/.dotfiles/editor/javascript/{.eslintrc.json,.prettierrc} .
   
   # For TypeScript
   cp ~/.dotfiles/editor/typescript/{.eslintrc.json,.prettierrc,tsconfig.json} .
   
   # For all projects
   cp ~/.dotfiles/.editorconfig .
   ```

2. **Install tools:**
   ```bash
   # Python
   pip install -r requirements-dev.txt  # or poetry add --group dev
   
   # JavaScript/TypeScript
   npm install --save-dev  # or update package.json
   ```

3. **Set up editor integration:**
   - VSCode: Install ESLint and Prettier extensions
   - JetBrains: Settings auto-load from configs
   - Vim/Neovim: Install ALE or similar for linting

4. **Run tools locally:**
   ```bash
   # Format code
   black .
   prettier --write .
   
   # Check code
   ruff check .
   eslint .
   mypy .
   ```

5. **Add to pre-commit hooks:**
   ```bash
   pip install pre-commit
   # Create .pre-commit-config.yaml with tool configurations
   pre-commit install
   ```

## References

- [EditorConfig](https://editorconfig.org)
- [Python: pyproject.toml](https://packaging.python.org/specifications/pyproject-toml/)
- [Black](https://black.readthedocs.io/)
- [isort](https://pycqa.github.io/isort/)
- [ruff](https://docs.astral.sh/ruff/)
- [mypy](https://mypy.readthedocs.io/)
- [ESLint](https://eslint.org/)
- [Prettier](https://prettier.io/)
- [TypeScript](https://www.typescriptlang.org/)
- [dotnet format](https://github.com/dotnet/format)
