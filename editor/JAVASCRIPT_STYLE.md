# JavaScript Style Guide

This guide documents the JavaScript coding conventions and style preferences configured in `.editorconfig`.

## Code Style

We follow **ESLint and Prettier** conventions for consistent, readable code.

### Line Length

Maximum line length is **120 characters**:

```javascript
// ✅ Preferred
const fetchUserData = async (userId, options = {}) => {
  const response = await api.get(`/users/${userId}`, options);
  return response.data;
};

// ❌ Avoid - Line too long
const fetchUserData = async (userId, options = {}) => { return await api.get(`/users/${userId}`, options); };
```

### Indentation

Use **2 spaces** for consistent indentation:

```javascript
// ✅ Preferred
function processData(data) {
  return data.map((item) => {
    return {
      ...item,
      processed: true,
    };
  });
}

// ❌ Avoid - Wrong indentation
function processData(data) {
    return data.map((item) => {
        return {
            ...item,
            processed: true,
        };
    });
}
```

### Variable Declarations

Use `const` by default, `let` when needed, avoid `var`:

```javascript
// ✅ Preferred
const PI = 3.14159;
const user = { name: "Alice", age: 30 };
let counter = 0;

// ❌ Avoid
var PI = 3.14159;
var user = { name: "Alice", age: 30 };
var counter = 0;
```

### Naming Conventions

- **Variables/Functions**: `camelCase`
- **Classes/Constructors**: `PascalCase`
- **Constants**: `UPPER_SNAKE_CASE`
- **Private members**: `_leadingUnderscore`

```javascript
// ✅ Preferred
const maxRetries = 3;
function getUserName(userId) {}

class UserManager {
  constructor() {
    this._cache = new Map();
  }
}

const API_ENDPOINT = "https://api.example.com";

// ❌ Avoid
const MAX_RETRIES = 3; // Not a constant
function get_user_name(userId) {} // snake_case
class userManager {} // lowercase class
```

### Arrow Functions

Use arrow functions for cleaner, more concise code:

```javascript
// ✅ Preferred
const numbers = [1, 2, 3];
const doubled = numbers.map((n) => n * 2);

const user = { name: "Alice" };
const getName = () => user.name;

// ❌ Avoid
const doubled = numbers.map(function (n) {
  return n * 2;
});
```

### Template Literals

Use template literals for string interpolation:

```javascript
// ✅ Preferred
const name = "Alice";
const message = `Hello, ${name}!`;
const multiline = `Line 1
Line 2
Line 3`;

// ❌ Avoid
const message = "Hello, " + name + "!";
const message = "Hello, ".concat(name, "!");
```

### Object and Array Destructuring

```javascript
// ✅ Preferred
const { name, age } = user;
const [first, second] = array;

function displayUser({ name, age }) {
  console.log(`${name} is ${age} years old`);
}

const { data: { users } } = response; // Nested destructuring

// ❌ Avoid
const name = user.name;
const age = user.age;

function displayUser(user) {
  console.log(`${user.name} is ${user.age} years old`);
}
```

### Default Parameters

```javascript
// ✅ Preferred
function greet(name = "Guest", greeting = "Hello") {
  return `${greeting}, ${name}!`;
}

const fetch = async (url, options = {}) => {
  return await http.get(url, { timeout: 5000, ...options });
};

// ❌ Avoid
function greet(name, greeting) {
  name = name || "Guest";
  greeting = greeting || "Hello";
  return `${greeting}, ${name}!`;
}
```

### Rest/Spread Operators

```javascript
// ✅ Preferred
function sum(...numbers) {
  return numbers.reduce((a, b) => a + b, 0);
}

const newArray = [...array1, ...array2];
const newObject = { ...obj1, ...obj2, key: "value" };

// ❌ Avoid
function sum() {
  let total = 0;
  for (let i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}
```

### Classes

Use modern class syntax with proper organization:

```javascript
// ✅ Preferred
class UserService {
  constructor(apiClient) {
    this.apiClient = apiClient;
  }

  async getUser(userId) {
    return this.apiClient.get(`/users/${userId}`);
  }

  async updateUser(userId, data) {
    return this.apiClient.put(`/users/${userId}`, data);
  }

  #validateEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }
}

// ❌ Avoid
function UserService(apiClient) {
  this.apiClient = apiClient;
}

UserService.prototype.getUser = function (userId) {
  return this.apiClient.get(`/users/${userId}`);
};
```

### Async/Await

Use async/await instead of `.then()` chains:

```javascript
// ✅ Preferred
const fetchData = async () => {
  try {
    const response = await fetch("/api/data");
    const data = await response.json();
    return data;
  } catch (error) {
    console.error("Failed to fetch data:", error);
    throw error;
  }
};

// ❌ Avoid
const fetchData = () => {
  return fetch("/api/data")
    .then((response) => response.json())
    .then((data) => data)
    .catch((error) => console.error(error));
};
```

### Error Handling

```javascript
// ✅ Preferred
try {
  const result = await riskyOperation();
} catch (error) {
  if (error instanceof NetworkError) {
    logger.warn("Network failed:", error);
  } else if (error instanceof ValidationError) {
    logger.error("Invalid data:", error);
  } else {
    logger.error("Unexpected error:", error);
  }
}

// ❌ Avoid
try {
  riskyOperation();
} catch (error) {
  console.log(error);
}
```

### Comments

```javascript
// ✅ Preferred
// Single line comment
const data = processArray(items); // Inline comment

/**
 * Calculate total price including tax.
 * @param {number} subtotal - Base price
 * @param {number} taxRate - Tax percentage (0-1)
 * @returns {number} Total with tax
 */
function calculateTotal(subtotal, taxRate) {
  return subtotal * (1 + taxRate);
}

// ❌ Avoid
// This function calculates the total
const total = subtotal + subtotal * tax;

// Don't use console comments
// const debug = true;
```

## Formatting

- **Indentation**: 2 spaces
- **Line Length**: Maximum 120 characters
- **Line Endings**: LF (Unix style)
- **Encoding**: UTF-8
- **Semicolons**: Use them (enforced by Prettier)
- **Trailing Commas**: Use them in multi-line structures

## Tools

### Prettier (Code Formatter)

```bash
# Format files
prettier --write "src/**/*.js"

# Check without making changes
prettier --check "src/**/*.js"
```

### ESLint (Linter)

```bash
# Lint files
eslint src/

# Fix auto-fixable issues
eslint --fix src/
```

### Configuration Files

#### .eslintrc.json

```json
{
  "env": {
    "browser": true,
    "es2021": true,
    "node": true
  },
  "extends": ["eslint:recommended", "prettier"],
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "rules": {
    "no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
    "prefer-const": "error",
    "no-var": "error",
    "eqeqeq": ["error", "always"]
  }
}
```

#### .prettierrc

```json
{
  "semi": true,
  "singleQuote": false,
  "trailingComma": "es5",
  "printWidth": 120,
  "tabWidth": 2,
  "useTabs": false,
  "arrowParens": "always"
}
```

## Resources

- [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- [Google JavaScript Style Guide](https://google.github.io/styleguide/jsguide.html)
- [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/)
- [Prettier Documentation](https://prettier.io/docs/)
- [ESLint Documentation](https://eslint.org/)
