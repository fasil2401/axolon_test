// import 'dart:async';

// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:interview_axolon/view/constants/colors.dart';
// // import 'package:location/location.dart';
// import 'package:geocoding/geocoding.dart';
// import 'dart:math' show cos, sqrt, asin;

// import 'package:location/location.dart';
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';




// class MyMap extends StatefulWidget {
//   @override
//   _MyMapState createState() => _MyMapState();
// }

// // Starting point latitude
//   double _originLatitude = 6.5212402;
// // Starting point longitude
//   double _originLongitude = 3.3679965;
// // Destination latitude
//   double _destLatitude = 6.849660;
// // Destination Longitude
//   double _destLongitude = 3.648190;
// // Markers to show points on the map
//   Map<MarkerId, Marker> markers = {}; 

//   PolylinePoints polylinePoints = PolylinePoints();
//   Map<PolylineId, Polyline> polylines = {};

// class _MyMapState extends State<MyMap> {
//   // Google Maps controller
//   Completer<GoogleMapController> _controller = Completer();
//   // Configure map position and zoom
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(_originLatitude, _originLongitude),
//     zoom: 9.4746,
//   ); 

//   @override
//   void initState() {
//     /// add origin marker origin marker
//     _addMarker(
//       LatLng(_originLatitude, _originLongitude),
//       "origin",
//       BitmapDescriptor.defaultMarker,
//     );

//     // Add destination marker
//     _addMarker(
//       LatLng(_destLatitude, _destLongitude),
//       "destination",
//       BitmapDescriptor.defaultMarkerWithHue(90),
//     );

//     _getPolyline();

//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(
//           title: Text('Welcome to Flutter'),
//         ),
//         body: GoogleMap(
//             mapType: MapType.normal,
//             initialCameraPosition: _kGooglePlex,
//             myLocationEnabled: true,
//             tiltGesturesEnabled: true,
//             compassEnabled: true,
//             scrollGesturesEnabled: true,
//             zoomGesturesEnabled: true,
//             polylines: Set<Polyline>.of(polylines.values),
//             markers: Set<Marker>.of(markers.values),
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//        ), 
//       );
    
//   }

//   // This method will add markers to the map based on the LatLng position
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//         Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }

// _addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

// void _getPolyline() async {
//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "AIzaSyCS97zpIfwVLkRzgBNEKn0wgKeKUgo8QHI",
//       PointLatLng(_originLatitude, _originLongitude),
//       PointLatLng(_destLatitude, _destLongitude),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     _addPolyLine(polylineCoordinates);
//   }
// // }

// class MyMap extends StatefulWidget {
//   @override
//   _MyMapState createState() => _MyMapState();
// }

// class _MyMapState extends State<MyMap> {
//   CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
//   late GoogleMapController mapController;

//   late Position _currentPosition;
//   String _currentAddress = '';

//   final startAddressController = TextEditingController();
//   final destinationAddressController = TextEditingController();

//   final startAddressFocusNode = FocusNode();
//   final desrinationAddressFocusNode = FocusNode();

//   String _startAddress = '';
//   String _destinationAddress = '';
//   String? _placeDistance;

//   Set<Marker> markers = {};

//   late PolylinePoints polylinePoints;
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];

//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   Widget _textField({
//     required TextEditingController controller,
//     required FocusNode focusNode,
//     required String label,
//     required String hint,
//     required double width,
//     required Icon prefixIcon,
//     Widget? suffixIcon,
//     required Function(String) locationCallback,
//   }) {
//     return Container(
//       width: width * 0.8,
//       child: TextField(
//         onChanged: (value) {
//           locationCallback(value);
//         },
//         controller: controller,
//         focusNode: focusNode,
//         decoration: new InputDecoration(
//           prefixIcon: prefixIcon,
//           suffixIcon: suffixIcon,
//           labelText: label,
//           filled: true,
//           fillColor: Colors.white,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10.0),
//             ),
//             borderSide: BorderSide(
//               color: Colors.grey.shade400,
//               width: 2,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10.0),
//             ),
//             borderSide: BorderSide(
//               color: Colors.blue.shade300,
//               width: 2,
//             ),
//           ),
//           contentPadding: EdgeInsets.all(15),
//           hintText: hint,
//         ),
//       ),
//     );
//   }

//   // Method for retrieving the current location
//   _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         _currentPosition = position;
//         print('CURRENT POS: $_currentPosition');
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 18.0,
//             ),
//           ),
//         );
//       });
//       await _getAddress();
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   // Method for retrieving the address
//   _getAddress() async {
//     try {
//       List<Placemark> p = await placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);

//       Placemark place = p[0];

//       setState(() {
//         _currentAddress =
//             "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
//         startAddressController.text = _currentAddress;
//         _startAddress = _currentAddress;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   // Method for calculating the distance between two places
//   Future<bool> _calculateDistance() async {
//     try {
//       // Retrieving placemarks from addresses
//       List<Location> startPlacemark = await locationFromAddress(_startAddress);
//       List<Location> destinationPlacemark =
//           await locationFromAddress(_destinationAddress);

//       // Use the retrieved coordinates of the current position,
//       // instead of the address if the start position is user's
//       // current position, as it results in better accuracy.
//       double startLatitude = _startAddress == _currentAddress
//           ? _currentPosition.latitude
//           : startPlacemark[0].latitude;

//       double startLongitude = _startAddress == _currentAddress
//           ? _currentPosition.longitude
//           : startPlacemark[0].longitude;

//       double destinationLatitude = 27.1751;
//       double destinationLongitude = 78.0421 ;

//       String startCoordinatesString = '($startLatitude, $startLongitude)';
//       String destinationCoordinatesString =
//           '($destinationLatitude, $destinationLongitude)';

//       // Start Location Marker
//       Marker startMarker = Marker(
//         markerId: MarkerId(startCoordinatesString),
//         position: LatLng(startLatitude, startLongitude),
//         infoWindow: InfoWindow(
//           title: 'Start $startCoordinatesString',
//           snippet: _startAddress,
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       );

//       // Destination Location Marker
//       Marker destinationMarker = Marker(
//         markerId: MarkerId(destinationCoordinatesString),
//         position: LatLng(destinationLatitude, destinationLongitude),
//         infoWindow: InfoWindow(
//           title: 'Destination $destinationCoordinatesString',
//           snippet: _destinationAddress,
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       );

//       // Adding the markers to the list
//       markers.add(startMarker);
//       markers.add(destinationMarker);

//       print(
//         'START COORDINATES: ($startLatitude, $startLongitude)',
//       );
//       print(
//         'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
//       );

//       // Calculating to check that the position relative
//       // to the frame, and pan & zoom the camera accordingly.
//       double miny = (startLatitude <= destinationLatitude)
//           ? startLatitude
//           : destinationLatitude;
//       double minx = (startLongitude <= destinationLongitude)
//           ? startLongitude
//           : destinationLongitude;
//       double maxy = (startLatitude <= destinationLatitude)
//           ? destinationLatitude
//           : startLatitude;
//       double maxx = (startLongitude <= destinationLongitude)
//           ? destinationLongitude
//           : startLongitude;

//       double southWestLatitude = miny;
//       double southWestLongitude = minx;

//       double northEastLatitude = maxy;
//       double northEastLongitude = maxx;

//       // Accommodate the two locations within the
//       // camera view of the map
//       mapController.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           LatLngBounds(
//             northeast: LatLng(northEastLatitude, northEastLongitude),
//             southwest: LatLng(southWestLatitude, southWestLongitude),
//           ),
//           100.0,
//         ),
//       );

//       // Calculating the distance between the start and the end positions
//       // with a straight path, without considering any route
//       // double distanceInMeters = await Geolocator.bearingBetween(
//       //   startLatitude,
//       //   startLongitude,
//       //   destinationLatitude,
//       //   destinationLongitude,
//       // );

//       await _createPolylines(startLatitude, startLongitude, destinationLatitude,
//           destinationLongitude);

//       double totalDistance = 0.0;

//       // Calculating the total distance by adding the distance
//       // between small segments
//       for (int i = 0; i < polylineCoordinates.length - 1; i++) {
//         totalDistance += _coordinateDistance(
//           polylineCoordinates[i].latitude,
//           polylineCoordinates[i].longitude,
//           polylineCoordinates[i + 1].latitude,
//           polylineCoordinates[i + 1].longitude,
//         );
//       }

//       setState(() {
//         _placeDistance = totalDistance.toStringAsFixed(2);
//         print('DISTANCE: $_placeDistance km');
//       });

//       return true;
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }

//   // Formula for calculating distance between two coordinates
//   // https://stackoverflow.com/a/54138876/11910277
//   double _coordinateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   // Create the polylines for showing the route between two places
//   _createPolylines(
//     double startLatitude,
//     double startLongitude,
//     double destinationLatitude,
//     double destinationLongitude,
//   ) async {
//     polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyCS97zpIfwVLkRzgBNEKn0wgKeKUgo8QHI', // Google Maps API Key
//       PointLatLng(startLatitude, startLongitude),
//       PointLatLng(destinationLatitude, destinationLongitude),
//       travelMode: TravelMode.transit,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }

//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.red,
//       points: polylineCoordinates,
//       width: 3,
//     );
//     polylines[id] = polyline;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Container(
//       height: height,
//       width: width,
//       child: Scaffold(
//         key: _scaffoldKey,
//         body: Stack(
//           children: <Widget>[
//             // Map View
//             GoogleMap(
//               markers: Set<Marker>.from(markers),
//               initialCameraPosition: _initialLocation,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               mapType: MapType.normal,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: false,
//               polylines: Set<Polyline>.of(polylines.values),
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//             ),
//             // Show zoom buttons
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     ClipOval(
//                       child: Material(
//                         color: Colors.blue.shade100, // button color
//                         child: InkWell(
//                           splashColor: Colors.blue, // inkwell color
//                           child: SizedBox(
//                             width: 50,
//                             height: 50,
//                             child: Icon(Icons.add),
//                           ),
//                           onTap: () {
//                             mapController.animateCamera(
//                               CameraUpdate.zoomIn(),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ClipOval(
//                       child: Material(
//                         color: Colors.blue.shade100, // button color
//                         child: InkWell(
//                           splashColor: Colors.blue, // inkwell color
//                           child: SizedBox(
//                             width: 50,
//                             height: 50,
//                             child: Icon(Icons.remove),
//                           ),
//                           onTap: () {
//                             mapController.animateCamera(
//                               CameraUpdate.zoomOut(),
//                             );
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             // Show the place input fields & button for
//             // showing the route
//             SafeArea(
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white70,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(20.0),
//                       ),
//                     ),
//                     width: width * 0.9,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Text(
//                             'Places',
//                             style: TextStyle(fontSize: 20.0),
//                           ),
//                           SizedBox(height: 10),
//                           _textField(
//                               label: 'Start',
//                               hint: 'Choose starting point',
//                               prefixIcon: Icon(Icons.looks_one),
//                               suffixIcon: IconButton(
//                                 icon: Icon(Icons.my_location),
//                                 onPressed: () {
//                                   startAddressController.text = _currentAddress;
//                                   _startAddress = _currentAddress;
//                                 },
//                               ),
//                               controller: startAddressController,
//                               focusNode: startAddressFocusNode,
//                               width: width,
//                               locationCallback: (String value) {
//                                 setState(() {
//                                   _startAddress = value;
//                                 });
//                               }),
//                           SizedBox(height: 10),
//                           _textField(
//                               label: 'Destination',
//                               hint: 'Choose destination',
//                               prefixIcon: Icon(Icons.looks_two),
//                               controller: destinationAddressController,
//                               focusNode: desrinationAddressFocusNode,
//                               width: width,
//                               locationCallback: (String value) {
//                                 setState(() {
//                                   _destinationAddress = value;
//                                 });
//                               }),
//                           SizedBox(height: 10),
//                           Visibility(
//                             visible: _placeDistance == null ? false : true,
//                             child: Text(
//                               'DISTANCE: $_placeDistance km',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           ElevatedButton(
//                             onPressed: () async {
//                                     startAddressFocusNode.unfocus();
//                                     desrinationAddressFocusNode.unfocus();
//                                     setState(() {
//                                       if (markers.isNotEmpty) markers.clear();
//                                       if (polylines.isNotEmpty)
//                                         polylines.clear();
//                                       if (polylineCoordinates.isNotEmpty)
//                                         polylineCoordinates.clear();
//                                       _placeDistance = null;
//                                     });

//                                     _calculateDistance().then((isCalculated) {
//                                       if (isCalculated) {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                                 'Distance Calculated Sucessfully'),
//                                           ),
//                                         );
//                                       } else {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                                 'Error Calculating Distance'),
//                                           ),
//                                         );
//                                       }
//                                     });
//                                   }
//                                 ,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Show Route'.toUpperCase(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.0,
//                                 ),
//                               ),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.red,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // Show current location button
//             SafeArea(
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
//                   child: ClipOval(
//                     child: Material(
//                       color: Colors.orange.shade100, // button color
//                       child: InkWell(
//                         splashColor: Colors.orange, // inkwell color
//                         child: SizedBox(
//                           width: 56,
//                           height: 56,
//                           child: Icon(Icons.my_location),
//                         ),
//                         onTap: () {
//                           mapController.animateCamera(
//                             CameraUpdate.newCameraPosition(
//                               CameraPosition(
//                                 target: LatLng(
//                                   _currentPosition.latitude,
//                                   _currentPosition.longitude,
//                                 ),
//                                 zoom: 18.0,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyMap extends StatefulWidget {
//   @override
//   _MyMapState createState() => _MyMapState();
// }


// class _MyMapState extends State<MyMap> {
//   LocationData? _currentPosition;
//   String? _address,_dateTime;
//   GoogleMapController? mapController;
//   Marker? marker;
//   Location location = Location();

//   GoogleMapController? _controller;
//   LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getLoc();

//   }

//   void _onMapCreated(GoogleMapController _cntlr)
//   {
//     _controller = _controller;
//     location.onLocationChanged.listen((l) {
//       _controller!.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 15),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
//         ),
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SafeArea(
//           child: Container(
//             color: Colors.blueGrey.withOpacity(.8),
//             child: Center(
//               child: Column(
//                 children: [
//                   Container(
//                     height:  MediaQuery.of(context).size.height/2.5,
//                     width: MediaQuery.of(context).size.width,
//                     child: GoogleMap(
//                       initialCameraPosition: CameraPosition(target: _initialcameraposition,
//                       zoom: 15),
//                       mapType: MapType.normal,
//                       onMapCreated: _onMapCreated,
//                       myLocationEnabled: true,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   if (_dateTime != null)
//                     Text(
//                       "Date/Time: $_dateTime",
//                       style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.white,
//                         ),
//                     ),

//                   SizedBox(
//                     height: 3,
//                   ),
//                   if (_currentPosition != null)
//                     Text(
//                       "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}",
//                       style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   if (_address != null)
//                     Text(
//                       "Address: $_address",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),

//     );
//   }


//   getLoc() async{
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _currentPosition = await location.getLocation();
//     _initialcameraposition = LatLng(_currentPosition!.latitude ?? 0.0,_currentPosition!.longitude ?? 0.0);
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       print("${currentLocation.longitude} : ${currentLocation.longitude}");
//       setState(() {
//         _currentPosition = currentLocation;
//         _initialcameraposition = LatLng(_currentPosition!.latitude ?? 0.0,_currentPosition!.longitude ?? 0.0);

//         DateTime now = DateTime.now();
//         _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
//         _getAddress(_currentPosition!.latitude ?? 0.0, _currentPosition!.longitude ?? 0.0)
//             .then((value) {
//           setState(() {
//             _address = "${value.first.addressLine}";
//           });
//         });
//       });
//     });
//   }


//   Future<List<Address>> _getAddress(double lat, double lang) async {
//     final coordinates = new Coordinates(lat, lang);
//     List<Address> add =
//     await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     return add;
//   }

// }