import 'dart:convert';

import 'package:background_tracker_plugin/src/GeofenceRegion.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeofenceTrigger {
  static bool _isInitialized = false;
  static final double defaultLat = -21.43553;
  static final double defaultLng = -54.43553;
  
  static final homeRegion = GeofenceRegion(Location(defaultLat, defaultLng),
      300.0, <GeofenceEvent>[GeofenceEvent.ENTER]);

  static Future<void> homeGeofenceCallback(
      List<String> id, Location location, GeofenceEvent event, Function callback) async {
    // Check to see if this is the first time the callback is being called.
    if (!_isInitialized) {
      // Re-initialize state required to communicate with the garage door
      // server.
      // await initialize();
      _isInitialized = true;
    }

    if (event == GeofenceEvent.ENTER) {
      print(await callback(jsonEncode(await Geolocator().getCurrentPosition())));
    } else {
      if (event == GeofenceEvent.DWELL) {
        print("Geofence Event Dwell");
      }
      if (event == GeofenceEvent.EXIT) {
        print("Geofence Event Exit");
      }
    }
  }
}
