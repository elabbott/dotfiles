# Python Style Guide

This guide documents the Python coding conventions and style preferences configured in `.editorconfig`.

## Code Style

We follow **PEP 8** with Black formatter conventions.

### Line Length

Maximum line length is **88 characters** (Black's default):

```python
# ✅ Preferred
def calculate_sum(
    numbers: list[int],
    multiplier: int = 1,
) -> int:
    """Calculate sum of numbers with optional multiplier."""
    return sum(n * multiplier for n in numbers)

# ❌ Avoid
def calculate_sum(numbers: list[int], multiplier: int = 1) -> int:
    return sum(n * multiplier for n in numbers)  # Line too long
```

### Imports

Group imports in this order: standard library, third-party, local imports.

```python
# ✅ Preferred
import os
import sys
from typing import Optional

import requests
from flask import Flask

from app.models import User
from app.utils import format_date

# ❌ Avoid
from app.utils import format_date
import os
from app.models import User
import requests
```

### Type Hints

Use type hints for function signatures and complex variables:

```python
# ✅ Preferred
def fetch_user(user_id: int) -> Optional[dict]:
    """Fetch user by ID."""
    pass

def process_items(items: list[str], count: int = 0) -> None:
    """Process a list of items."""
    pass

# ❌ Avoid
def fetch_user(user_id):
    pass

def process_items(items, count=0):
    pass
```

### Naming Conventions

- **Modules/Packages**: `lowercase_with_underscores`
- **Classes**: `PascalCase`
- **Functions/Methods**: `lowercase_with_underscores`
- **Constants**: `UPPERCASE_WITH_UNDERSCORES`
- **Private members**: `_leading_underscore`

```python
# ✅ Preferred
class UserManager:
    """Manager for user operations."""
    
    DEFAULT_TIMEOUT = 30
    
    def __init__(self):
        self._cache = {}
    
    def get_active_users(self) -> list[User]:
        """Get all active users."""
        pass
    
    def _validate_email(self, email: str) -> bool:
        """Private method to validate email."""
        pass

# ❌ Avoid
class userManager:
    def get_active_users(self): pass
    def validate_email(self): pass  # Should be private
```

### Docstrings

Use Google-style docstrings:

```python
# ✅ Preferred
def calculate_statistics(data: list[float]) -> dict:
    """Calculate statistics for a dataset.
    
    Args:
        data: List of numeric values.
    
    Returns:
        Dictionary containing mean, median, and std deviation.
    
    Raises:
        ValueError: If data is empty.
    """
    if not data:
        raise ValueError("Data cannot be empty")
    return {
        "mean": sum(data) / len(data),
        "count": len(data),
    }

# ❌ Avoid
def calculate_statistics(data):
    # This function calculates stats
    return {"mean": sum(data) / len(data)}
```

### String Formatting

Use f-strings (Python 3.6+):

```python
# ✅ Preferred
name = "Alice"
age = 30
message = f"My name is {name} and I'm {age} years old"

# ✅ Good for complex expressions
result = f"The answer is {calculate() * 2:.2f}"

# ❌ Avoid
message = "My name is {} and I'm {} years old".format(name, age)
message = "My name is %s and I'm %d years old" % (name, age)
```

### Context Managers

Always use context managers for resource management:

```python
# ✅ Preferred
with open("file.txt") as f:
    content = f.read()

with db.connection() as conn:
    conn.execute(query)

# ❌ Avoid
f = open("file.txt")
content = f.read()
f.close()
```

### List/Dict Comprehensions

Use comprehensions for clean, readable code:

```python
# ✅ Preferred
squares = [x**2 for x in range(10)]
active_users = {u.id: u for u in users if u.is_active}
user_names = [u.name for u in users]

# ❌ Avoid
squares = []
for x in range(10):
    squares.append(x**2)

active_users = {}
for u in users:
    if u.is_active:
        active_users[u.id] = u
```

### Decorators

```python
# ✅ Preferred
@staticmethod
def helper_function():
    pass

@property
def name(self) -> str:
    return self._name

@name.setter
def name(self, value: str) -> None:
    self._name = value

# ❌ Avoid
def name(self):
    return self._name
name = property(name)
```

### Exception Handling

Catch specific exceptions:

```python
# ✅ Preferred
try:
    value = int(user_input)
except ValueError:
    logger.error("Invalid integer input")
except KeyError:
    logger.error("Missing required key")

# ❌ Avoid
try:
    value = int(user_input)
except:
    pass

try:
    value = int(user_input)
except Exception:
    pass
```

### Async/Await

```python
# ✅ Preferred
async def fetch_user(user_id: int) -> User:
    """Fetch user asynchronously."""
    response = await api.get_user(user_id)
    return User.from_dict(response)

async def main():
    user = await fetch_user(123)
    return user

# ❌ Avoid
def fetch_user(user_id):
    response = api.get_user(user_id)
    return response
```

## Formatting

- **Indentation**: 4 spaces
- **Line Length**: Maximum 88 characters (Black)
- **Line Endings**: LF (Unix style)
- **Encoding**: UTF-8
- **Blank Lines**: 2 between top-level definitions, 1 between methods

## Tools

### Black (Code Formatter)

```bash
# Format entire project
black .

# Format specific file
black file.py

# Check without making changes
black --check file.py
```

### isort (Import Sorting)

```bash
# Sort imports in project
isort .

# Check without making changes
isort --check-only .
```

### ruff (Linter)

```bash
# Lint project
ruff check .

# Fix auto-fixable issues
ruff check --fix .
```

### mypy (Type Checking)

```bash
# Type check project
mypy .

# Type check specific file
mypy file.py
```

## Project Structure

```
project/
├── src/
│   └── my_package/
│       ├── __init__.py
│       ├── main.py
│       └── utils.py
├── tests/
│   ├── __init__.py
│   └── test_main.py
├── pyproject.toml
├── README.md
└── .editorconfig
```

## Configuration Files

### pyproject.toml

```toml
[tool.black]
line-length = 88
target-version = ['py310']

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

## Resources

- [PEP 8 — Style Guide](https://pep8.org/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
- [Black Formatter](https://black.readthedocs.io/)
- [isort Documentation](https://pycqa.github.io/isort/)
- [ruff Documentation](https://docs.astral.sh/ruff/)
- [mypy Documentation](https://mypy.readthedocs.io/)
