# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jaspr web framework monorepo managed with Melos, containing eight interconnected packages for building modern web applications in Dart:

- **jaspr_faltool**: Base utilities, logging, and build configuration
- **jaspr_falmodel**: Data models, constants, and abstractions
- **jaspr_falconnect**: Network connectivity (HTTP client, WebSocket, RPC)
- **jaspr_falkit**: UI component library with layouts, SEO, and theming
- **jaspr_falstore**: Key-value storage abstractions
- **jaspr_falmonitor**: Analytics and monitoring (Sentry, Umami integration)
- **jaspr_falwind**: Tailwind CSS and DaisyUI integration for Jaspr
- **jaspr_falconx**: Main aggregation package that exports all other packages

## Common Development Commands

### Package Management
```bash
# Get dependencies for all packages
melos get

# Bootstrap all packages (install dependencies)
melos bootstrap

# Upgrade dependencies
melos upgrade

# Check outdated dependencies
melos outdated
```

### Code Generation
```bash
# Run build_runner for all packages that need code generation
melos build_runner

# Run build_runner in a specific package
cd jaspr_falconnect
dart pub run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation
dart pub run build_runner watch --delete-conflicting-outputs
```

### Testing
```bash
# Run all tests in a specific package
cd jaspr_faltool
dart test

# Run a single test file
dart test test/unit_test.dart

# Run tests matching a pattern
dart test -n "TestPattern"

# Run tests with specific tags
dart test -t "unit"

# Run tests with coverage
dart test --coverage=coverage
```

### Jaspr Development
```bash
# Start development server (default port 8080)
jaspr serve

# Start with custom port
jaspr serve --port 3000

# Build for production (output: build/jaspr/)
jaspr build

# Build with optimization
jaspr build --release
```

### Linting and Analysis
```bash
# Analyze code in current package
dart analyze

# Analyze with fatal warnings
dart analyze --fatal-warnings

# Fix linting issues automatically
dart fix --apply

# Format code
dart format .
```

## Architecture Overview

### Package Dependencies
The packages follow a layered architecture:
```
jaspr_faltool (base utilities)
    ↑
jaspr_falmodel (models & abstractions)
    ↑
jaspr_falconnect (network implementation)
    ↑
jaspr_falkit (UI components)
jaspr_falstore (storage)
jaspr_falmonitor (monitoring)
jaspr_falwind (CSS framework)
    ↑
jaspr_falconx (aggregation)
```

### External Dependencies
The jaspr packages wrap corresponding dart packages from the dart-falconx repository:
- `dart_falconnect`: Comprehensive HTTP/WebSocket/RPC client
- `dart_falmodel`: Base models and network exceptions  
- `dart_faltool`: Utility extensions and helpers

### Key Components

**jaspr_falconnect/**
- Network connectivity wrapping dart_falconnect with Jaspr-specific features
- HTTP client with interceptors (cache, error handling, retry, rate limiting)
- WebSocket client with retry logic and stream-based responses
- JSON-RPC implementation with Freezed code generation

**jaspr_falkit/**
- **components/**: UI components including comprehensive SEO support
  - **seo/schema/**: Full Schema.org implementation (Article, WebPage, Organization, Person, etc.)
  - **seo/**: OpenGraph, Twitter Cards, Apple/Microsoft meta tags
  - **layouts/**: Responsive layout system with gesture handling
- **themes/**: Theme management with light/dark mode support
- **tailwind/**: Tailwind CSS integration for Dart

**jaspr_falwind/**
- Tailwind CSS builder integration
- DaisyUI component library support
- Custom build modules for CSS generation

**jaspr_falmonitor/**
- Sentry integration for error tracking
- Umami analytics integration
- Monitoring utilities and abstractions

### Code Generation Patterns

The project uses several code generation tools:

1. **Freezed**: For immutable data classes with JSON serialization
   - Generated files go to `lib/{{path}}/generated/` subdirectory
   - Use `@freezed` annotation on classes
   
2. **JsonSerializable**: For JSON conversion
   - Works in conjunction with Freezed
   - Use `@JsonSerializable()` annotation
   
3. **Auto Route**: Route generation for navigation
   - Define routes with `@AutoRoute()` annotation
   
4. **Retrofit**: REST API client generation
   - Define API interfaces with `@RestApi()` annotation

When modifying files with code generation annotations, always run build_runner afterward.

### Important Patterns

1. **Wrapper Pattern**: Jaspr packages wrap dart packages for web-specific functionality

2. **Export Re-aggregation**: Each package exports both its own code and wrapped dependencies through a central `lib.dart` file

3. **Component-Based UI**: Layout system with gesture handling, theming, and SEO optimization

4. **Interceptor Pattern**: HTTP and WebSocket clients use interceptor chains for cross-cutting concerns

5. **Extension Methods**: Heavy use of Dart extensions for type conversions and utilities

6. **Stream-Based Architecture**: WebSocket responses exposed as filtered streams for reactive programming

7. **Schema.org SEO**: Comprehensive implementation of structured data schemas for better search engine visibility

## SEO Components Architecture

The jaspr_falkit package includes a comprehensive SEO implementation:

### Schema.org Schemas
- **WebPageSchema**: Enhanced with backward compatibility for WebPageSchemaData
- **Organization/Person**: Complete entity schemas with relationships
- **Article/BlogPosting**: Content schemas with author and publisher support
- **ContactPoint/PostalAddress**: Contact and location information
- **EducationalOrganization/Place**: Specialized entity types
- Helper utilities for creating structured data

### Meta Tags
- OpenGraph meta tags for social sharing
- Twitter Card meta tags
- Apple-specific meta tags (Safari, iOS)
- Microsoft-specific meta tags (Edge, Windows)
- Default meta tags for general SEO

## Configuration

### Analysis Options
The project uses `very_good_analysis` package for strict linting with some rules disabled for practical reasons (see `analysis_options.yaml` in each package).

### Build Configuration
Code generation outputs are configured to generate into `generated/` subdirectories to keep the main source directories clean (see `build.yaml`).

### Workspace Configuration
- Dart SDK requirement: >=3.9.0 <4.0.0
- Workspace-based dependency resolution in root `pubspec.yaml`
- Melos configuration for monorepo management
- Each package uses `resolution: workspace` in its pubspec.yaml

## Development Tips

1. Always run `melos get` or `melos bootstrap` after pulling changes that modify pubspec files
2. Generated files (`*.g.dart`, `*.freezed.dart`) should not be edited manually
3. When adding new packages to the workspace, update the root `pubspec.yaml` workspace section
4. For Jaspr-specific development, use `jaspr serve` for hot reload during development
5. The project requires Dart SDK >=3.9.0 and uses workspace-based dependency resolution
6. When working with SEO schemas, use the factory methods and helper classes for consistency
7. jaspr_falwind requires Node.js for Tailwind CSS compilation during build