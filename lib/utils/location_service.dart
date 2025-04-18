import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  // Get Location Methods

  // First Method to check if location service is enabled or not

  Future<bool> checkAndRequestLocationService() async {
    var isEnabled = await location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await location.requestService();
      if (!isEnabled) {
        // Show a dialog or a snackbar to inform the user that location services are disabled
        return false;
      }
    }
    return true;
  }

  // Second Method to check if location permission is granted or not

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }
    return true;
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }
}
