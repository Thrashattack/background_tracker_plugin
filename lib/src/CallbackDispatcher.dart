
import 'dart:ui';

import 'package:background_tracker_plugin/src/GeofenceRegion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

void callbackDispatcher() {
  // 1. Initialize MethodChannel used to communicate with the platform portion of the plugin.
  const MethodChannel _backgroundChannel =
      MethodChannel('plugins.flutter.io/geofencing_plugin_background');

  // 2. Setup internal state needed for MethodChannels.
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Listen for background events from the platform portion of the plugin.
  _backgroundChannel.setMethodCallHandler((MethodCall call) async {
    final args = call.arguments;

    // 3.1. Retrieve callback instance for handle.
    final Function callback = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(args[0]));
    assert(callback != null);

    // 3.2. Preprocess arguments.
    final triggeringGeofences = args[1].cast<String>();
    var position = await Geolocator().getCurrentPosition();
    // print(await _fetchMyLocation(jsonEncode(position)));
    final triggeringLocation = Location(position.latitude, position.longitude);
    final GeofenceEvent event = args[3];

    // 3.3. Invoke callback.
    callback(triggeringGeofences, triggeringLocation, event);
  });

  // 4. Alert plugin that the callback handler is ready for events.
  _backgroundChannel.invokeMethod('GeofencingService.initialized');
}
