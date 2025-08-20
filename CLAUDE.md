# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jaspr web framework monorepo managed with Melos, containing seven interconnected packages for building modern web applications in Dart:

- **jaspr_faltool**: Base utilities, logging, and build configuration
- **jaspr_falmodel**: Data models, constants, and abstractions
- **jaspr_falconnect**: Network connectivity (HTTP client, WebSocket, RPC)
- **jaspr_falkit**: UI component library with layouts, SEO, and theming
- **jaspr_falstore**: Key-value storage abstractions
- **jaspr_falmonitor**: Analytics and monitoring (Sentry, Umami integration)
- **jaspr_falconx**: Main aggregation package that exports all other packages

## Common Development Commands

### Package Management
```bash
# Get dependencies for all packages
melos get

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
```

### Jaspr Development
```bash
# Start development server (port 8080)
jaspr serve

# Build for production (output: build/jaspr/)
jaspr build
```

### Linting and Analysis
```bash
# Analyze code in each package
dart analyze

# Fix linting issues
dart fix --apply
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
- **components/**: UI components including SEO (OpenGraph, Twitter, Schema.org)
- **layouts/**: Layout system with gesture handling and responsive design
- **themes/**: Theme management with light/dark mode support
- **tailwind/**: Tailwind CSS integration for Dart

**jaspr_falmonitor/**
- Sentry integration for error tracking
- Umami analytics integration
- Monitoring utilities and abstractions

### Code Generation Patterns

The project uses several code generation tools:

1. **Freezed**: For immutable data classes with JSON serialization
   - Generated files go to `lib/{{path}}/generated/` subdirectory
   
2. **JsonSerializable**: For JSON conversion
   - Works in conjunction with Freezed
   
3. **Auto Route**: Route generation for navigation
   
4. **Retrofit**: REST API client generation

When modifying files with code generation annotations (@freezed, @JsonSerializable), always run build_runner afterward.

### Important Patterns

1. **Wrapper Pattern**: Jaspr packages wrap dart packages for web-specific functionality

2. **Export Re-aggregation**: Each package exports both its own code and wrapped dependencies

3. **Component-Based UI**: Layout system with gesture handling, theming, and SEO optimization

4. **Interceptor Pattern**: HTTP and WebSocket clients use interceptor chains for cross-cutting concerns

5. **Extension Methods**: Heavy use of Dart extensions for type conversions and utilities

6. **Stream-Based Architecture**: WebSocket responses exposed as filtered streams for reactive programming

## Configuration

### Analysis Options
The project uses `very_good_analysis` package for strict linting with some rules disabled for practical reasons (see `analysis_options.yaml` in each package).

### Build Configuration
Code generation outputs are configured to generate into `generated/` subdirectories to keep the main source directories clean (see `build.yaml`).

### Workspace Configuration
- Dart SDK requirement: >=3.9.0 <4.0.0
- Workspace-based dependency resolution in root `pubspec.yaml`
- Melos configuration for monorepo management

## Development Tips

1. Always run `melos get` after pulling changes that modify pubspec files
2. Generated files (`*.g.dart`, `*.freezed.dart`) should not be edited manually
3. When adding new packages to the workspace, update the root `pubspec.yaml` workspace section
4. For Jaspr-specific development, use `jaspr serve` for hot reload during development
5. The project requires Dart SDK >=3.9.0 and uses workspace-based dependency resolution