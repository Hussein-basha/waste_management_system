// ignore_for_file: avoid_print
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //const LocationScreen({Key? key}) : super(key: key);
  Set<Marker> myMarker = {};
  final Completer<GoogleMapController> _controller = Completer();
  Position? cl;
  var lat;
  var long;

  CameraPosition? _kGooglePlex;

  StreamSubscription<Position>? positionStream;

  GoogleMapController? gmc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Location",
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconBroken.Arrow___Left_2,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _kGooglePlex == null
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 550.0,
                  width: 400.0,
                  child: GoogleMap(
                    markers: myMarker,
                    myLocationEnabled: true,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void initState() {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      changeMaker(position.latitude, position.longitude);
    });
    getPermission();
    getLatAndLongUser();
    super.initState();
  }

  Future getPermission() async {
    bool? services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      AwesomeDialog(
          context: context,
          title: "Services",
          body: const Text(
            'Services Not Enabled',
          )).show();
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    print(
      "=============================",
    );
    print(per);
    print(
      "=============================",
    );
    return per;
  }

  Future<void> getLatAndLongUser() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl!.latitude;
    long = cl!.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(
        lat,
        long,
      ),
      zoom: 14.4746,
    );

    // myMarker.add(
    //   Marker(
    //     markerId: MarkerId("1"),
    //     infoWindow: InfoWindow(
    //       title: "Worker",
    //     ),
    //     position: LatLng(lat, long),
    //     icon: await BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/images/recycle.png"),
    //   ),
    // );

    if (mounted) setState(() {});
  }

  changeMaker(
    var newLat,
    var newLong,
  ) async {
    //myMarker.remove(Marker(markerId: MarkerId("1")));
    myMarker.add(Marker(
      markerId: const MarkerId(
        "1",
      ),
      position: LatLng(
        newLat,
        newLong,
      ),
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/images/recycle.png",
      ),
    ));
    //gmc!.animateCamera(CameraUpdate.newLatLng(LatLng(newLat, newLong)));
    // setState(() {});
  }
}
