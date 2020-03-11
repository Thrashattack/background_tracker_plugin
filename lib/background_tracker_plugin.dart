import 'dart:convert';

import 'package:background_tracker_plugin/src/GeofenceRegion.dart';
import 'package:background_tracker_plugin/src/Geofence.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:wakelock/wakelock.dart';

class BackgroundTrackerPlugin extends StatelessWidget {
  final String endpoint;
  final String prefsKey;
  
  BackgroundTrackerPlugin({this.endpoint, this.prefsKey});

  @override
  Widget build(BuildContext context) {
    this.initPlugin(this.endpoint, this.prefsKey);
    return Container();
  }

  void terminate() async {
    Wakelock.disable();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Geofence.unRegisterGeofence();
    prefs.setString("Geofence Service Last Report", "terminated");
  }

  void initPlugin(endpoint, prefsKey) async {
    Wakelock.enable();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Geofence Service Last Report", "initialized");
    bool initialized = await Geofence.initialize();
    if (!initialized) {
      return null;
    }
    Position current = await Geolocator().getCurrentPosition();
    await Geofence.registerGeofence(
        GeofenceRegion(Location(current.latitude, current.longitude), 300.00,
            [GeofenceEvent.ENTER]),
        _fetchMyLocation);
  }

  void _fetchMyLocation(Location location, GeofenceEvent event) async {    
    var prefs = await SharedPreferences.getInstance();
    var lat = location.latitude;
    var lng = location.longitude;

    var response = await http.post(this.endpoint,
        body: jsonEncode({
          "${this.prefsKey}": prefs.getString(this.prefsKey),
          "lat": lat,
          "lng": lng
        }),
        headers: {
          "Content-type": "application/json",
        });

    if (jsonDecode(response.body)["status"] == 200) {
      log("Gefence Service Report: Fetch My Location is running in Background... Event: $event");
      prefs.setString("Geofence Service Last Report",
          "Gefence Service Report: Fetch My Location is running in Background... Event: $event");
    } else
      log(response.body);
    prefs.setString("Geofence Service Last Report", response.body);
  }
}