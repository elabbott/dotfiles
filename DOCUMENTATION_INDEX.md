# Documentation Index

Complete guide to all documentation in this repository. Start here if you're new or looking for specific information.

## Quick Navigation

**New to this repository?** → Start with [SETUP_GUIDE.md](SETUP_GUIDE.md)

**Want to customize?** → Go to [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)

**Having problems?** → Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

**Understanding shell config?** → Read [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md)

---

## Documentation Structure

### 📖 Main Guides

#### [README.md](README.md) — Overview
**Start here for:**
- What this repository does
- Why you should use dotfiles
- Quick start options
- Feature overview
- Directory structure

**Topics covered:**
- Repository purpose
- Installation methods comparison
- Common tasks
- Troubleshooting quick fixes
- Quick reference

---

#### [SETUP_GUIDE.md](SETUP_GUIDE.md) — Installation
**Use this for:**
- Step-by-step installation instructions
- Different installation methods
- Post-installation setup
- Installation verification
- Detailed troubleshooting

**Topics covered:**
- Prerequisites (what you need)
- Prerequisites (what you need)
- Automated installation (recommended)
- Manual installation (more control)
- GitHub Codespaces setup
- Git configuration
- SSH key generation
- Verification checklist
- Detailed troubleshooting

**Sections:**
- Prerequisites — What you need before starting
- Installation Methods — Three different ways to set up
- Post-Installation Setup — What to do after installation
- Verifying Installation — How to check everything works
- Troubleshooting — Solving common installation problems

---

#### [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) — Personalizing
**Use this to:**
- Add your own aliases and functions
- Customize shell configuration
- Create custom scripts
- Machine-specific settings
- Share customizations with your team

**Topics covered:**
- Quick customizations (no coding needed)
- Shell configuration options
- Git configuration customization
- Editor configuration
- Creating custom scripts
- OS-specific customization
- Advanced configuration patterns
- Testing your changes

**Sections:**
- Quick Customizations — Easy changes anyone can make
- Shell Configuration — Adding aliases and environment variables
- Git Configuration — Customizing git behavior
- Editor Configuration — VSCode, Vim, etc.
- Custom Scripts — Creating utility scripts
- OS-Specific Customization — macOS, Linux options
- Advanced Configuration — Machine-specific, conditional setup
- Testing Your Customizations — Verifying changes work

---

#### [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md) — Shell Deep Dive
**Use this to:**
- Understand shell configuration thoroughly
- Learn about aliases, functions, exports
- Reference all shell features
- Best practices for shell scripting
- Advanced shell patterns

**Topics covered:**
- Shell configuration files
- Environment variables (and why to use each)
- Alias creation and best practices
- Function creation with examples
- Shell-specific features
- Conditional configuration
- Performance optimization
- Troubleshooting shell issues

**Sections:**
- Overview — How shell config works
- Configuration Files — Understanding each file
- Environment Variables — What they do and why
- Aliases — Shortcuts and commands
- Functions — Complex operations
- Best Practices — Do's and don'ts
- Advanced Topics — Conditional loading, machine-specific config
- Troubleshooting — Fixing shell configuration issues

---

#### [TROUBLESHOOTING.md](TROUBLESHOOTING.md) — Problem Solving
**Use this when:**
- Installation fails
- Scripts aren't working
- Configuration isn't loading
- Git configuration issues
- OS-specific problems

**Topics covered:**
- Installation issues (permissions, package managers)
- PATH and script accessibility
- Shell configuration problems
- Git configuration issues
- Symlink issues
- OS-specific solutions (macOS, Linux)
- Performance troubleshooting
- How to get help

**Sections:**
- Installation Issues — Fixing setup problems
- PATH and Script Issues — Making scripts accessible
- Shell Configuration Issues — Aliases, functions, variables
- Git Configuration Issues — Git not recognizing config
- Symlink and File Issues — Broken links, file conflicts
- OS-Specific Issues — macOS and Linux specific problems
- Performance Issues — Slow shell startup
- Getting Help — How to report issues

---

#### [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md) — This File
**Use this to:**
- Navigate all documentation
- Find what you're looking for
- Understand documentation structure
- Know when to read which guide

---

### 📁 Directory-Specific Guides

#### [bin/README.md](bin/README.md) — Custom Scripts
**Topics covered:**
- Available utility scripts
- How to set up scripts in your PATH
- Using each script (git-cleanup, open-port, etc.)
- Why each script exists
- Creating your own scripts

**Scripts documented:**
- `setup-path` — Add scripts to PATH
- `git-cleanup` — Remove merged branches
- `dotfiles-sync` — Update from GitHub
- `open-port` — Find process on port
- `find-large` — Find large files
- And more...

**When to read:**
- Wondering what scripts are available
- Need to use a specific script
- Want to create your own script
- Setting up scripts for first time

---

#### [shell/README.md](shell/README.md) — Shell Setup
**Topics covered:**
- Shell configuration overview
- Supported shells (Zsh, Bash, Fish)
- File structure
- How to use shell configurations
- Basic customization

**When to read:**
- First time setting up shell
- Need to understand shell config structure
- Quick shell customization overview
- Need to use existing shell configs

---

#### [git/README.md](git/README.md) — Git Setup
**Topics covered:**
- Git configuration overview
- Global vs local configuration
- Useful git aliases
- Managing gitignore rules
- Git hooks

**When to read:**
- Setting up git for first time
- Need to understand git configuration
- Want to add git aliases
- Understanding global gitignore

---

#### [editor/README.md](editor/README.md) — Editor Configuration
**Topics covered:**
- Editor configuration overview
- Configuration layers
- VSCode setup
- Vim setup
- EditorConfig for cross-editor consistency
- Language-specific configurations

**When to read:**
- Setting up editor for first time
- Need editor-specific configuration
- Want consistent coding style across editors
- Setting up language-specific tools

---

#### [macos/README.md](macos/README.md) — macOS Setup
**Topics covered:**
- macOS-specific configurations
- System defaults
- Homebrew package management
- macOS customization

**When to read:**
- Using this on macOS
- Want to apply macOS defaults
- Need macOS-specific setup
- Managing Homebrew packages

---

#### [linux/README.md](linux/README.md) — Linux Setup
**Topics covered:**
- Linux distribution support
- apt vs yum package managers
- Distribution detection
- Linux-specific configurations

**When to read:**
- Using this on Linux
- Need distribution-specific setup
- Managing apt/yum packages
- Linux-specific customization

---

#### [scripts/README.md](scripts/README.md) — Installation Scripts
**Topics covered:**
- Installation script overview
- How setup works
- Individual script purposes
- OS detection
- Dotfile linking

**When to read:**
- Understanding how installation works
- Debugging installation script
- Understanding individual setup steps

---

#### [codespaces/README.md](codespaces/README.md) — GitHub Codespaces
**Topics covered:**
- Codespaces-specific setup
- devcontainer configuration
- VSCode extensions for Codespaces
- One-click setup

**When to read:**
- Using this in GitHub Codespaces
- Setting up cloud development environment
- Understanding Codespaces configuration

---

## Finding What You Need

### By Use Case

#### "I'm brand new and don't know where to start"
1. Read [README.md](README.md) for overview
2. Follow [SETUP_GUIDE.md](SETUP_GUIDE.md) for installation
3. Try [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) to personalize

#### "I want to install the dotfiles"
→ Go to [SETUP_GUIDE.md](SETUP_GUIDE.md)

#### "I want to customize my setup"
→ Start with [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)

#### "Something isn't working"
→ Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

#### "I want to understand shell configuration deeply"
→ Read [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md)

#### "I want to know about a specific script"
→ See [bin/README.md](bin/README.md)

#### "I need to configure [git/vim/vscode/etc]"
→ See the appropriate directory README:
- Git → [git/README.md](git/README.md)
- Editors → [editor/README.md](editor/README.md)
- macOS → [macos/README.md](macos/README.md)
- Linux → [linux/README.md](linux/README.md)
- Shell → [shell/README.md](shell/README.md)

---

### By Topic

#### Installation
- Quick → [README.md — Quick Start](README.md#quick-start)
- Detailed → [SETUP_GUIDE.md](SETUP_GUIDE.md)
- Troubleshooting → [TROUBLESHOOTING.md — Installation Issues](TROUBLESHOOTING.md#installation-issues)

#### Shell Configuration
- Quick overview → [shell/README.md](shell/README.md)
- Quick customization → [CUSTOMIZATION_GUIDE.md — Quick Customizations](CUSTOMIZATION_GUIDE.md#quick-customizations)
- Deep reference → [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md)
- Troubleshooting → [TROUBLESHOOTING.md — Shell Configuration Issues](TROUBLESHOOTING.md#shell-configuration-issues)

#### Git Configuration
- Quick overview → [git/README.md](git/README.md)
- Customization → [CUSTOMIZATION_GUIDE.md — Git Configuration](CUSTOMIZATION_GUIDE.md#git-configuration)
- Troubleshooting → [TROUBLESHOOTING.md — Git Configuration Issues](TROUBLESHOOTING.md#git-configuration-issues)

#### Custom Scripts
- Overview → [bin/README.md](bin/README.md)
- Creating scripts → [CUSTOMIZATION_GUIDE.md — Custom Scripts](CUSTOMIZATION_GUIDE.md#custom-scripts)
- Using scripts → [bin/README.md — Available Scripts](bin/README.md#available-scripts)

#### Editor Setup
- Overview → [editor/README.md](editor/README.md)
- Customization → [CUSTOMIZATION_GUIDE.md — Editor Configuration](CUSTOMIZATION_GUIDE.md#editor-configuration)

#### macOS
- Setup → [macos/README.md](macos/README.md)
- Issues → [TROUBLESHOOTING.md — macOS Issues](TROUBLESHOOTING.md#macos-issues)

#### Linux
- Setup → [linux/README.md](linux/README.md)
- Issues → [TROUBLESHOOTING.md — Linux Issues](TROUBLESHOOTING.md#linux-issues)

#### GitHub Codespaces
- Setup → [codespaces/README.md](codespaces/README.md)
- Installation → [SETUP_GUIDE.md — GitHub Codespaces](SETUP_GUIDE.md#github-codespaces)

---

## Documentation Levels

### Level 1: Quick Reference
**For:** People in a hurry, veterans
**Files:** README.md quick sections, command references

**What you'll find:** Commands, links to details

### Level 2: How-To Guides
**For:** Most users, learning by doing
**Files:** SETUP_GUIDE.md, CUSTOMIZATION_GUIDE.md

**What you'll find:** Step-by-step instructions, examples, when to use what

### Level 3: Reference
**For:** Deep understanding, troubleshooting
**Files:** SHELL_CONFIGURATION_REFERENCE.md, TROUBLESHOOTING.md

**What you'll find:** Complete details, why things work, comprehensive examples

### Level 4: Directory Guides
**For:** Component-specific setup
**Files:** Directory README.md files

**What you'll find:** Component overview, how that part works, available options

---

## Common Questions & Where to Find Answers

| Question | Answer Location |
|----------|-----------------|
| How do I install this? | [SETUP_GUIDE.md](SETUP_GUIDE.md) |
| How do I customize it? | [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) |
| How do I add an alias? | [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md#aliases) or [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md#add-your-personal-aliases) |
| How do I add a function? | [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md#functions) or [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md#add-shell-functions) |
| How do I create a custom script? | [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md#custom-scripts) |
| What scripts are available? | [bin/README.md](bin/README.md#available-scripts) |
| What scripts exist? | [README.md — What's Included](README.md#whats-included) |
| How do I fix installation errors? | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| How do I fix script not found errors? | [TROUBLESHOOTING.md — PATH Issues](TROUBLESHOOTING.md#path-and-script-issues) |
| How do I set up git? | [git/README.md](git/README.md) and [SETUP_GUIDE.md](SETUP_GUIDE.md#3-configure-git-identity) |
| How do I set up an editor? | [editor/README.md](editor/README.md) |
| How do I set up macOS defaults? | [macos/README.md](macos/README.md) |
| How do I use dotfiles on Linux? | [linux/README.md](linux/README.md) |
| How do I use dotfiles in Codespaces? | [codespaces/README.md](codespaces/README.md) |
| What is an alias? | [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md#aliases) |
| What is a function? | [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md#functions) |
| What are environment variables? | [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md#environment-variables) |
| My script isn't found | [TROUBLESHOOTING.md](TROUBLESHOOTING.md#path-and-script-issues) |
| My alias isn't working | [TROUBLESHOOTING.md](TROUBLESHOOTING.md#shell-configuration-issues) |
| Installation failed | [TROUBLESHOOTING.md](TROUBLESHOOTING.md#installation-issues) |

---

## Documentation Quality

All documentation in this repository includes:

✅ **Clear structure** — Organized with headers and tables of contents

✅ **Practical examples** — Real commands you can copy and run

✅ **Why explanations** — Understanding the reasoning, not just the how

✅ **Troubleshooting** — Common problems and solutions

✅ **Cross-references** — Links between related topics

✅ **Multiple levels** — Quick reference and deep dives

✅ **Step-by-step** — Clear sequential instructions

✅ **Before/after** — What changes and why

✅ **Multiple perspectives** — Different ways to accomplish tasks

✅ **Safety first** — Warnings about destructive operations

---

## Learning Path

### For Complete Beginners

1. **Day 1:** Read [README.md](README.md) to understand what dotfiles are
2. **Day 1:** Follow [SETUP_GUIDE.md](SETUP_GUIDE.md) to install
3. **Day 2:** Explore [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) to add your first alias
4. **Day 2:** Check [bin/README.md](bin/README.md) to learn about scripts
5. **Day 3:** Read [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md) to understand deeply

### For Experienced Users

1. **Quick:** Skim [README.md](README.md#quick-start)
2. **Setup:** Jump to [SETUP_GUIDE.md — Quick Start](SETUP_GUIDE.md#quick-start)
3. **Customize:** See [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) for advanced patterns
4. **Reference:** Use [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md) as needed

### For Troubleshooting

1. **Error occurs** → Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. **Not found in overview** → Search specific section
3. **Still stuck** → See "Getting Help" in [TROUBLESHOOTING.md](TROUBLESHOOTING.md#getting-help)

---

## Using This Documentation Effectively

### Tips

1. **Bookmark quick reference** — Keep [README.md — Quick Reference](README.md#quick-reference) bookmarked for fast lookup

2. **Use search** — Most markdown viewers support search (Ctrl+F)

3. **Read the why** — Don't just copy commands; understand the reasoning

4. **Try in stages** — Make one change, test it, then move to the next

5. **Keep notes** — Jot down your customizations for reference

6. **Reference often** — These guides are meant to be used repeatedly

### Browser Tips

- **Search:** Use Ctrl+F / Cmd+F to find topics
- **Table of Contents:** Click headers to navigate
- **Links:** Click cross-references to jump between guides
- **Print:** Guides print well if you need physical copies

---

## Contributing to Documentation

Found a gap? Confusing section? Want to contribute?

- **Report issues** — File issues on GitHub
- **Suggest improvements** — Open a discussion
- **Add examples** — Submit pull requests with new examples
- **Share knowledge** — Write new sections based on your experience

---

## Document Version

This documentation covers:
- **Repository Version:** As of current commit
- **Last Updated:** See git history
- **Maintenance:** Kept current with code changes

---

## Quick Links

| Need | Link |
|------|------|
| **Get started** | [SETUP_GUIDE.md](SETUP_GUIDE.md) |
| **Customize** | [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) |
| **Fix issues** | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| **Learn deep** | [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md) |
| **Overview** | [README.md](README.md) |
| **Scripts** | [bin/README.md](bin/README.md) |
| **Shell** | [shell/README.md](shell/README.md) |
| **Git** | [git/README.md](git/README.md) |
| **Editors** | [editor/README.md](editor/README.md) |
| **macOS** | [macos/README.md](macos/README.md) |
| **Linux** | [linux/README.md](linux/README.md) |
| **Codespaces** | [codespaces/README.md](codespaces/README.md) |

