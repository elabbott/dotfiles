# TypeScript Tool Configuration

Reference configuration files for TypeScript projects.

## Tools Configured

- **TypeScript Compiler** — Type checking and compilation
- **ESLint** — TypeScript-specific linting with strict rules
- **Prettier** — Code formatter

## Files

- `tsconfig.json` — TypeScript compiler configuration (strict mode)
- `.eslintrc.json` — ESLint with TypeScript plugin
- `.prettierrc` — Prettier formatting options

## Installation

Copy files to your project root:

```bash
cp editor/typescript/tsconfig.json /path/to/project/
cp editor/typescript/.eslintrc.json /path/to/project/
cp editor/typescript/.prettierrc /path/to/project/
```

## Usage

```bash
# Type check without emitting
tsc --noEmit

# Compile TypeScript
tsc

# Lint files
eslint "src/**/*.ts"

# Fix auto-fixable issues
eslint --fix "src/**/*.ts"

# Format code
prettier --write "src/**/*.ts"
```

## Configuration Highlights

### tsconfig.json

- **Strict Mode**: All strict checks enabled
- **Target**: ES2020 with ESNext modules
- **Declarations**: Generate .d.ts files for libraries
- **Source Maps**: Enabled for debugging
- **No Implicit Returns**: Functions must return values
- **No Unused Locals/Parameters**: Catch dead code

### .eslintrc.json

- Requires explicit return types on functions
- Requires explicit member accessibility (public/private)
- Enforces `null`/`undefined` safety checks
- No `any` type allowed
- Strict boolean expressions
- Consistent type imports (using `import type`)
- Interfaces preferred over type aliases
- Exhaustive switch cases

### .prettierrc

- Print width: 120 characters
- Tab width: 2 spaces
- Semicolons required
- Double quotes
- Arrow parens always

## Customization

### Relaxing Rules for Tests

The config includes test file overrides that relax some rules:
```json
"overrides": [
  {
    "files": ["*.test.ts"],
    "rules": {
      "@typescript-eslint/no-explicit-any": "warn"
    }
  }
]
```

## Resources

- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [typescript-eslint](https://typescript-eslint.io/)
- [Prettier Documentation](https://prettier.io/)
