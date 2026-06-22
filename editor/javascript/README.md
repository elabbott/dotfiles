# JavaScript Tool Configuration

Reference configuration files for JavaScript projects.

## Tools Configured

- **ESLint** — JavaScript linter with comprehensive rules
- **Prettier** — Code formatter

## Files

- `.eslintrc.json` — ESLint configuration
- `.prettierrc` — Prettier formatting options

## Installation

Copy files to your project root:

```bash
cp editor/javascript/.eslintrc.json /path/to/project/
cp editor/javascript/.prettierrc /path/to/project/
```

## Usage

```bash
# Lint files
eslint src/

# Fix auto-fixable issues
eslint --fix src/

# Format code with Prettier
prettier --write "src/**/*.js"

# Check formatting without making changes
prettier --check "src/**/*.js"
```

## Customization

### ESLint (.eslintrc.json)

Key settings:
- `env.browser` — Browser globals (DOM, etc.)
- `env.node` — Node.js globals
- `env.es2021` — ES2021 language features
- `rules` — Comprehensive linting rules (all error level by default)

Add plugin configurations:
```json
{
  "extends": [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "prettier"
  ],
  "plugins": ["react", "react-hooks"]
}
```

### Prettier (.prettierrc)

Key settings:
- `printWidth` — 120 characters
- `semi` — Require semicolons
- `singleQuote` — Use double quotes
- `trailingComma` — Add trailing commas (ES5 compatible)
- `tabWidth` — 2 spaces

## Resources

- [ESLint Documentation](https://eslint.org/docs/)
- [Prettier Documentation](https://prettier.io/docs/)
- [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
