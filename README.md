<p align="center">
    <img src="/Images/TouristHelper.png">
    <figcaption>Image by Itty Bitty Apps</figcaption>
</p>

# Tourist Helper

[![Twitter](https://img.shields.io/badge/Twitter-%40naeemshaikh90-blue.svg)](https://twitter.com/naeemshaikh90)

Write an app that will help tourists find sights to see wherever they may be. Use an appropriate API (e.g., Google Places, Yelp, Foursquare, Flickr, etc) to grab information about 100 interesting locations around the device’s current location. Plot each location on a map view. Somehow display information about each location when the user selects the location.

Beginning at the devices current location, draw a route that connects all the locations together and ends back at the current location. Don’t bore your tourist by visiting any location twice. Don’t make your tourist too tired by making the length of the connecting path any longer than is necessary.

The paths are as the crow flies, don’t worry about routing on roads or other paths.

## Screenshot
![](/Images/Demo.png)

## Installation

This project uses [CocoaPods](https://cocoapods.org). All you need to setup it properly is:
```
pod install
```

Run:
```
Open ‘TouristHelper.xcworkspace’
```

## Tasks:

### General
- [x] Create a Git repo
- [x] Create a Readme file with instruction to run project
- [x] Publish to GitHub

### Development
- [x] Add Google Map
- [x] Grab user’s current location
- [x] Create a model to handle user location data
- [x] Grab interesting sights using Google places API
    - [ ] Grab 100 interesting sights
- [x] Parse the API response
- [x] Create model to handle API response
- [x] Test cases for models
- [x] Plot pins on map
- [x] Display info on pin selection
- [x] Draw a route to connect all the locations with ending to current location
    - [x] Single visit on all locations
    - [ ] Choose shortest available path
    - [x] The paths are as the crow files
