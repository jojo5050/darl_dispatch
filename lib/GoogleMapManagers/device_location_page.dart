import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/Models/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;


class DeviceLocationPage extends StatefulWidget {
  final String trackingId;
  const DeviceLocationPage({Key? key, required this.trackingId}) : super(key: key);


  @override
  State<DeviceLocationPage> createState() => _DeviceLocationPageState();
}

class _DeviceLocationPageState extends State<DeviceLocationPage> {

  final Completer<GoogleMapController> _completer = Completer();

  LocationData? _currentLocation;
  String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  final loc.Location location = loc.Location();
  late GoogleMapController _googleMapController;
  bool _added = false;

  String? _userid;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> _markers = {};


  String google_api_key = "AIzaSyCAIsvUnDK4FZZQ62OQqAFQcar44hJvOJ4";

  LatLng? currentLocation;

  BitmapDescriptor? _largerMarkerIcon;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Locations").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(_added){
              myMap(snapshot);
            }

            if(!snapshot.hasData){
               return Center(child: CircularProgressIndicator());
            }

            return GoogleMap(
             //   polylines: Set<Polyline>.of(polylines.values),
                mapType: MapType.normal,
                markers: {
                  Marker(
                    infoWindow: InfoWindow(title: usersName),
                      position: LatLng( snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.trackingId)["latitude"],
                             snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.trackingId)["longitude"]),
                      markerId: MarkerId("markerID"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed
                      )


                    /*_largerMarkerIcon
                        ?? BitmapDescriptor
                            .defaultMarkerWithHue(BitmapDescriptor.hueMagenta),*/
                  ),
                },
                initialCameraPosition: CameraPosition(
              target: LatLng( snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.trackingId)["latitude"],
                  snapshot.data!.docs.singleWhere(
                          (element) => element.id == widget.trackingId)["longitude"]),
              zoom: 13.0,
            ),
            onMapCreated: (GoogleMapController controller) async{
                  setState(() {
                    _googleMapController = controller;
                    _added = true;
                  });
            },);

          },
        )

    );
  }

  Future<void> myMap(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    await _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target:  LatLng( snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.trackingId)["latitude"],
                snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.trackingId)["longitude"]),
            zoom: 13.0
        )));
  //  getPolylines(currentLocation)
  }

     addPolyLine(List<LatLng> polylineCoordinates) {
       PolylineId id = PolylineId('poly');
       Polyline polyline = Polyline(polylineId: id,
           color: Colors.purple, points: polylineCoordinates,
       width: 5);
       polylines[id] = polyline;
       setState(() {});

     }

  void getPolylines(LatLng? currentLocation) async {
      List<dynamic> points = [];
       PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(currentLocation!.latitude, currentLocation.longitude),
      PointLatLng(currentLocation.latitude, currentLocation.longitude),
      travelMode: TravelMode.driving,
    );
       if(polylineResult.points.isNotEmpty){
         polylineResult.points.forEach((PointLatLng point) {
           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
           points.add({'lat': point.latitude, 'lng': point.longitude});

         });
       }else{
         print(polylineResult.errorMessage);
       }
       addPolyLine(polylineCoordinates);
  }

 /* Future<void> _createCustomMarkerIcon() async {
    final ImageConfiguration imageConfiguration =
    createLocalImageConfiguration(context);
    BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      'assets/images/lcimage.png',
    ).then((BitmapDescriptor bitmapDescriptor) {
      setState(() {
        _largerMarkerIcon = bitmapDescriptor;
      });
    }).catchError((dynamic error) {
      print('Failed to load larger marker icon: $error');
    });
  }*/

}

