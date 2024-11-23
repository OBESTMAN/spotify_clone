# Project Structure

- The project follows the **MVC (Model-View-Controller)** architecture, enhanced with providers for state management.  
- The file structure is organized into the following folders:  
  - **`models`**: Contains data structures and classes.  
  - **`providers`**: Manages state and handles business logic.  
  - **`services`**: Handles API calls and external services.  
  - **`views`**: Includes UI components and screens.
  - **`.env`**: Added a .env file to keep the API_URL, CLIENT_ID and CLIENT_SECRET. (usually I don't push this file)

---


# Branch Structure

This repository is organized into the following branches:

- **`dev` Branch**  
  The `dev` branch is the working branch where all development activities take place. It includes the complete commit history and reflects the progression of the project.

- **`main` Branch**  
  The `main` branch is the presentation branch, containing the finalized and polished version of the project. This branch is intended for review and distribution.

---


# Extra User Experience Features

- **Animated Splash Screen**  
  Includes a custom splash screen with animation and sound effects.  
  > **Note:** Ensure your device is not on silent mode to experience the sound effect.  

- **Shimmer Loading Effect**  
  A shimmer effect has been added for a smoother and visually appealing loading experience.  

- **Infinite Scroll Logic**  
  Artist lists implement infinite scroll, allowing up to 40 results to load dynamically.  
  > **Note:** To test this feature, search for characters like `a` or `b`, as they return more than 20 results.  

- **Cancel Button in Search Field**  
  The search text field includes a cancel button, enabling users to quickly clear search results and reset the field.

---

# Test Coverage

### Unit Tests
- Unit tests have been implemented for the `searchAlbums` and `searchArtist` services to verify their behavior and correctness.  

### UI Tests
- Widget tests have been added in `widget_test.dart` to ensure seamless app navigation and functionality. Key areas covered include:
  - **SplashScreen Transition**:
    - Verifies that the app starts on the `SplashScreen` and transitions smoothly to the `MainScreen` after the splash animation completes.
  - **MainScreen Components**:
    - Ensures the `MainScreen` displays key UI elements such as the search bar and toggle buttons (`Albums` and `Artists`) correctly.
  - **View Switching**:
    - Confirms that toggling between "Albums" and "Artists" updates the displayed content dynamically, showing the `AlbumGridView` or `ArtistListView` appropriately.

### Running the Tests
To run the tests, use the following commands:

`flutter test`

---

# If I had more time

Given additional time, I would enhance the project with the following features:

1. **Debounce Logic**  
   Implement a debounce mechanism to reduce the frequency of API calls during rapid user input in the search field. This would optimize performance and reduce server load.  
   > **Note:** Implementation would be done after securing necessary permissions.
   

2. **Caching with sqflite**  
   Introduce caching using `sqflite` to enable offline access and improve usability in areas with weak or unstable internet connections.
   

4. **Onboarding Flow**  
   Design and implement a proper onboarding experience to guide first-time users through the app’s features, ensuring they fully understand its functionality and capabilities.

  
