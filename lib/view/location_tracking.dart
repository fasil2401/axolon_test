import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math';
import '../model/direction_model.dart';

class LocationTracking extends StatefulWidget {
  LocationTracking({Key? key}) : super(key: key);

  @override
  State<LocationTracking> createState() => _LocationTrackingState();
}

class _LocationTrackingState extends State<LocationTracking> {

  LatLng sourceLocation = LatLng(27.1751, 78.0421 );
  LatLng destinationLatlng = LatLng(27.1751, 78.0421 );

  bool isLoading = false;
  double distance = 0.0;

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _marker = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();

  List<LatLng>polylineCoordinates =[];
  late PolylinePoints polylinePoints;
  late StreamSubscription<LocationData> subscription;

  late LocationData currentLocation;
  late LocationData destinationLocation;
  late Location location;
Directions? _info;

  @override
  void initState() {
    super.initState();

    location = Location();
    polylinePoints = PolylinePoints();

   subscription = location.onLocationChanged.listen((clocation) {
      currentLocation = clocation;
     });
     setInitialLocation();


  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();
    destinationLocation = LocationData.fromMap({
      "latitude": 27.1751,
      "longitude": 78.0421,
    });
  }

  void  showLocationPins(){
    var sourcePosition = LatLng(currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0);
    var destinationPosition = LatLng(destinationLocation.latitude ?? 0.0, destinationLocation.longitude ?? 0.0);

    _marker.add(Marker(
      markerId:  MarkerId('sourcePosition'),
      position: sourcePosition,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Current Location',
        snippet: '${currentLocation.latitude}, ${currentLocation.longitude}',
      ),
    ));

    _marker.add(Marker(
      markerId:  MarkerId('destinationPosition'),
      position: destinationPosition,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Destination Location',
        snippet: '${destinationLocation.latitude}, ${destinationLocation.longitude}',
      ),
    ));
    setPolylineInMap();
  }


  void setPolylineInMap() async {
    // isLoading = true;
    var result = await polylinePoints.getRouteBetweenCoordinates(
      'https://maps.googleapis.com/maps/api/directions/json?', 
      PointLatLng(
          currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
      PointLatLng(destinationLatlng.latitude, destinationLatlng.longitude),);

      if (result.points.isNotEmpty) {
        result.points.forEach((element) {
          polylineCoordinates.add(LatLng(
              element.latitude, element.longitude));
        });
      }
      

      setState(() {
        _polylines.add(Polyline(
        polylineId: PolylineId('poly'),
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      ));
      });
      double totalDistance = 0;
      for(var i = 0; i < polylineCoordinates.length-1; i++){
           totalDistance += calculateDistance(
                polylineCoordinates[i].latitude, 
                polylineCoordinates[i].longitude, 
                polylineCoordinates[i+1].latitude, 
                polylineCoordinates[i+1].longitude);
      }
      print(totalDistance);

      setState(() {
         distance = totalDistance;
      });
  }
   double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

 void updatePinsOnMap() async {
    CameraPosition cameraPosition = CameraPosition(
      zoom: 20,
      tilt: 80,
      bearing: 30,
      target: LatLng(
          currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
    );

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    var sourcePosition = LatLng(
        currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0);

    setState(() {
      _marker.removeWhere((marker) => marker.mapsId.value == 'sourcePosition');

      _marker.add(Marker(
        markerId: MarkerId('sourcePosition'),
        position: sourcePosition,
      ));
    });
  }
    GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {

    CameraPosition initialCameraPosition = CameraPosition(
      target: sourceLocation,
      zoom: 20,
      tilt: 80,
      bearing: 30,
    );
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              // showLocationPins();
             LatLng newlatlang = LatLng(27.7149298,85.2903343);
                 mapController?.animateCamera( 
                          CameraUpdate.newCameraPosition(
                                CameraPosition(target: newlatlang, zoom: 17) 
                                //17 is new zoom level
                          )
                        );
            });
          },
          child: Icon(Icons.directions),
        ),
      body: SafeArea(
        child: Stack(
          children: [
            
            GoogleMap(
      
              markers: _marker,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              setState(() {
                showLocationPins();
              });
              },
              ),
      
              Positioned(
                      bottom: 200,
                      left: 50,
                      child: Container( 
                       child: Card( 
                           child: Container(
                              padding: EdgeInsets.all(20),
                              child: Text("Total Distance: " + distance.toStringAsFixed(2) + " KM",
                                           style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold))
                           ),
                       )))
          ],
        ),
      ),
    );
  }
}