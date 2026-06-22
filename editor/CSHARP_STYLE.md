# .NET / C# Style Guide

This guide documents the C# coding conventions and style preferences configured in `.editorconfig`.

## Modern C# Features (Preferred)

### Primary Constructors (C# 12)
```csharp
// ✅ Preferred
public class Person(string name, int age)
{
    public string Name { get; } = name;
    public int Age { get; } = age;
}

// ❌ Avoid
public class Person
{
    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }
    
    public string Name { get; }
    public int Age { get; }
}
```

### Switch Expressions (C# 8+)
```csharp
// ✅ Preferred
public string GetDayType(DayOfWeek day) => day switch
{
    DayOfWeek.Saturday or DayOfWeek.Sunday => "Weekend",
    _ => "Weekday"
};

// ❌ Avoid
public string GetDayType(DayOfWeek day)
{
    switch (day)
    {
        case DayOfWeek.Saturday:
        case DayOfWeek.Sunday:
            return "Weekend";
        default:
            return "Weekday";
    }
}
```

### File-Scoped Namespaces (C# 10)
```csharp
// ✅ Preferred
namespace MyApplication;

public class MyClass
{
}

// ❌ Avoid
namespace MyApplication
{
    public class MyClass
    {
    }
}
```

### Pattern Matching
```csharp
// ✅ Preferred
public decimal CalculateDiscount(Customer customer) => customer switch
{
    { IsVip: true, OrderCount: > 10 } => 0.20m,
    { IsVip: true } => 0.10m,
    { OrderCount: > 5 } => 0.05m,
    _ => 0.0m
};

// ❌ Avoid
public decimal CalculateDiscount(Customer customer)
{
    if (customer.IsVip && customer.OrderCount > 10)
        return 0.20m;
    if (customer.IsVip)
        return 0.10m;
    if (customer.OrderCount > 5)
        return 0.05m;
    return 0.0m;
}
```

### Null-Coalescing and Pattern Matching
```csharp
// ✅ Preferred
var name = user?.Name ?? "Guest";
if (value is not null) { }

// ❌ Avoid
var name = user == null ? "Guest" : user.Name;
if (value != null) { }
```

## Code Style Conventions

### Braces in Control Structures
Always use braces, even for single-line blocks:

```csharp
// ✅ Preferred
if (condition)
{
    DoSomething();
}

// ❌ Avoid
if (condition)
    DoSomething();
```

### Variable Declaration Style

Use explicit types, unless the type is apparent:

```csharp
// ✅ Preferred
string name = GetName();
var items = GetItems(); // Apparent type from method name

// ❌ Avoid
var name = GetName(); // Type not apparent
string items = GetItems(); // Unnecessary verbosity
```

### Expression-Bodied Members

Use for methods, properties, and accessors when concise:

```csharp
// ✅ Preferred
public string GetFullName() => $"{FirstName} {LastName}";
public int Age { get; set; }

private bool IsValid => _value > 0 && _value < 100;

// ❌ Avoid
public string GetFullName()
{
    return $"{FirstName} {LastName}";
}

private bool IsValid()
{
    return _value > 0 && _value < 100;
}
```

### Naming Conventions

- **Classes/Records/Structs**: PascalCase
- **Methods/Properties**: PascalCase
- **Local variables/parameters**: camelCase
- **Constants**: UPPER_SNAKE_CASE or PascalCase
- **Private fields**: _camelCase

```csharp
public class UserService
{
    private readonly ILogger _logger;
    private const int MaxRetries = 3;
    
    public async Task<User> GetUserAsync(int userId)
    {
        var user = await _repository.FindAsync(userId);
        return user;
    }
}
```

## Formatting

- **Indentation**: 4 spaces
- **Line Length**: Maximum 120 characters
- **Line Endings**: CRLF (Windows style)
- **Encoding**: UTF-8

## Tooling

These conventions are enforced via:

1. **.editorconfig** — Automatic formatting in most IDEs
2. **StyleCop Analyzers** — Optional static analysis
3. **IDE suggestions** — VSCode, Rider, Visual Studio

### Visual Studio / Rider

IDE will automatically apply formatting based on `.editorconfig` settings.

### Command Line (dotnet format)

```bash
# Format entire solution
dotnet format

# Format specific file
dotnet format path/to/file.cs

# Check without making changes
dotnet format --verify-no-changes
```

## Resources

- [C# Fundamentals](https://learn.microsoft.com/en-us/dotnet/csharp/)
- [C# Coding Conventions](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)
- [EditorConfig for C#](https://editorconfig.org/#ide-extensions)
- [StyleCop Analyzers](https://github.com/DotnetAnalyzers/StyleCopAnalyzers)
