# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Build & Test:**
```bash
swift build                    # Build all targets
swift test                     # Run all tests
swift test --filter <Target>   # Run tests for specific target (e.g., SpotifyAPITests)
swift package resolve          # Resolve dependencies
swift package clean           # Clean build artifacts
```

**Single Service Testing:**
```bash
swift test --filter SpotifyAPITests
swift test --filter YandexMusicTests
swift test --filter VKMusicAPITests
swift test --filter AppleMusicTests
swift test --filter AmazonMusicTests
swift test --filter YouTubeAPITests
swift test --filter SoundCloudAPITests
swift test --filter TidalAPITests
```

## Architecture

This is a **Swift Package Manager library** that provides unified API access to 8 major music streaming services through separate, modular targets.

### Service Architecture Pattern

Each music service follows this modular pattern:
- **`[Service]API`** target: Core API implementation with models and endpoints
- **`[Service]Login`** target: OAuth/authentication flows (when required)
- **`[Service]Tests`** target: XCTest suite for the service
- **Dependencies**: All services depend on the core `SwiftMusicServicesApi` utilities

### Supported Services

1. **Spotify** - `SpotifyAPI` + `SpotifyLogin` (OAuth 2.0 + PKCE)
2. **Apple Music** - `AppleMusicAPI` + `AppleMusicLogin` (JWT tokens)
3. **Amazon Music** - `AmazonMusicAPI` (Multiple auth methods)
4. **YouTube Music** - `YouTubeAPI` + `YouTubeLogin` (OAuth 2.0)
5. **Yandex Music** - `YandexMusicAPI` + `YandexMusicLogin` (Session-based)
6. **VK Music** - `VKMusicAPI` + `VKLogin` (Session-based, uses SwiftSoup)
7. **SoundCloud** - `SoundCloudAPI` (Token-based)
8. **Tidal** - `TidalAPI` (Token-based)

### Core Utilities (`SwiftMusicServicesApi`)

The foundation module provides:
- **APIClient wrapper** with token refresh, caching, error handling
- **Authentication utilities**: PKCE generation, MD5 hashing, secure token storage
- **Error handling**: `AnyError` for unified error types across services
- **Extensions**: Safe array access, async utilities, form encoding
- **Data parsers**: ISO8601 duration parsing, string wrappers

### Key Dependencies

- **VDCodable** (2.13.0+): Enhanced Codable functionality
- **swift-api-client** (1.40.0+): HTTP client framework foundation
- **SwiftSoup** (2.4.0+): HTML parsing (VK Music only)
- **jwt-kit** (4.0.0+): JWT handling (Apple Music)
- **CryptoSwift** (1.0.0+): Cryptographic operations

### Common Patterns

- **Async/await throughout**: All API calls use modern Swift concurrency
- **Repository pattern**: Each service encapsulates its API with consistent interfaces  
- **Token management**: Automatic refresh and secure caching built-in
- **Error handling**: Comprehensive error types and centralized handling
- **Type safety**: Full Codable models with proper Swift naming conventions

### File Structure

```
Sources/
├── SwiftMusicServicesApi/     # Core utilities and shared functionality
├── SpotifyAPI/                # Spotify service implementation
├── SpotifyLogin/              # Spotify OAuth flows
├── [ServiceName]API/          # Other service implementations
├── [ServiceName]Login/        # Other service auth flows
└── ...

Tests/
├── SpotifyAPITests/           # Spotify tests
├── [ServiceName]Tests/        # Other service tests
└── ...
```

### Adding New Services

When adding a new music service:
1. Create `[Service]API` target in Package.swift depending on `SwiftMusicServicesApi`
2. Create `[Service]Login` target if OAuth/complex auth is needed
3. Add corresponding test target `[Service]Tests`
4. Follow existing patterns for API client usage, error handling, and model structure
5. Use core utilities from `SwiftMusicServicesApi` for common functionality