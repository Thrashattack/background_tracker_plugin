// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:background_tracker_plugin/src/GeofenceRegion.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:background_tracker_plugin/background_tracker_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  
  testWidgets('Background tracker report status test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id_parceiro", "199");
    await tester.pumpWidget(BackgroundTrackerPlugin(endpoint: "http://app.vemrodar.com.br/app/fetchLocation.php", prefsKey: "id_parceiro",));
    sleep(Duration(seconds: 5));
    GeofenceEvent event = GeofenceEvent.ENTER;

    expect(prefs.getString("Geofence Service Last Report"),
        "Gefence Service Report: Fetch My Location is running in Background... Event: $event");
  });
}
