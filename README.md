# AsterFlix

## AsterFlix is a simple Flutter app powered by the OMDb API.It shows movie carousels, rails, detail pages, and plays video.

Features

    Home – Carousel, Batman movies rail, and latest 2022 movies rail
    
    List View – Infinite scrolling movie lists with OMDb search & filters
    
    Details – Full movie info and inline video player
    
    Player – Resume playback where you left off
    
    State Management – Riverpod 2.x
    
    Navigation – GoRouter

### Getting Started

1) Get an OMDb API key

   Go to omdbapi.com/apikey.aspx and keep the key handy.

2) Install Flutter & dependencies

   Make sure you have Flutter installed:

   flutter --version

   Get dependencies:

   flutter pub get

3) Create platform folders (if missing)

   If you extracted this as source only:

   flutter create . --platforms=android,ios,web,macos

4) Run the app

   flutter run

5) Notes

   Internet permission is required for Android (<uses-permission android:name="android.permission.INTERNET"/> is already added).

   Use HTTPS video URLs for playback (to avoid clear-text/CORS issues).

   Tested on Android 13