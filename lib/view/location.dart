import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interview_axolon/view/constants/colors.dart';
import 'package:location/location.dart' as loc;
import 'package:haversine_distance/haversine_distance.dart';
import 'package:sizer/sizer.dart';
class LocationView extends StatefulWidget {
  LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(27.1751, 78.0421);

  static const LatLng destination = LatLng(27.1721, 78.0411);

  var startCoordinate =  Location(60.389739, 5.322323);
var endCoordinate =  Location(60.393032, 5.327248);
final haversineDistance = HaversineDistance();
var distance;
getDistanceFast(){
   distance =
      haversineDistance.haversine(startCoordinate, endCoordinate, Unit.METER);

  print('Distance between start and end coordinate is: ${distance} m.');

  final distanceInKm =
      haversineDistance.haversine(startCoordinate, endCoordinate, Unit.KM);

  print('Distance between start and end coordinate is: ${distanceInKm} km.');
}

  List<LatLng> polylineCoordinates = [];

  loc.LocationData? currentLocation;

  void getCurrentLocation() async{
    loc.Location location = loc.Location( );

   await location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });

    setState(() {
      startCoordinate = Location(currentLocation!.latitude!, currentLocation!.longitude!);
      endCoordinate = Location(27.1751, 78.0421);
    });

  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAXFmwLjxMMNHR8iulPms2dDcVNrOR_UvQ',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }
 void getDistance(){
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  List<dynamic> data = [
    {
      "lat": 44.968046,
      "lng": -94.420307
    },{
      "lat": 44.33328,
      "lng": -89.132008
    },{
      "lat": 33.755787,
      "lng": -116.359998
    },{
      "lat": 33.844843,
      "lng": -116.54911
    },{
      "lat": 44.92057,
      "lng": -93.44786
    },{
      "lat": 44.240309,
      "lng": -91.493619
    },{
      "lat": 44.968041,
      "lng": -94.419696
    },{
      "lat": 44.333304,
      "lng": -89.132027
    },{
      "lat": 33.755783,
      "lng": -116.360066
    },{
      "lat": 33.844847,
      "lng": -116.549069
    },
  ];
  double totalDistance = 0;
  for(var i = 0; i < data.length-1; i++){
    totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"], data[i+1]["lat"], data[i+1]["lng"]);
  }
  print('distance is =================$totalDistance');
 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getCurrentLocation();
    getDistanceFast();
    getDistance();
    getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackColor,
          automaticallyImplyLeading: true,
          title: const Text(
            'Distance from Taj Mahal',
            style: TextStyle(fontFamily: 'Rubik'),
          ),
      ),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
            children: [
              GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: sourceLocation,
                    zoom: 14.5,
                  ),
                  polylines: {
                    Polyline(
                      polylineId: PolylineId("route"),
                      color: Colors.red,
                      points: polylineCoordinates,
                      width: 5,
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('source'),
                      position: LatLng(
                          currentLocation!.latitude!, currentLocation!.longitude!),
                    ),
                    const Marker(
                      markerId: MarkerId('destination'),
                      position: destination,
                    ),
                  },
                ),


                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                     child: Padding(
                       padding: const EdgeInsets.all(20),
                       child: Text('Distance : $distance' ,style: TextStyle(fontFamily: 'Rubik', fontSize: 14.sp),),
                     ),
                    )),
                )
            ],
          ),
    );
  }
}
