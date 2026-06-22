# Python Tool Configuration

Reference `pyproject.toml` file with standard Python tool configurations.

## Tools Configured

- **Black** — Code formatter (line length: 88)
- **isort** — Import sorter (Black-compatible profile)
- **ruff** — Fast linter (includes flake8, pyupgrade, etc.)
- **mypy** — Static type checker (strict mode)
- **pytest** — Test runner
- **coverage** — Code coverage reporting
- **pylint** — Additional linting (optional)

## Installation

Copy `pyproject.toml` to your project root:

```bash
cp editor/python/pyproject.toml /path/to/project/
```

Or add sections individually to an existing `pyproject.toml`.

## Usage

```bash
# Format code with Black
black .

# Sort imports with isort
isort .

# Lint with ruff
ruff check .
ruff check --fix .

# Type check with mypy
mypy .

# Run tests with pytest
pytest

# Check coverage
coverage run -m pytest
coverage report
```

## Customization

Edit `pyproject.toml` to:
- Change `line-length` (currently 88)
- Add/remove ruff rules in `select` and `ignore`
- Adjust `target-version` for different Python versions
- Add plugin configurations for mypy
- Customize pytest patterns and test paths
