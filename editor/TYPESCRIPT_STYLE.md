# TypeScript Style Guide

This guide documents the TypeScript coding conventions and style preferences configured in `.editorconfig`.

This builds on the JavaScript style guide with TypeScript-specific enhancements.

## Code Style

We follow **ESLint, Prettier, and TypeScript** strict mode conventions.

### Line Length

Maximum line length is **120 characters**:

```typescript
// ✅ Preferred
const fetchUserData = async (
  userId: number,
  options: FetchOptions = {},
): Promise<User> => {
  const response = await api.get<User>(`/users/${userId}`, options);
  return response.data;
};

// ❌ Avoid - Line too long
const fetchUserData = async (userId: number, options: FetchOptions = {}) => await api.get<User>(`/users/${userId}`, options);
```

### Type Annotations

Always use explicit type annotations:

```typescript
// ✅ Preferred
const count: number = 0;
const users: User[] = [];
const data: Record<string, User> = {};

function processData(items: Item[]): ProcessedItem[] {
  return items.map((item) => process(item));
}

// ❌ Avoid
const count = 0; // Type not explicit
const users = []; // Type not explicit
function processData(items) {
  // No parameter type
  return items.map((item) => process(item));
}
```

### Interfaces vs Types

Use `interface` for object shapes, `type` for unions and primitives:

```typescript
// ✅ Preferred - Interface for objects
interface User {
  id: number;
  name: string;
  email: string;
  isActive: boolean;
}

// Type for unions
type Status = "active" | "inactive" | "pending";

// Type for primitives
type UserID = string & { readonly __brand: "UserID" };

// ❌ Avoid
type User = {
  id: number;
  name: string;
};

interface Status {
  value: "active" | "inactive";
}
```

### Naming Conventions

- **Variables/Functions**: `camelCase`
- **Classes/Interfaces/Types**: `PascalCase`
- **Constants**: `UPPER_SNAKE_CASE`
- **Private members**: `_leadingUnderscore` or `#privateField`
- **Type variables**: `T`, `U`, `TResult`, `TData` (descriptive)

```typescript
// ✅ Preferred
const apiTimeout = 5000;

interface APIResponse {
  status: number;
  data: unknown;
}

class UserManager {
  private _cache: Map<number, User> = new Map();

  #internalState: boolean = false;

  public getUser(userId: number): User | null {
    return this._cache.get(userId) ?? null;
  }
}

type Response<TData> = {
  success: boolean;
  data: TData;
};

// ❌ Avoid
interface userResponse {} // lowercase
type USER_DATA = {}; // constant naming
class userManager {} // lowercase
```

### Generics

Use descriptive generic names:

```typescript
// ✅ Preferred
interface Repository<TEntity> {
  findById(id: number): Promise<TEntity | null>;
  findAll(): Promise<TEntity[]>;
  create(entity: TEntity): Promise<TEntity>;
}

class UserRepository implements Repository<User> {
  async findById(id: number): Promise<User | null> {
    // Implementation
    return null;
  }

  async findAll(): Promise<User[]> {
    // Implementation
    return [];
  }

  async create(entity: User): Promise<User> {
    // Implementation
    return entity;
  }
}

// ❌ Avoid
interface Repository<T> { // Not descriptive
  find(id: number): T;
}

type ApiResponse<T, U> = {}; // Unclear parameter names
```

### Union and Intersection Types

```typescript
// ✅ Preferred
type ID = string | number;
type APIResponse<TData> = {
  success: boolean;
  data?: TData;
  error?: Error;
};

type Admin = User & { role: "admin"; permissions: string[] };

// ❌ Avoid
type ID = string | number | Symbol; // Too permissive
const id: string | number = getValue(); // Inline union
```

### Strict Mode

Enable TypeScript strict mode in `tsconfig.json`:

```json
{
  "compilerOptions": {
    "strict": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitThis": true,
    "alwaysStrict": true,
    "noImplicitAny": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

### Null and Undefined

Use strict null checks; handle explicitly:

```typescript
// ✅ Preferred
const getUser = (userId: number): User | null => {
  const user = fetchUser(userId);
  return user ?? null;
};

const displayName = (user: User | null): string => {
  if (!user) {
    return "Unknown";
  }
  return user.name;
};

// Optional chaining and nullish coalescing
const email = user?.email ?? "no-email";

// ❌ Avoid
const getUser = (userId: number): User => {
  return fetchUser(userId); // May return null
};

const email = user.email || "no-email"; // Wrong for falsy values
```

### Classes

```typescript
// ✅ Preferred
class UserService {
  private logger: Logger;
  private _cache: Map<number, User>;

  constructor(logger: Logger) {
    this.logger = logger;
    this._cache = new Map();
  }

  async getUser(userId: number): Promise<User | null> {
    const cached = this._cache.get(userId);
    if (cached) {
      return cached;
    }

    try {
      const user = await this.fetchUser(userId);
      this._cache.set(userId, user);
      return user;
    } catch (error) {
      this.logger.error("Failed to fetch user", error);
      return null;
    }
  }

  private async fetchUser(userId: number): Promise<User> {
    // Implementation
    throw new Error("Not implemented");
  }
}

// ❌ Avoid
class UserService {
  getUser(userId) {
    // No parameter type
    return this.fetchUser(userId);
  }
}
```

### Enums

Use `const` enums for better performance:

```typescript
// ✅ Preferred
const enum Status {
  Active = "active",
  Inactive = "inactive",
  Pending = "pending",
}

type UserStatus = Status;

// ❌ Avoid
enum Status {
  Active = "active",
  Inactive = "inactive",
  Pending = "pending",
}
```

### Async/Await

```typescript
// ✅ Preferred
const fetchData = async (): Promise<Data> => {
  try {
    const response = await fetch("/api/data");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data: Data = await response.json();
    return data;
  } catch (error) {
    console.error("Failed to fetch data:", error);
    throw error;
  }
};

// ❌ Avoid
const fetchData = async () => {
  const response = await fetch("/api/data");
  return response.json();
};
```

### Decorators

Decorators for dependency injection and metadata:

```typescript
// ✅ Preferred
@Injectable()
class UserService {
  constructor(private http: HttpClient) {}

  @Memoize()
  getUser(id: number): Promise<User> {
    return this.http.get(`/users/${id}`);
  }
}

// ❌ Avoid
class UserService {
  constructor(http) {
    this.http = http;
  }

  getUser(id) {
    return http.get(`/users/${id}`);
  }
}
```

## Configuration

### tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "build"]
}
```

## Formatting

- **Indentation**: 2 spaces
- **Line Length**: Maximum 120 characters
- **Line Endings**: LF (Unix style)
- **Encoding**: UTF-8
- **Semicolons**: Use them (enforced by Prettier)
- **Trailing Commas**: Use them in multi-line structures

## Tools

### Prettier

```bash
prettier --write "src/**/*.ts"
```

### ESLint with TypeScript

```bash
eslint "src/**/*.ts"
eslint --fix "src/**/*.ts"
```

### TypeScript Compiler

```bash
tsc --noEmit # Type check without emitting
tsc # Compile to JavaScript
```

### Configuration Files

#### .eslintrc.json

```json
{
  "parser": "@typescript-eslint/parser",
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking",
    "prettier"
  ],
  "parserOptions": {
    "project": "./tsconfig.json",
    "sourceType": "module"
  },
  "rules": {
    "@typescript-eslint/explicit-function-return-types": "error",
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
    "@typescript-eslint/prefer-const": "error"
  }
}
```

## Resources

- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [TypeScript Best Practices](https://www.typescriptlang.org/docs/handbook/declaration-files/do-s-and-don-ts.html)
- [Google TypeScript Style Guide](https://google.github.io/styleguide/tsguide.html)
- [Airbnb TypeScript Guide](https://github.com/airbnb/javascript/tree/master/typescript)
- [@typescript-eslint Documentation](https://typescript-eslint.io/)
