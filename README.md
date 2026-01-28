# Pinterest Clone - Flutter Application

A beautiful, feature-rich Pinterest clone built with Flutter, showcasing modern mobile development practices with clean architecture, advanced state management, and seamless API integration.

## Overview

This application replicates the core functionality of Pinterest, allowing users to discover, save, and organize visual content. Built with a focus on clean code architecture and scalability, it demonstrates best practices in Flutter development including state management with Riverpod, advanced routing with GoRouter, and efficient networking with Dio.

## Features

- **Photo Discovery** - Browse an infinite feed of high-quality photos from the Pexels API
- **Search Functionality** - Search for photos by keywords and explore trending content
- **Photo Details** - View detailed information about photos including photographer details and related images
- **Save & Collections** - Save photos to personal boards and organize content
- **User Profiles** - Create and manage user profiles with authentication via Clerk
- **Smooth Animations** - Hero animations and shimmer loading effects for polished UX
- **Responsive Design** - Optimized layouts for various device sizes
- **Offline Caching** - Intelligent image caching for faster load times

## Tech Stack

### State Management
- **flutter_riverpod** (^2.4.9) - Declarative state management with providers and notifiers
- **riverpod_annotation** (^2.3.3) - Annotations for code generation

### Navigation
- **go_router** (^13.0.0) - Declarative routing and navigation management

### Networking & API
- **dio** (^5.4.0) - HTTP client for API requests
- **cached_network_image** (^3.3.1) - Image caching and optimization
- **Pexels API** - Free stock photos and videos API

### UI & Design
- **flutter_staggered_grid_view** (^0.7.0) - Masonry grid layout
- **shimmer** (^3.0.0) - Shimmer loading effect
- **smooth_page_indicator** (^1.1.0) - Page indicator for carousels

### Authentication
- **clerk_flutter** (^0.0.13-beta) - Modern authentication solution
- **clerk_auth** (^0.0.13-beta) - Clerk authentication utilities

### Data & Storage
- **shared_preferences** (^2.2.2) - Local key-value storage
- **freezed** (^2.4.6) - Code generation for data models
- **json_serializable** (^6.7.1) - JSON serialization

### Utilities
- **equatable** (^2.0.5) - Equality comparison utilities
- **json_annotation** (^4.8.1) - JSON annotations
- **intl** - Internationalization support
- **image_picker** (^1.0.7) - Select images from gallery/camera
- **video_player** (^2.8.1) - Video playback functionality

## Architecture

This project follows **Clean Architecture** principles, separating concerns into three main layers:

### 1. **Presentation Layer**
Handles all UI components and user interactions. Communicates with the domain layer for business logic.


**Screens:**
- `HomeScreen` - Main feed with infinite photo scrolling
- `SearchScreen` - Search and filtering functionality
- `PhotoDetailScreen` - Detailed photo view with related content
- `ProfileScreen` - User profile management
- `SavedScreen` - Collections and saved pins
- `AccountSettingsScreen` - User preferences

**Widgets:**
- `PhotoGrid` - Masonry grid layout for photos
- `PhotoCard` - Individual photo card with actions
- `CreateBottomSheet` - Bottom sheet for creating content
- `ShimmerGrid` - Loading skeleton UI
- `PinOptionsOverlay` - Options menu for photos

### 2. **Domain Layer**
Contains business logic, use cases, and domain entities. Independent of any external framework.

**Models:**
- `PhotoModel` - Photo entity with metadata
- User models for authentication and profiles

### 3. **Data Layer**
Implements the domain repositories and handles data sources (APIs, local storage, cache).


**Datasources:**
- `PexelsRemoteDataSource` - Pexels API integration
- `LocalDataSource` - Shared preferences and local storage

## State Management with Riverpod

### Providers (Dependency Injection & State Sharing)

Providers serve as the foundation for dependency injection and state sharing:

### Notifiers (Complex State Management)

State notifiers handle complex state transformations and side effects:

### Controllers (Business Logic Coordination)

Controllers coordinate business logic and orchestrate between UI and domain layers:

## Service Layer

The service layer provides abstraction for external services and utilities:

### Network Service
Handles all API communication through Dio with interceptors for error handling and request/response transformation.

### Cache Service
Manages image caching and memory optimization for better performance.

### File Service
Handles file operations including image picker and storage.

## API Integration - Pexels

The application integrates with the **Pexels API** (https://www.pexels.com/api/) to fetch high-quality stock photos and videos.

### Pexels API Endpoints Used

- **GET /v1/curated** - Fetch curated photos for the home feed
- **GET /v1/search** - Search photos by keywords
- **GET /v1/photos/{id}** - Get detailed photo information

### Setup

1. Get your free API key from [Pexels API](https://www.pexels.com/api/)
2. Add it to your environment configuration
3. The service layer handles all authentication and requests

## Getting Started

### Prerequisites

- Flutter SDK (v3.9.2 or higher)
- Dart SDK (included with Flutter)
- Pexels API key

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pinterest
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   The project uses code generation for Riverpod and Freezed:
   ```bash
   flutter pub run build_runner build
   ```

