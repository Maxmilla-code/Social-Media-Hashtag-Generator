# Social Media Hashtag Generator

## 1. Project Overview

This is a Flutter-based mobile application designed to help social media managers, marketers, and content creators generate effective hashtags for their posts. The app leverages a simulated AI service to provide not just hashtag suggestions, but also trend analysis and platform-specific recommendations, enabling users to maximize their social media reach and engagement.

This project was built as a learning exercise to understand the architecture and implementation of AI-driven mobile applications.

## 2. Features

*   **Dynamic Hashtag Generation**: Enter a topic or keyword and receive a list of relevant hashtags.
*   **Trend Analysis**: Each hashtag comes with a "trend score" to help you gauge its current popularity.
*   **Platform-Specific Recommendations**: Get suggestions for which social media platforms (e.g., Instagram, Twitter, LinkedIn) a hashtag is most suitable for.
*   **Copy to Clipboard**: Easily copy individual hashtags or all of them at once.
*   **Clean, Modern UI**: A simple and intuitive user interface built with Flutter.
*   **Mock Backend**: The application uses a mocked backend service that simulates calls to an AI API, making it easy to integrate with a real service like OpenAI.

## 3. Project Structure

The project follows a clean and scalable architecture, with a clear separation of concerns.

```
.
├── lib
│   ├── main.dart             # App entry point
│   ├── models                # Data models
│   │   └── hashtag_analysis.dart
│   ├── screens               # UI screens
│   │   ├── home_screen.dart
│   │   └── results_screen.dart
│   └── services              # Business logic and services
│       └── hashtag_service.dart
├── test
│   └── hashtag_service_test.dart # Unit tests
└── pubspec.yaml            # Dependencies
```

*   **`models`**: Contains the data structures for the application, such as `HashtagAnalysis`.
*   **`screens`**: Contains the individual screens of the application.
*   **`services`**: Contains the business logic, including the `HashtagService` which is responsible for fetching data from the (mock) API.
*   **`test`**: Contains all the unit and widget tests for the application.

## 4. Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.x or higher)
*   [Dart SDK](https://dart.dev/get-dart) (comes with Flutter)
*   A code editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Installation & Running the App

1.  **Clone the repository:**
    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Run the application:**
    ```sh
    flutter run
    ```
    This will launch the app on your connected device or emulator.

## 5. Running Tests

This project includes unit tests for the `HashtagService`. To run the tests, use the following command:

```sh
flutter test
```

The tests use the `http/testing` package to mock the HTTP client, ensuring that the service can be tested without making live network requests.

## 6. Configuration

The `HashtagService` is designed to be used with an AI service like OpenAI. For security, the API key is not hardcoded. To connect the app to a real API, follow these steps:

1.  **Obtain an API Key** from your chosen AI provider (e.g., [OpenAI](https://platform.openai.com/)).

2.  **Set up environment variables.** A recommended way to do this in Flutter is with the `flutter_dotenv` package. You would create a `.env` file in the root of the project:
    ```
    OPENAI_API_KEY=your_api_key_here
    ```

3.  **Update `HashtagService`**. In `lib/services/hashtag_service.dart`, you will need to:
    *   Load the API key from the environment.
    *   Uncomment the actual `http.post` call and remove the mock response.

    ```dart
    // Example of how to load the key
    // const apiKey = String.fromEnvironment('OPENAI_API_KEY');
    // if (apiKey.isEmpty) {
    //   throw Exception('API key not found.');
    // }

    // Replace the mock response with the actual API call
    // final response = await client.post(...)
    ```
