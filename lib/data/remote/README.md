# Remote API Structure

This directory contains the generated API clients, request models, and response models based on the Swagger JSON specification.

## Structure

```
remote/
├── api.dart                    # Export all API clients
├── request/
│   ├── request.dart           # Export all request models
│   ├── auth/                  # Authentication requests
│   ├── user/                  # User-related requests
│   ├── video/                 # Video-related requests
│   ├── youtube/               # YouTube integration requests
│   └── common/                # Common/shared requests
├── response/
│   ├── response.dart          # Export all response models
│   ├── base_response.dart     # Base response classes
│   ├── auth/                  # Authentication responses
│   ├── user/                  # User-related responses
│   ├── video/                 # Video-related responses
│   ├── youtube/               # YouTube integration responses
│   └── highlights/            # Highlight-related responses
└── interceptors/              # HTTP interceptors
```

## Base Classes

### BaseResponse<T>
Generic base response class for all API responses with common fields:
- `success`: Boolean indicating operation success
- `message`: Response message
- `data`: Generic data payload
- `deviceId`: Device identifier

### PaginatedResponse<T>
Base class for paginated list responses:
- `data`: List of items
- `pagination`: Pagination metadata

### PaginationMeta
Pagination information:
- `totalPages`: Total number of pages
- `totalItems`: Total number of items
- `canNext`: Whether there's a next page
- `canPrev`: Whether there's a previous page
- `currentPage`: Current page number
- `limit`: Items per page

## API Clients

### AuthApi
Authentication endpoints:
- `login()`: User login
- `register()`: User registration
- `logout()`: User logout
- `refreshToken()`: Refresh JWT token
- `changePassword()`: Change user password
- `googleWebLogin()`: Google web authentication
- `googleMobileLogin()`: Google mobile authentication

### UserApi
User management endpoints:
- `getUserProfile()`: Get user profile
- `updateUserProfile()`: Update user profile

### VideoApi
Video management endpoints:
- `getVideos()`: Get paginated list of videos
- `updateVideoStatus()`: Update video upload status
- `getBatchVideoStatus()`: Get batch video status
- `createVideoBatch()`: Create video batch

### YouTubeApi
YouTube integration endpoints:
- `initiateYouTubeLink()`: Start YouTube account linking
- `youTubeCallback()`: Handle YouTube OAuth callback
- `getYouTubeStatus()`: Get YouTube link status
- `unlinkYouTube()`: Unlink YouTube account
- `uploadVideoToYouTube()`: Upload video to YouTube

### HighlightApi
Highlight management endpoints:
- `getHighlights()`: Get paginated list of highlights
- `createHighlight()`: Create new highlight
- `getHighlight()`: Get highlight by ID
- `updateHighlight()`: Update highlight
- `deleteHighlight()`: Delete highlight
- `getHighlightAnalytics()`: Get highlight analytics

## Usage

```dart
// Import API clients
import 'package:flutter_bump_app/data/remote/api.dart';

// Import request models
import 'package:flutter_bump_app/data/remote/request/request.dart';

// Import response models
import 'package:flutter_bump_app/data/remote/response/response.dart';

// Example usage
final authApi = AuthApi(dio);
final loginRequest = LoginRequest(
  username: 'user@example.com',
  password: 'password123',
);
final response = await authApi.login(loginRequest);
```

## Code Generation

To generate the required `.g.dart` files, run:

```bash
flutter packages pub run build_runner build
```

## Features

- ✅ Type-safe request/response models
- ✅ Generic base classes for common patterns
- ✅ Pagination support for list APIs
- ✅ Enum support for predefined values
- ✅ Nullable field support
- ✅ DateTime serialization
- ✅ Retrofit integration
- ✅ JSON serialization with json_annotation
