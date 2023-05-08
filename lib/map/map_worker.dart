// ignore_for_file: avoid_print
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waste_app/shared/constants.dart';
import '../screens/worker_screen.dart';
import '../shared/icon_broken.dart';
import 'basket_list_view.dart';
import 'constants.dart';

//ignore: must_be_immutable
class MapWorkerWasteManagementSystem extends StatefulWidget {
  const MapWorkerWasteManagementSystem({Key? key}) : super(key: key);

  @override
  State<MapWorkerWasteManagementSystem> createState() =>
      _MapWorkerWasteManagementSystem();
}

class _MapWorkerWasteManagementSystem
    extends State<MapWorkerWasteManagementSystem> {
  @override
  void initState() {
    getPermission();
    positionStream = Geolocator.getPositionStream().listen(
      (
        Position position,
      ) {
        changeMaker(
          position.latitude,
          position.longitude,
        );
        getMarkerData();
        getPolyline(
          position.latitude,
          position.longitude,
        );
      },
    );
    getLatAndLongWorker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Baskets Map',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const WorkerScreen(),
              ),
              (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(
            IconBroken.Arrow___Left_2,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      "Baskets",
                    ),
                    titlePadding: const EdgeInsets.all(
                      20,
                    ),
                    // content: displayNotification(),
                    contentPadding: const EdgeInsets.all(
                      20,
                    ),
                    contentTextStyle: const TextStyle(
                      color: defaultColor,
                    ),
                    titleTextStyle: const TextStyle(
                      color: Colors.deepPurple,
                    ),
                    backgroundColor: Colors.grey[300],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const BasketListView();
                  },
                ),
              );
            },
            icon: const Icon(
              IconBroken.Edit,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: defaultColor,
      ),
      body: Stack(
        children: [
          retSensor(),
          // queryBasketsInfo(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {},
                  onSubmit: (value) async {},
                  onTap: () {},
                  label: 'Location',
                  hint: 'Move Basket To New Location',
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Location Must Not Be Empty';
                    }
                    return null;
                  },
                  prefix: Icons.location_on,
                ),
              ),
              kGooglePlex == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: SizedBox(
                        height: 600.0,
                        width: 400.0,
                        child: GoogleMap(
                          markers: Set<Marker>.of(markers.values),
                          polylines: Set<Polyline>.of(polylines.values),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          tiltGesturesEnabled: true,
                          compassEnabled: true,
                          trafficEnabled: true,
                          scrollGesturesEnabled: true,
                          zoomGesturesEnabled: true,
                          mapType: MapType.normal,
                          initialCameraPosition: kGooglePlex!,
                          onMapCreated: (GoogleMapController controller) {
                            controllerMap.complete(controller);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await addNewBasket(
            new_id,
            distance,
            0,
          );
        },
        backgroundColor: defaultColor.withOpacity(
          0.5,
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // End Polyline

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
    print("=============================");
    print(per);
    print("=============================");
    return per;
  }

  Future<void> getLatAndLongWorker() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl!.latitude;
    long = cl!.longitude;
    kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 9.4746,
    );

    if (mounted) setState(() {});
  }

  changeMaker(
    var newLat,
    var newLong,
  ) async {
    //myMarker.remove(Marker(markerId: MarkerId("1")));
    const markerId = MarkerId(
      "worker",
    );
    final marker = Marker(
      markerId: markerId,
      position: LatLng(
        newLat,
        newLong,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueOrange,
      ),
    );

    // await changeBasketIconState();
    gmc?.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          newLat,
          newLong,
        ),
      ),
    );
    if (mounted) {
      setState(() {
        markers[markerId] = marker;
      });
    }
  }

  addPolyLine(specifyId) {
    PolylineId id1 = PolylineId(
      specifyId,
    );
    Polyline polyline1 = Polyline(
      width: 4,
      polylineId: id1,
      color: Colors.deepPurple,
      points: polylineCoordinates,
    );

    if (mounted) {
      setState(() {
        polylines[id1] = polyline1;
      });
    }
  }

  initPolyline(
    var newLat,
    var newLong,
    specify,
    specifyId,
  ) async {
    // Polyline From Worker To ......
    polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(
          newLat,
          newLong,
        ), // Start Polyline
        PointLatLng(
          specify['lat'],
          specify['lon'],
        ), //30.415010, 31.565889  // End Polyline
        travelMode: TravelMode.driving,
        wayPoints: [
          PolylineWayPoint(
            location: "From Worker To .....",
          ),
        ]);
    // if (result1.points.isNotEmpty) {
    //   result1.points.forEach((PointLatLng point) {
    polylineCoordinates.add(
      LatLng(
        newLat,
        newLong,
      ),
    ); // Start Polyline
    polylineCoordinates.add(
      LatLng(
        specify['lat'],
        specify['lon'],
      ),
    ); // End Polyline
    // }
    // );
    // }

    // calc distance
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance = calculateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    print(totalDistance);

    if (mounted) {
      setState(() {
        distances[specifyId] = totalDistance;
      });
    }
    addPolyLine(specifyId);
  }

  getPolyline(
    newLat,
    newLong,
  ) {
    if(mounted) {
      setState(
      () {
        FirebaseFirestore.instance.collection('baskets').get().then(
          (value) {
            if (value.docs.isNotEmpty) {
              for (int i = 0; i < value.docs.length; i++) {
                initPolyline(
                  newLat,
                  newLong,
                  value.docs[i].data(),
                  value.docs[i].id.toString(),
                );
              }
            }
          },
        );
      },
    );
    }
  }

  Future<void> addNewBasket(id, distance, st) async {
    cl = await Geolocator.getCurrentPosition().then(
      (value) => value,
    );
    lat = cl!.latitude;
    long = cl!.longitude;
    var newPosition = LatLng(lat, long);
    gmc?.animateCamera(
      CameraUpdate.newLatLngZoom(
        newPosition,
        15,
      ),
    );

    basket.add({
      'Id': new_id,
      'height': 20,
      'lat': lat,
      'lon': long,
      'radius': 14,
    }).then((DocumentReference doc) {
      print('My Document Id : ${doc.id}');
    });

    final marker = Marker(
      markerId: MarkerId(
        new_id.toString(),
      ),
      infoWindow: InfoWindow(
        title: "Total Distance: ${distance.toStringAsFixed(
          2,
        )} KM",
        snippet: 'h = 26 CM,r = 11 CM,Volume = 9,878.44 CM^2',
      ),
      position: newPosition,
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/images/Empty.png",
      ),
    );

    if (mounted) {
      setState(
        () {
          markers[MarkerId(
            new_id.toString(),
          )] = marker;
        },
      );
    }
  }

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(
      markerIdVal,
    );
    final marker = Marker(
      markerId: markerId,
      position: LatLng(
        specify['lat'],
        specify['lon'],
      ),
      infoWindow: InfoWindow(
        title: ' Id : ${specify['Id']}',
        snippet: 'Distance : ${distances[specifyId]?.toStringAsFixed(2)} KM',
      ),
      icon: (de == 0)
          ? await BitmapDescriptor.fromAssetImage(
              ImageConfiguration.empty,
              "assets/images/Empty.png",
            )
          : (de == 1)
              ? await BitmapDescriptor.fromAssetImage(
                  ImageConfiguration.empty,
                  "assets/images/middle.png",
                )
              : await BitmapDescriptor.fromAssetImage(
                  ImageConfiguration.empty,
                  "assets/images/Full.png",
                ),
    );
    setState(
      () {
        markers[markerId] = marker;
      },
    );
  }

  void getMarkerData() {
    if(mounted) {
      setState(
      () {
        FirebaseFirestore.instance.collection('baskets').get().then(
          (value) {
            if (value.docs.isNotEmpty) {
              new_id = 1;
              for (int i = 0; i < value.docs.length; i++) {
                initMarker(value.docs[i].data(), value.docs[i].id.toString());
                new_id++;
              }
            }
          },
        );
      },
    );
    }
  }

  var not;
  var col;
  bool full_3 = false;
  bool full_2 = false;

// Widget displayNotification() {
//   if (state1 == true && state2 == true && state3 == true) {
//     full_3 = true;
//   } else if ((state1 == true && state2 == true) ||
//       (state1 == true && state3 == true) ||
//       (state2 == true && state3 == true)) {
//     full_2 = true;
//   }
//   var min_distance = totalDistance1;

//   if (totalDistance2 < min_distance) {
//     min_distance = totalDistance2;
//   } else if (totalDistance3 < min_distance) {
//     min_distance = totalDistance3;
//   }
//   if (full_3 == true) {
//     if (totalDistance1 == min_distance) {
//       not = Text("Go To Basket 1");
//     } else if (totalDistance2 == min_distance) {
//       not = Text("Go To Basket 2");
//     } else {
//       not = Text("Go To Basket 3");
//     }
//   } else if (full_2 == true) {
//     if (state1 == false) {
//       if (totalDistance2 == min_distance) {
//         not = Text("Go To Basket 2");
//       } else {
//         not = Text("Go To Basket 3");
//       }
//     } else if (state2 == false) {
//       if (totalDistance1 == min_distance) {
//         not = Text("Go To Basket 1");
//       } else {
//         not = Text("Go To Basket 3");
//       }
//     } else {
//       if (totalDistance1 == min_distance) {
//         not = Text("Go To Basket 1");
//       } else {
//         not = Text("Go To Basket 2");
//       }
//     }
//   } else {
//     if (state1 == true) {
//       not = Text("Go To Basket 1");
//     } else if (state2 == true) {
//       not = Text("Go To Basket 2");
//     } else if (state3 == true) {
//       not = Text("Go To Basket 3");
//     } else {
//       not = Text("NO Basket FULL");
//     }
//     // not = Text("NO Basket FULL ");
//   }
//   return not;
// }
}
// AIzaSyDtdWNgEPfUGq9OYBJtO5EzNcP000t9Oao
