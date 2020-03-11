class Location {
  final double _latitude, _longitude;
  Location(this._latitude, this._longitude);

  get latitude => this._latitude;
  get longitude => this._longitude;
}

/// A circular region which represents a geofence.
class GeofenceRegion {
  /// The location of the geofence.
  final Location location;

  /// The radius around `location` that will be considered part of the geofence.
  final double radius;

  final List<GeofenceEvent> triggers;

  GeofenceRegion(this.location, this.radius, this.triggers);

  List<dynamic> toArgs() {
    final List<dynamic> args = <dynamic>[
      location.latitude,
      location.longitude,
      radius
    ];
    return args;
  }
}


const int _kEnterEvent = 1;
const int _kExitEvent = 2;
const int _kDwellEvent = 3;
enum GeofenceEvent { ENTER, EXIT, DWELL }

// Internal.
int geofenceEventToInt(GeofenceEvent e) {
  switch (e) {
    case GeofenceEvent.ENTER:
      return _kEnterEvent;
    case GeofenceEvent.EXIT:
      return _kExitEvent;
    case GeofenceEvent.DWELL:
      return _kDwellEvent;
    default:
      throw UnimplementedError();
  }
}

// Internal.
GeofenceEvent intToGeofenceEvent(int e) {
  switch (e) {
    case _kEnterEvent:
      return GeofenceEvent.ENTER;
    case _kExitEvent:
      return GeofenceEvent.EXIT;
    case _kDwellEvent:
      return GeofenceEvent.DWELL;
    default:
      throw UnimplementedError();
  }
}
