import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

String location = '';
String Address = 'null';
Position? position;
List<Placemark>? placemarks;
Placemark? place;
Future<void> getlocation() async {
  position = await _getGeoLocationPosition();
  location = 'Lat: ${position!.latitude} , Long: ${position!.longitude}';
  print(location);
  GetAddressFromLatLong(position!);
  print(place!.country.toString());
}

Future<Position> _getGeoLocationPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // await Geolocator.requestPermission();
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error');
    });
    return await Geolocator.getCurrentPosition();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<void> GetAddressFromLatLong(Position position) async {
  placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  print(placemarks);
  place = placemarks![0];
  Address =
      '${place!.street}, ${place!.subLocality}, ${place!.locality}, ${place!.postalCode}, ${place!.country}';
}
