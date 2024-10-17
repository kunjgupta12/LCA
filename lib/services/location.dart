import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

String location = '';
String Address = 'null';
Position? position;
List<Placemark>? placemarks;
Placemark? place;
Future<void> getlocation() async {
  position = await getGeoLocationPosition();
  location = 'Lat: ${position!.latitude} , Long: ${position!.longitude}';
  print(location);
  GetAddressFromLatLong(position!);
  print(place!.country.toString());
}

Future<Position> getGeoLocationPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
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
       openAppSettings();
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
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high
      );
}

Future<void> GetAddressFromLatLong(Position position) async {
  placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  print(placemarks);
  place = placemarks![0];
  Address =
      '${place!.street}, ${place!.subLocality}, ${place!.locality}, ${place!.postalCode}, ${place!.country}';
}
