// TextDropdownFormField(
//   validator: (dynamic value) => value == null
//       ? 'Please select your location'
//       : null,
//   controller: paymentController,
//   options: governorate,
//   decoration: InputDecoration(
//     enabledBorder: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Colors.grey,
//         width: 1.5,
//       ),
//       borderRadius: BorderRadius.circular(
//         25.0,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Colors.grey,
//         width: 1.5,
//       ),
//       borderRadius: BorderRadius.circular(
//         25.0,
//       ),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Colors.red,
//         width: 1.5,
//       ),
//       borderRadius: BorderRadius.circular(
//         25.0,
//       ),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Colors.red,
//         width: 1.5,
//       ),
//       borderRadius: BorderRadius.circular(
//         25.0,
//       ),
//     ),
//     prefixIcon: const Icon(
//       IconBroken.Location,
//     ),
//     suffixIcon: const Icon(
//       Icons.arrow_drop_down,
//     ),
//   ),
// ),
// const SizedBox(
//   height: 15.0,
// ),
var x = 1;
// Padding(
//   padding: const EdgeInsetsDirectional.only(
//     start: 10,
//   ),
//   child: SwitchListTile(
//     inactiveTrackColor: Colors.grey[700],
//     activeTrackColor: Colors.grey,
//     activeColor: defaultColor.withOpacity(
//       .7,
//     ),
//     title: const Text(
//       'Dark Mode',
//       style: TextStyle(
//         fontSize: 20,
//         color: Colors.white,
//       ),
//     ),
//     value: lights,
//     onChanged: (bool value) {
//       setState(
//         () {
//           lights = value;
//         },
//       );
//     },
//   ),
// ),
// buildMenuItem(
//   text: 'Language',
//   text2: 'Language of App',
//   icon: Icons.language,
//   onClicked: () {},
// ),
var xr = 1;
// // ignore_for_file: avoid_print
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:waste_app/screens/worker_screen.dart';
// import '../controller/app_cubit/cubit.dart';
// import '../shared/componentes.dart';
// import '../shared/constants.dart';
// import '../controller/login_cubit/cubit.dart';
// import '../controller/login_cubit/states.dart';
//
// //ignore: must_be_immutable
// class WorkerLoginScreen extends StatelessWidget {
//   var formKey = GlobalKey<FormState>();
//
//   WorkerLoginScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var emailController = TextEditingController();
//     var passwordController = TextEditingController();
//
//     return BlocProvider(
//       create: (BuildContext context) => LoginCubit(),
//       child: BlocConsumer<LoginCubit, LoginStates>(
//         listener: (context, state) {
//           if (state is LoginErrorStates) {
//             showToast(
//               text: state.error,
//               state: ToastState.ERROR,
//             );
//           }
//           if (state is LoginSuccessStates) {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const WorkerScreen(),
//               ),
//               (Route<dynamic> route) => false,
//             );
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: defaultColor,
//               actions: [
//                 backBottom(context: context),
//               ],
//               iconTheme: const IconThemeData(
//                 color: Colors.white,
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Opacity(
//                         opacity: 0.5,
//                         child: ClipPath(
//                           clipper: WaveClipper(),
//                           child: Container(
//                             color: defaultColor,
//                             height: 200,
//                           ),
//                         ),
//                       ),
//                       ClipPath(
//                         clipper: WaveClipper(),
//                         child: Container(
//                           color: defaultColor,
//                           height: 170,
//                           alignment: Alignment.center,
//                           child: const Text(
//                             'Login for Worker!',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Form(
//                         key: formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'LOGIN',
//                               style: TextStyle(
//                                   fontSize: 35.0,
//                                   fontWeight: FontWeight.w900,
//                                   color: defaultColor),
//                             ),
//                             const SizedBox(
//                               height: 7.0,
//                             ),
//                             defaultTextFormField(
//                               controller: emailController,
//                               type: TextInputType.emailAddress,
//                               validate: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please enter your email address!';
//                                 }
//                                 return null;
//                               },
//                               onSubmit: (String? value) {
//                                 return null;
//                               },
//                               label: 'Email Address',
//                               prefix: Icons.email_outlined,
//                             ),
//                             const SizedBox(
//                               height: 15.0,
//                             ),
//                             defaultTextFormField(
//                               controller: passwordController,
//                               type: TextInputType.visiblePassword,
//                               validate: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please enter your Password!';
//                                 }
//                                 return null;
//                               },
//                               onSubmit: (value) {},
//                               label: 'Password',
//                               prefix: Icons.lock_outline,
//                               suffix: LoginCubit.get(context).suffix,
//                               isPassword: LoginCubit.get(context).isPassword,
//                               suffixPressed: () {
//                                 LoginCubit.get(context)
//                                     .changePasswordVisibility();
//                               },
//                             ),
//                             const SizedBox(
//                               height: 15.0,
//                             ),
//                             defaultClickedButton(
//                               contentWidget: state is LoginLoadingStates
//                                   ? const CupertinoActivityIndicator(
//                                       color: Colors.white,
//                                     )
//                                   : Text(
//                                       "LOGIN".toUpperCase(),
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                               minWidth: double.infinity,
//                               onTap: () async {
//                                 await LoginCubit.get(context).userLogin(
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                 );
//                                 await WasteAppCubit.get(context).getUserData();
//                               },
//                               padding: const EdgeInsets.all(
//                                 10,
//                               ),
//                               roundedRectangleBorder: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   25.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
var cv = 1;
// const List<String> governorate = [
//   'Alexandria',
//   'Aswan',
//   'Asyut',
//   'Beheira',
//   'Beni Suef ',
//   'Cairo',
//   'Dakahlia',
//   'Damietta',
//   'Fayyoum',
//   'Gharbiya',
//   'Giza',
//   'Helwan',
//   'Ismailia',
//   'Kafr El Sheikh',
//   'Luxor',
//   'Marsa Matrouh',
//   'Minya',
//   'Monofiya',
//   ' New Valley',
//   'North Sinai',
//   ' Port Said',
//   'Qalioubiya',
//   'Qena',
//   'Red Sea',
//   'Sharqiya',
//   'Sohag',
//   'South Sinai',
//   'Suez',
//   'Tanta',
// ];
var z = 2;
// File? profileImage;
// var picker = ImagePicker();
//
// Future<void> getProfileImage() async {
//   emit(GetProfileImageLoadingState());
//   final pickedFile = await picker.getImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//     profileImage = File(pickedFile.path);
//     emit(WasteAppProfileImageSuccessState());
//   } else {
//     print('No Image Selected!');
//     emit(WasteAppProfileImageErrorState());
//   }
// }
//
// Future<void> uploadProfileImage({
//   required String name,
//   required String phone,
//   required String location,
// }) async {
//   emit(WasteAppUserUpdateLoadingState());
//   firebase_storage.FirebaseStorage.instance
//       .ref()
//       .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
//       .putFile(profileImage!)
//       .then((value) {
//     value.ref.getDownloadURL().then((value) {
//       updateUser(
//         name: name,
//         phone: phone,
//         location: location,
//         profile: value,
//       );
//     }).catchError((error) {
//       emit(WasteAppUploadProfileImageSuccessState());
//     });
//   }).catchError((error) {
//     emit(WasteAppUploadProfileImageErrorState());
//   });
// }
// UserModel? userModel;
//
// Future<void> updateUser({
//   required String name,
//   required String phone,
//   required String location,
//   String? profile,
//   String? cover,
// }) async {
//   UserModel model1 = UserModel(
//     name: name,
//     phone: phone,
//     location: location,
//     image: profile ?? userModel!.image,
//     email: userModel!.email,
//     uId: userModel!.uId,
//   );
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(uId)
//       .update(model1.toMap())
//       .then((value) {
//     getUserData();
//   }).catchError((error) {
//     emit(WasteAppUserUpdateErrorState());
//   });
// }
var y = 2;
// floatingActionButton: FloatingActionButton(
// onPressed: () {
// log(WasteAppCubit.get(context).userModel!.name!);
// log(WasteAppCubit.get(context).userModel!.phone!);
// log(WasteAppCubit.get(context).userModel!.location!);
// log(WasteAppCubit.get(context).userModel!.email!);
// log(WasteAppCubit.get(context).userModel!.uId!);
// log(WasteAppCubit.get(context).userModel!.image!);
// },
// ),
var f = 2;
// void userRegister({
//   // required dynamic image,
//   required String email,
//   required String password,
//   required String name,
//   required String phone,
//   required String location,
// }) {
//   emit(RegisterLoadingStates());
//   FirebaseAuth.instance
//       .createUserWithEmailAndPassword(
//     email: email,
//     password: password,
//   )
//       .then((value) {
//     createUser(
//       // image: image,
//       email: email,
//       name: name,
//       uid: value.user!.uid,
//       phone: phone,
//       location: location,
//     );
//     emit(RegisterSuccessStates());
//   }).catchError((error) {
//     emit(RegisterErrorStates(error.toString()));
//   });
// }
var a = 2;
// void createUser({
//   required String email,
//   required String name,
//   required String password,
//   required String phone,
//   required String location,
// }) {
//   emit(CreateUserLoadingState());
//   UserModel model = UserModel(
//     name: name,
//     email: email,
//     password: password,
//     phone: phone,
//     location: location,
//   );
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(uid)
//       .set(model.toMap())
//       .then((value) {
//     emit(CreateUserSuccessStates());
//   }).catchError((error) {
//     emit(CreateUserErrorStates(error.toString()));
//   });
// }
var q = 2;
// ConditionalBuilder(
//   condition: state is! RegisterLoadingStates,
//   builder: (context) => defaultButton(
//     function: () {
//       if (formKey.currentState!.validate()) {
//         RegisterCubit.get(context).createUser(
//           name: nameController.text,
//           email: emailController.text,
//           password: passwordController.text,
//           phone: phoneController.text,
//           location: regionController.text,
//         );
//       }
//     },
//     text: 'Register',
//     isUpperCase: true,
//     background: defaultColor,
//   ),
//   fallback: (context) => const Center(
//     child: CircularProgressIndicator(),
//   ),
// ),
var m = 2;
// void userLogin({
//   required String email,
//   required String password,
// }) {
//   emit(LoginLoadingStates());
//   FirebaseAuth.instance
//       .signInWithEmailAndPassword(
//     email: email,
//     password: password,
//   )
//       .then((value) {
//     CacheHelper.saveCacheData(key: 'uid', val: value.user!.uid);
//     emit(LoginSuccessStates(value.user!.uid));
//   }).catchError((error) {
//     emit(LoginErrorStates(error.toString()));
//   });
// }
var l = 2;
// ConditionalBuilder(
//   condition: state is! LoginLoadingStates,
//   builder: (context) => defaultButton(
//     function: () {
//       if (formKey.currentState!.validate()) {
//         LoginCubit.get(context).userLogin(
//           email: emailController.text,
//           password: passwordController.text,
//         );
//       }
//     },
//     text: 'LOGIN',
//     isUpperCase: true,
//     background: defaultColor,
//   ),
//   fallback: (context) => const Center(
//     child: CircularProgressIndicator(),
//   ),
// ),
var d = 2;
// CacheHelper.saveDate(
// key: 'uid',
// value: state.uId,
// ).then((value) {
//
// });
var p = 2;
// var token = await FirebaseMessaging.instance.getToken();
//
// print('Token is ===>>>$token');
//
// FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// print('On Message');
// print('message ${message.data.toString()}');
// showToast(text: 'On Message', state: ToastState.SUCCESS);
// });
//
// FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// print('On Message Opened App');
// print('message ${message.data.toString()}');
// showToast(text: 'On Message Opened App', state: ToastState.SUCCESS);
// });
//
// FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
var o = 2;
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('On Background Message');
//   print('message ${message.data.toString()}');
//   showToast(text: 'On Background Message', state: ToastState.SUCCESS);
// }
var os = 2;
// floatingActionButton: FloatingActionButton(
// onPressed: () {
// logout(context);
// },
// ),
var oss = 2;
// void signOut(context) {
//   CacheHelper.removeData(
//     key: 'uid',
//   ).then((value) {
//     if (value) {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const StartPage(),
//         ),
//         (Route<dynamic> route) => false,
//       );
//     }
//   });
// }
var osa = 2;
// // ignore_for_file: avoid_print
// import 'dart:async';
// import 'dart:math';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:waste_app/screens/worker_screen.dart';
// import '../shared/icon_broken.dart';
//
// //ignore: must_be_immutable
// class MapWorkerWasteManagementSystem extends StatefulWidget {
//   const MapWorkerWasteManagementSystem({Key? key}) : super(key: key);
//
//   @override
//   State<MapWorkerWasteManagementSystem> createState() =>
//       _MapWorkerWasteManagementSystem();
// }
//
// class _MapWorkerWasteManagementSystem
//     extends State<MapWorkerWasteManagementSystem> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   Set<Marker> myMarker = {};
//
//   setMarkerCustomImage() async {
//     myMarker.add(
//       Marker(
//         markerId: const MarkerId(
//           "2",
//         ),
//         infoWindow: const InfoWindow(
//           title: "Zigzag",
//         ),
//         position: const LatLng(
//           30.415010,
//           31.565889,
//         ),
//         icon: await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration.empty,
//           "assets/images/Empty.png",
//         ),
//         // onTap: (){
//         //   displayDistance1();
//         // },
//       ),
//     );
//     myMarker.add(
//       Marker(
//         markerId: const MarkerId(
//           "3",
//         ),
//         infoWindow: const InfoWindow(
//           title: "Mit Ghamr",
//         ),
//         position: const LatLng(
//           30.713261,
//           31.259550,
//         ),
//         icon: await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration.empty,
//           "assets/images/Full.png",
//         ),
//         // onTap: (){
//         //   displayDistance2();
//         // },
//       ),
//     );
//     myMarker.add(
//       Marker(
//         markerId: const MarkerId(
//           "4",
//         ),
//         infoWindow: const InfoWindow(
//           title: "Mansoura",
//         ),
//         position: const LatLng(
//           31.040949,
//           31.378469,
//         ),
//         icon: await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration.empty,
//           "assets/images/middle.png",
//         ),
//         // onTap: (){
//         //   displayDistance2();
//         // },
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     setMarkerCustomImage();
//     positionStream = Geolocator.getPositionStream().listen((Position position) {
//       changeMaker(
//         position.latitude,
//         position.longitude,
//       );
//       getPolyline(
//         position.latitude,
//         position.longitude,
//       );
//     });
//     getPermission();
//     getLatAndLongWorker();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Map',
//         ),
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text(
//                       "Baskets",
//                     ),
//                     titlePadding: const EdgeInsets.all(
//                       20,
//                     ),
//                     content: displayNotification(),
//                     contentPadding: const EdgeInsets.all(
//                       20,
//                     ),
//                     contentTextStyle: const TextStyle(
//                       color: Colors.green,
//                     ),
//                     titleTextStyle: const TextStyle(
//                       color: Colors.deepPurple,
//                     ),
//                     backgroundColor: Colors.grey[300],
//                   );
//                 },
//               );
//             },
//             icon: const Icon(
//               Icons.notifications_active,
//             ),
//           ),
//         ],
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const WorkerScreen(),
//               ),
//               (route) => false,
//             );
//           },
//           icon: const Icon(
//             IconBroken.Arrow___Left_2,
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               _kGooglePlex == null
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : SizedBox(
//                       height: 600.0,
//                       width: 400.0,
//                       child: GoogleMap(
//                         markers: myMarker,
//                         polylines: Set<Polyline>.of(
//                           polylines.values,
//                         ),
//                         myLocationEnabled: true,
//                         tiltGesturesEnabled: true,
//                         compassEnabled: true,
//                         scrollGesturesEnabled: true,
//                         zoomGesturesEnabled: true,
//                         mapType: MapType.normal,
//                         initialCameraPosition: _kGooglePlex!,
//                         onMapCreated: (GoogleMapController controller) {
//                           _controller.complete(controller);
//                         },
//                       ),
//                     ),
//             ],
//           ),
//           Positioned(
//               bottom: 200,
//               right: 0,
//               child: Card(
//                 child: Container(
//                   padding: const EdgeInsets.all(
//                     10,
//                   ),
//                   child: Text(
//                     "Total Distance: " +
//                         distance1.toStringAsFixed(
//                           2,
//                         ) +
//                         " KM",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               )),
//           Positioned(
//               bottom: 460,
//               left: 0,
//               child: Card(
//                 child: Container(
//                   padding: const EdgeInsets.all(
//                     10,
//                   ),
//                   child: Text(
//                     "Total Distance: " +
//                         distance2.toStringAsFixed(
//                           2,
//                         ) +
//                         " KM",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               )),
//           Positioned(
//               bottom: 580,
//               right: 20,
//               child: Card(
//                 child: Container(
//                   padding: const EdgeInsets.all(
//                     10,
//                   ),
//                   child: Text(
//                     "Total Distance: " +
//                         distance3.toStringAsFixed(
//                           2,
//                         ) +
//                         " KM",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
//
//   Position? cl;
//   var lat;
//   var long;
//   CameraPosition? _kGooglePlex;
//   StreamSubscription<Position>? positionStream;
//   GoogleMapController? gmc;
//
//   // Start Polyline
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPiKey = "AIzaSyDtdWNgEPfUGq9OYBJtO5EzNcP000t9Oao";
//
//   double distance1 = 0.0;
//   double distance2 = 0.0;
//   double distance3 = 0.0;
//   double totalDistance1 = 0.0;
//   double totalDistance2 = 0.0;
//   double totalDistance3 = 0.0;
//   var state1 = false;
//   var state2 = false;
//   var state3 = false;
//
//   // End Polyline
//
//   Future getPermission() async {
//     bool? services;
//     LocationPermission per;
//     services = await Geolocator.isLocationServiceEnabled();
//     if (services == false) {
//       AwesomeDialog(
//         context: context,
//         title: "Services",
//         body: const Text(
//           'Services Not Enabled',
//         ),
//       ).show();
//     }
//     per = await Geolocator.checkPermission();
//     if (per == LocationPermission.denied) {
//       per = await Geolocator.requestPermission();
//     }
//     print(
//       "=============================",
//     );
//     print(per);
//     print(
//       "=============================",
//     );
//     return per;
//   }
//
//   Future<void> getLatAndLongWorker() async {
//     cl = await Geolocator.getCurrentPosition().then((value) => value);
//     lat = cl!.latitude;
//     long = cl!.longitude;
//     _kGooglePlex = CameraPosition(
//       target: LatLng(
//         lat,
//         long,
//       ),
//       zoom: 9.4746,
//     );
//
//     // myMarker.add(
//     //   Marker(
//     //     markerId: MarkerId("1"),
//     //     infoWindow: InfoWindow(
//     //       title: "Worker",
//     //     ),
//     //     position: LatLng(lat, long),
//     //     icon: await BitmapDescriptor.fromAssetImage(
//     //         ImageConfiguration.empty, "assets/images/recycle.png"),
//     //   ),
//     // );
//
//     if (mounted) setState(() {});
//   }
//
//   changeMaker(
//     var newLat,
//     var newLong,
//   ) async {
//     //myMarker.remove(Marker(markerId: MarkerId("1")));
//     myMarker.add(Marker(
//       markerId: const MarkerId(
//         "1",
//       ),
//       position: LatLng(
//         newLat,
//         newLong,
//       ),
//       icon: await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty,
//         "assets/images/recycle.png",
//       ),
//     ));
//     //gmc!.animateCamera(CameraUpdate.newLatLng(LatLng(newLat, newLong)));
//     if (mounted) setState(() {});
//   }
//
//   addPolyLine() {
//     PolylineId id1 = const PolylineId(
//       "poly1",
//     );
//     Polyline polyline1 = Polyline(
//       width: 4,
//       polylineId: id1,
//       color: Colors.deepPurple,
//       points: polylineCoordinates,
//     );
//     polylines[id1] = polyline1;
//
//     PolylineId id2 = const PolylineId(
//       "poly2",
//     );
//     Polyline polyline2 = Polyline(
//       width: 4,
//       polylineId: id2,
//       color: Colors.deepPurple,
//       points: polylineCoordinates,
//     );
//     polylines[id2] = polyline2;
//
//     PolylineId id3 = const PolylineId(
//       "poly3",
//     );
//     Polyline polyline3 = Polyline(
//       width: 4,
//       polylineId: id3,
//       color: Colors.deepPurple,
//       points: polylineCoordinates,
//     );
//     polylines[id3] = polyline3;
//     if (mounted) setState(() {});
//   }
//
//   getPolyline(
//     var newLat,
//     var newLong,
//   ) async {
//     state1 = false;
//     // Polyline From Worker To Belbis
//     PolylineResult result1 = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(
//         newLat,
//         newLong,
//       ), // Start Polyline
//       const PointLatLng(
//         30.415010,
//         31.565889,
//       ), // End Polyline
//       travelMode: TravelMode.driving,
//       wayPoints: [
//         PolylineWayPoint(
//           location: "From Worker To Belbis",
//         ),
//       ],
//     );
//     // if (result.points.isNotEmpty) {
//     //   result.points.forEach((PointLatLng point) {
//     polylineCoordinates.add(
//       LatLng(
//         newLat,
//         newLong,
//       ),
//     ); // Start Polyline
//     polylineCoordinates.add(
//       const LatLng(
//         30.415010,
//         31.565889,
//       ),
//     ); // End Polyline
//     // });
//     // }
//
//     //polylineCoordinates is the List of longitude and latitude.
//
//     // calc distance
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance1 = calculateDistance(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }
//     print(totalDistance1);
//
//     state2 = false;
//     // Polyline From Worker To Mit Ghamr
//     PolylineResult result2 = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(
//         newLat,
//         newLong,
//       ), // Start Polyline
//       const PointLatLng(
//         30.713261,
//         31.259550,
//       ), // End Polyline
//       travelMode: TravelMode.driving,
//       wayPoints: [
//         PolylineWayPoint(
//           location: "From Worker To Mit Ghamr",
//         ),
//       ],
//     );
//     // if (result.points.isNotEmpty) {
//     //   result.points.forEach((PointLatLng point) {
//     polylineCoordinates.add(LatLng(newLat, newLong)); // Start Polyline
//     polylineCoordinates.add(
//       const LatLng(
//         30.713261,
//         31.259550,
//       ),
//     ); // End Polyline
//     // });
//     // }
//
//     //polulineCoordinates is the List of longitute and latidtude.
//
//     // calc distance
//
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance2 = calculateDistance(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }
//     print(totalDistance2);
//
//     state3 = true;
//     // Polyline From Worker To Mansoura
//     PolylineResult result3 = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(
//         newLat,
//         newLong,
//       ), // Start Polyline
//       const PointLatLng(
//         31.040949,
//         31.378469,
//       ), // End Polyline
//       travelMode: TravelMode.driving,
//       wayPoints: [
//         PolylineWayPoint(
//           location: "From Worker To Mansoura",
//         ),
//       ],
//     );
//     // if (result.points.isNotEmpty) {
//     //   result.points.forEach((PointLatLng point) {
//     polylineCoordinates.add(
//       LatLng(
//         newLat,
//         newLong,
//       ),
//     ); // Start Polyline
//     polylineCoordinates.add(
//       const LatLng(
//         31.040949,
//         31.378469,
//       ),
//     ); // End Polyline
//     // });
//     // }
//
//     //polulineCoordinates is the List of longitute and latidtude.
//
//     // calc distance
//
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance3 = calculateDistance(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }
//     print(totalDistance3);
//
//     if (mounted) {
//       setState(() {
//         distance1 = totalDistance1;
//         distance2 = totalDistance2;
//         distance3 = totalDistance3;
//       });
//     }
//     addPolyLine();
//   }
//
//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var a = 0.5 -
//         cos((lat2 - lat1) * p) / 2 +
//         cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }
//
//   var not;
//   var col;
//   bool full_3 = false;
//   bool full_2 = false;
//
//   Widget displayNotification() {
//     if (state1 == true && state2 == true && state3 == true) {
//       full_3 = true;
//     } else if ((state1 == true && state2 == true) ||
//         (state1 == true && state3 == true) ||
//         (state2 == true && state3 == true)) {
//       full_2 = true;
//     }
//
//     if (full_3 == true) {
//       var min_distance = totalDistance1;
//
//       if (totalDistance2 < min_distance) {
//         min_distance = totalDistance2;
//       } else if (totalDistance3 < min_distance) {
//         min_distance = totalDistance3;
//       }
//       if (totalDistance1 == min_distance) {
//         not = const Text(
//           "Go To Basket 1",
//         );
//       } else if (totalDistance2 == min_distance) {
//         not = const Text(
//           "Go To Basket 2",
//         );
//       } else {
//         not = const Text(
//           "Go To Basket 3",
//         );
//       }
//     } else if (full_2 == true) {
//       if (state1 == false) {
//         if (totalDistance2 < totalDistance3) {
//           not = const Text(
//             "Go To Basket 2",
//           );
//         } else {
//           not = const Text(
//             "Go To Basket 3",
//           );
//         }
//       } else if (state2 == false) {
//         if (totalDistance1 < totalDistance3) {
//           not = const Text(
//             "Go To Basket 1",
//           );
//         } else {
//           not = const Text(
//             "Go To Basket 3",
//           );
//         }
//       } else {
//         if (totalDistance1 < totalDistance2) {
//           not = const Text(
//             "Go To Basket 1",
//           );
//         } else {
//           not = const Text(
//             "Go To Basket 2",
//           );
//         }
//       }
//     } else {
//       if (state1 == true) {
//         not = const Text(
//           "Go To Basket 1",
//         );
//       } else if (state2 == true) {
//         not = const Text(
//           "Go To Basket 2",
//         );
//       } else if (state3 == true) {
//         not = const Text(
//           "Go To Basket 3",
//         );
//       } else {
//         not = const Text(
//           "NO Basket FULL",
//         );
//       }
//       // not = Text("NO Basket FULL ");
//     }
//     return not;
//   }
// }
// // AIzaSyDtdWNgEPfUGq9OYBJtO5EzNcP000t9Oao
var posa = 2;
// GestureDetector(
// child: Icon(
// Icons.more_vert,
// color: defaultColor.withOpacity(0.4),
// size: 30,
// ),
// onTap: () {
// if (WasteAppCubit.get(context).posts[index].uId ==
// WasteAppCubit.get(context).userModel!.uId) {
// showMenu(
// context: context,
// elevation: 1,
// position: const RelativeRect.fromLTRB(
// 25.0,
// 25.0,
// 0.0,
// 0.0,
// ),
// items: [
// PopupMenuItem(
// onTap: () {
// WasteAppCubit.get(context).deletePost(
// postMakerID: model.uId!,
// postID: uId,
// );
// },
// child: const Text('delete post'),
// ),
// ],
// );
// }
// },
// ),
var oscva = 2;
// RegisterCubit.get(context)
// .userImageFile !=
// null
// ? Image(
// image: FileImage(
// RegisterCubit.get(context)
// .userImageFile!),
// )
// : Image.asset(
// 'images/user_1.png',
// ),
var kjhjfk = 1;
// Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadiusDirectional.circular(
//       15.0,
//     ),
//   ),
//   clipBehavior: Clip.antiAliasWithSaveLayer,
//   child: QrImage(
//     data: "waste_app_7_14",
//     version: 4,
//     size: 350.0,
//     backgroundColor: Colors.white,
//   ),
// ),
var kjhvjfk = 1;
// else if (RegisterCubit.get(context)
// .userImageFile ==
// null) {
// RegisterCubit.get(context).userImageFile =
// const AssetImage(
// 'images/user_1.png',
// ) as File?;
// showToast(
// text: "choose an Image and try again!",
// state: ToastState.ERROR,
// );
// }
var oscsva = 2;
// // ignore_for_file: avoid_print
// import 'dart:async';
// import 'dart:math';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// //ignore: must_be_immutable
// class MapUserWasteManagementSystem extends StatefulWidget {
//   const MapUserWasteManagementSystem({Key? key}) : super(key: key);
//
//   @override
//   State<MapUserWasteManagementSystem> createState() =>
//       _MapUserWasteManagementSystem();
// }
//
// class _MapUserWasteManagementSystem
//     extends State<MapUserWasteManagementSystem> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   Set<Marker> myMarker = {};
//
//   setMarkerCustomImage() async {
//     myMarker.add(
//       Marker(
//         markerId: const MarkerId("2"),
//         infoWindow: const InfoWindow(
//           title: "ElMohaphza Street",
//         ),
//         position: const LatLng(30.591438, 31.501723),
//         icon: await BitmapDescriptor.fromAssetImage(
//             ImageConfiguration.empty, "assets/images/Empty.png"),
//         // onTap: (){
//         //   displayDistance1();
//         // },
//       ),
//     );
//     myMarker.add(
//       Marker(
//         markerId: const MarkerId(
//           "3",
//         ),
//         infoWindow: const InfoWindow(
//           title: "Kaphre Gnedy Bahnabay",
//         ),
//         position: const LatLng(
//           30.647712,
//           31.482197,
//         ),
//         icon: await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration.empty,
//           "assets/images/Full.png",
//         ),
//         // onTap: (){
//         //   displayDistance2();
//         // },
//       ),
//     );
//     myMarker.add(
//       Marker(
//         markerId: const MarkerId(
//           "4",
//         ),
//         infoWindow: const InfoWindow(
//           title: "Om Ramad ElZagazig",
//         ),
//         position: const LatLng(30.640697, 31.426958),
//         icon: await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration.empty,
//           "assets/images/middle.png",
//         ),
//         // onTap: (){
//         //   displayDistance2();
//         // },
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     setMarkerCustomImage();
//     positionStream = Geolocator.getPositionStream().listen((Position position) {
//       getPolyline(
//         position.latitude,
//         position.longitude,
//       );
//       changeMaker(
//         position.latitude,
//         position.longitude,
//       );
//     });
//     getPermission();
//     getLatAndLongUser();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text(
//       //     'MapWasteManagementSystem',
//       //   ),
//       //   backgroundColor: Colors.green,
//       // ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _kGooglePlex == null
//                         ? const Center(child: CircularProgressIndicator())
//                         : SizedBox(
//                             height: 550.0,
//                             width: 400.0,
//                             child: GoogleMap(
//                               markers: myMarker,
//                               polylines: Set<Polyline>.of(polylines.values),
//                               myLocationEnabled: true,
//                               tiltGesturesEnabled: true,
//                               compassEnabled: true,
//                               scrollGesturesEnabled: true,
//                               zoomGesturesEnabled: true,
//                               mapType: MapType.normal,
//                               initialCameraPosition: _kGooglePlex!,
//                               onMapCreated: (GoogleMapController controller) {
//                                 _controller.complete(controller);
//                               },
//                             ),
//                           ),
//                   ],
//                 ),
//                 Positioned(
//                     bottom: 160,
//                     right: 0,
//                     child: Card(
//                       child: Container(
//                         padding: const EdgeInsets.all(
//                           10,
//                         ),
//                         child: Text(
//                           "Total Distance: " +
//                               distance1.toStringAsFixed(
//                                 2,
//                               ) +
//                               "KM",
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     )),
//                 Positioned(
//                     bottom: 370,
//                     right: 0,
//                     child: Card(
//                       child: Container(
//                         padding: const EdgeInsets.all(
//                           10,
//                         ),
//                         child: Text(
//                           "Total Distance: " +
//                               distance2.toStringAsFixed(
//                                 2,
//                               ) +
//                               "KM",
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     )),
//                 Positioned(
//                     bottom: 350,
//                     left: 0,
//                     child: Card(
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         child: Text(
//                           "Total Distance: " +
//                               distance3.toStringAsFixed(2) +
//                               "KM",
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     )),
//               ],
//             ),
//             Row(
//               children: const [
//                 ImageIcon(
//                   AssetImage(
//                     "assets/images/Empty.png",
//                   ),
//                   color: Colors.green,
//                 ),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text(
//                   "Basket -> EMPTY ",
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: const [
//                 ImageIcon(
//                   AssetImage(
//                     "assets/images/Full.png",
//                   ),
//                   color: Colors.red,
//                 ),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text(
//                   "Basket -> FULL ",
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: const [
//                 ImageIcon(
//                   AssetImage(
//                     "assets/images/middle.png",
//                   ),
//                   color: Colors.yellow,
//                 ),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text(
//                   "Basket -> MIDDLE(NOT FULL) ",
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Position? cl;
//   var lat;
//   var long;
//   CameraPosition? _kGooglePlex;
//   StreamSubscription<Position>? positionStream;
//   GoogleMapController? gmc;
//
//   // Start Polyline
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPiKey = "AIzaSyDtdWNgEPfUGq9OYBJtO5EzNcP000t9Oao";
//
//   double distance1 = 0.0;
//   double distance2 = 0.0;
//   double distance3 = 0.0;
//   double totalDistance1 = 0;
//   double totalDistance2 = 0;
//   double totalDistance3 = 0;
//
//   // End Polyline
//
//   Future getPermission() async {
//     bool? services;
//     LocationPermission per;
//     services = await Geolocator.isLocationServiceEnabled();
//     if (services == false) {
//       AwesomeDialog(
//           context: context,
//           title: "Services",
//           body: const Text(
//             'Services Not Enabled',
//           )).show();
//     }
//     per = await Geolocator.checkPermission();
//     if (per == LocationPermission.denied) {
//       per = await Geolocator.requestPermission();
//     }
//     print(
//       "=============================",
//     );
//     print(per);
//     print(
//       "=============================",
//     );
//     return per;
//   }
//
//   Future<void> getLatAndLongUser() async {
//     cl = await Geolocator.getCurrentPosition().then((value) => value);
//     lat = cl!.latitude;
//     long = cl!.longitude;
//     _kGooglePlex = CameraPosition(
//       target: LatLng(lat, long),
//       zoom: 11.4746,
//     );
//
//     // myMarker.add(
//     //   Marker(
//     //     markerId: MarkerId("1"),
//     //     infoWindow: InfoWindow(
//     //       title: "Worker",
//     //     ),
//     //     position: LatLng(lat, long),
//     //     icon: await BitmapDescriptor.fromAssetImage(
//     //         ImageConfiguration.empty, "assets/images/recycle.png"),
//     //   ),
//     // );
//
//     if (mounted) setState(() {});
//   }
//
//   changeMaker(var newLat, var newLong) async {
//     //myMarker.remove(Marker(markerId: MarkerId("1")));
//     myMarker.add(Marker(
//       markerId: const MarkerId("1"),
//       position: LatLng(newLat, newLong),
//       icon: await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty,
//         "assets/images/recycle.png",
//       ),
//     ));
//     //gmc!.animateCamera(CameraUpdate.newLatLng(LatLng(newLat, newLong)));
//     // setState(() {});
//   }
//
//   addPolyLine() {
//     PolylineId id1 = const PolylineId(
//       "poly1",
//     );
//     Polyline polyline1 = Polyline(
//       width: 4,
//       polylineId: id1,
//       color: Colors.deepPurple,
//       points: polylineCoordinates,
//     );
//     polylines[id1] = polyline1;
//
//     PolylineId id2 = const PolylineId(
//       "poly2",
//     );
//     Polyline polyline2 = Polyline(
//       width: 4,
//       polylineId: id2,
//       color: Colors.deepPurple,
//       points: polylineCoordinates,
//     );
//     polylines[id2] = polyline2;
//
//     PolylineId id3 = const PolylineId(
//       "poly3",
//     );
//     Polyline polyline3 = Polyline(
//       width: 4,
//       polylineId: id3,
//       color: Colors.deepPurple,
//       points: polylineCoordinates,
//     );
//     polylines[id3] = polyline3;
//     if (mounted) setState(() {});
//   }
//
//   getPolyline(var newLat, var newLong) async {
//     // Polyline From Worker To Belbis
//     PolylineResult result1 = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(newLat, newLong), // Start Polyline
//       const PointLatLng(30.591438, 31.501723), // End Polyline
//       travelMode: TravelMode.driving,
//       wayPoints: [
//         PolylineWayPoint(
//           location: "From Worker To Belbis",
//         ),
//       ],
//     );
//     // if (result.points.isNotEmpty) {
//     //   result.points.forEach((PointLatLng point) {
//     polylineCoordinates.add(
//       LatLng(
//         newLat,
//         newLong,
//       ),
//     ); // Start Polyline
//     polylineCoordinates.add(
//       const LatLng(
//         30.591438,
//         31.501723,
//       ),
//     ); // End Polyline
//     // });
//     // }
//
//     //polylineCoordinates is the List of longitude and latitude.
//
//     // calc distance
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance1 = calculateDistance(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }
//     print(totalDistance1);
//
//     // Polyline From Worker To Kaphre Gnedy Bahnabay
//     PolylineResult result2 = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPiKey,
//         PointLatLng(newLat, newLong), // Start Polyline
//         const PointLatLng(
//           30.647712,
//           31.482197,
//         ), // End Polyline
//         travelMode: TravelMode.driving,
//         wayPoints: [
//           PolylineWayPoint(
//             location: "From Worker To Kaphre Gnedy Bahnabay",
//           )
//         ]);
//     // if (result.points.isNotEmpty) {
//     //   result.points.forEach((PointLatLng point) {
//     polylineCoordinates.add(LatLng(newLat, newLong)); // Start Polyline
//     polylineCoordinates.add(const LatLng(30.647712, 31.482197)); // End Polyline
//     // });
//     // }
//
//     //polulineCoordinates is the List of longitute and latidtude.
//
//     // calc distance
//
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance2 = calculateDistance(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }
//     print(totalDistance2);
//
//     // Polyline From Worker To Om Ramad ElZagazig
//     PolylineResult result3 = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPiKey,
//         PointLatLng(
//           newLat,
//           newLong,
//         ), // Start Polyline
//         const PointLatLng(
//           30.640697,
//           31.426958,
//         ), // End Polyline
//         travelMode: TravelMode.driving,
//         wayPoints: [
//           PolylineWayPoint(
//             location: "From Worker To Om Ramad ElZagazig",
//           )
//         ]);
//     // if (result.points.isNotEmpty) {
//     //   result.points.forEach((PointLatLng point) {
//     polylineCoordinates.add(
//       LatLng(
//         newLat,
//         newLong,
//       ),
//     ); // Start Polyline
//     polylineCoordinates.add(
//       const LatLng(
//         30.640697,
//         31.426958,
//       ),
//     ); // End Polyline
//     // });
//     // }
//
//     //polulineCoordinates is the List of longitute and latidtude.
//
//     // calc distance
//
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance3 = calculateDistance(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }
//     print(totalDistance3);
//     if (mounted) {
//       setState(() {
//         distance1 = totalDistance1;
//         distance2 = totalDistance2;
//         distance3 = totalDistance3;
//       });
//     }
//     addPolyLine();
//   }
//
//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var a = 0.5 -
//         cos((lat2 - lat1) * p) / 2 +
//         cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }
// }
// // AIzaSyDtdWNgEPfUGq9OYBJtO5EzNcP000t9Oao
var oscscva = 2;
// const SizedBox(
//   height: 7.0,
// ),
// Center(
//   child: Stack(
//     alignment: Alignment.bottomCenter,
//     children: [
//       Stack(
//         alignment: AlignmentDirectional.bottomEnd,
//         children: [
//           const CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 80,
//             backgroundImage: AssetImage(
//               'images/user_1.png',
//             ),
//           ),
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: defaultColor,
//             child: IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 IconBroken.Camera,
//                 size: 18,
//                 color: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),
//     ],
//   ),
// ),
