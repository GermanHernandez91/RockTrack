# RockTrack

App that get  rock tracks from apple music api and shows details about that song. Also you can listen the song using a more details button that opens apple music in your iPhone.

## Features

- No third libraries.
- Support for ios 11, 12 and 13.
- Support for dark mode in ios 13.
- No storyboards, all work has been made programatically.
- Swift language
- Support for iPhone and iPad.

## Structure

The app is using  MVC  since there are just three screen. The app itself is really baisc to spend a lot of time adding a MVVM-C artichecture.

- Models: Network data representation
- Views: All custom views used in the appilication and gruped by categories (labels, buttons, etc..)
- Controllers: UIViewControllers that acts like screens.
- Extensions: UI Extensions grouped by files.
- Utilities: Custom error class, constants and helpers.
- Resources: Assets and Splash screen.
- Support: AppDelegate and SceneDelegate files

## Functionality

- Initial view where all rock tracks are loaded.
- Track details screen.
- Track duration formatted.
- Track release data formatted.
- Button to open track with apple music.

## Extras

- Ability to search for track name.
- Ability to add a track into favorites.
- View favorites in offline mode.
- UINavigationBar
- Swipe to remove tracks from favorite list
