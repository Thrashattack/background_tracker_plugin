# Background Geofence Websocket/Webhook Fetch Localization Service

background_tracker_plugin

A Android Flutter package that uses Geolocator and the Geofence source to achieve a background tracking service.
- Special Thanks to Geofence [https://github.com/ubheamar/flutter_geofence] developer 

## Getting Started

### Installation
> dependencies: <br>
> &nbsp;&nbsp;&nbsp;background_tracker_plugin: ^1.0.0+1

### Example 
``` dart
BackgroundTrackerPlugin (
    endpoint: "https://myTrackingApi.example.com/v1/receiveTrack", 
    prefsKey: "userId", //Default "id"
); 

SharedPreferences prefs = await SharedPreferences.getInstance();
String status  = prefs.getString("Geofence Service Last Report");
print(status);
```

### Enjoy it
> $ (flutter) Gefence Service Report: initialized
> $ (flutter) Gefence Service Report: Fetch My Location is running in Background... Event: Enter

### Github
[http://github.com/Thrashattack]

This project is a sample implementation point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.