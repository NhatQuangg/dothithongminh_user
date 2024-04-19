import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationApp extends StatefulWidget {
  const GeolocationApp({super.key});

  @override
  State<GeolocationApp> createState() => _GeolocationAppState();
}

class _GeolocationAppState extends State<GeolocationApp> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = "";
  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.street} / ${place.locality} / ${place.administrativeArea} / ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Location"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Location Location",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
                "Latitude = ${_currentLocation?.latitude} ; Longtitude = ${_currentLocation?.longitude}"),
            SizedBox(
              height: 30,
            ),
            Text(
              "Location Address",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Text("${_currentAddress}"),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  _currentLocation = await _getCurrentLocation();
                  await _getAddressFromCoordinates();
                  print("${_currentLocation}");
                  print("${_currentAddress}");
                },
                child: Text("Get Location"))
          ],
        ),
      ),
    );
  }
}