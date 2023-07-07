import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



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
  Timer? _firestoreUpdateTimer;
  int _firestoreUpdateInterval = 60;
  List<LocationData> _locationList = [];

  String? _userid;


  String google_api_key = "AIzaSyCAIsvUnDK4FZZQ62OQqAFQcar44hJvOJ4";

  Set<Marker>? _markers;

  Polyline? _polyline;

  bool _isLoading = true;

  LocationData? _locationData;


  @override
  void initState() {
    super.initState();
    _startFirestoreUpdates();
    //  getPolyLines();
  }

  @override
  void dispose() {
    _stopLocationUpdates();
    _stopFirestoreUpdates();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildLocationScreen(),

      /* Column(children: [

          Expanded(
            child:
                Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (controller) {
                        _completer.complete(controller);
                      },
                      initialCameraPosition: CameraPosition(target: LatLng(0, 0),
                        zoom: 13.0,),
                      myLocationEnabled: true,
                      markers: _markers != null ? Set<Marker>.from(_markers!) : Set<
                          Marker>(),
                      polylines: _polyline != null
                          ? Set<Polyline>.from([_polyline!])
                          : Set<Polyline>(),
                    ),

                    if (_isLoading)
                      Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              CircularProgressIndicator(),
                              SizedBox(height: 1.h,),
                              const Text("Retreiving Location...", style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                              const Text(" Please Stay on the page, this could take\n"
                                  " up to a minute to load depending on the \n location Availaibility"),
                            ],
                          )
                      ),
                    if (!_isLoading && _locationData == null)
                      FutureBuilder<bool>(
                        future: _checkLocationExists(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError || snapshot.data == false) {
                            return const Center(
                              child: Text(
                                'No location found',
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                  ],
                ),

          )
        ],)*/

    );
  }

  void _startFirestoreUpdates() {
    _firestoreUpdateTimer =
        Timer.periodic(Duration(seconds: _firestoreUpdateInterval), (timer) {
          _getLocationData();
        });
  }

  void _stopLocationUpdates() {
    _locationList.clear();
  }

  void _stopFirestoreUpdates() {
    _firestoreUpdateTimer?.cancel();
  }

  Future<void> _getLocationData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('user_locations')
        .doc(widget.trackingId)
        .get();

    if (snapshot.exists) {
      double latitude = snapshot.get('latitude');
      double longitude = snapshot.get('longitude');

      LocationData locationData = LocationData.fromMap({
        'latitude': latitude,
        'longitude': longitude,
      });

      print("print client latitude as..................$latitude");
      print("print client langitude as..................$longitude");

      await _updateFirestore(locationData);
      _updatePolyline(locationData);

      LatLng locationLatLng = LatLng(latitude, longitude);

      GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newLatLng(locationLatLng));

      // Add a marker at the current location
      Marker marker = Marker(
        markerId: MarkerId('currentLocation'),
        position: locationLatLng,
        infoWindow: InfoWindow(
          title: 'Tracked Location',
        ),
      );

      setState(() {
        _markers = Set<Marker>.from([marker]);
        _locationData = locationData;
        _isLoading = false;
        //  _polyline = updatedPolyline;
      });

    }else{
      setState(() {
        _markers = null;
      });

    }
  }

  Future<void> _updateFirestore(LocationData locationData) async {
    CollectionReference locationCollection =
    FirebaseFirestore.instance.collection('user_locations');
    await locationCollection.doc(widget.trackingId).set({
      'latitude': locationData.latitude,
      'longitude': locationData.longitude,
      'timestamp': DateTime.now(),
    });
  }

  Future<void> _updatePolyline(LocationData locationData) async {
    if (_currentLocation != null) {
      LatLng currentLatLng = LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      );

      LatLng newLatLng = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );

      Polyline updatedPolyline = Polyline(
        polylineId: PolylineId('userPath'),
        color: Colors.blue,
        points: [
          currentLatLng,
          newLatLng,
        ],
      );

      setState(() {
        _polyline = updatedPolyline;
      });
    }}

  Future<bool> _checkLocationExists() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('user_locations')
          .doc(widget.trackingId)
          .get();

      return snapshot.exists;
    } catch (e) {
      print('Error checking location: $e');
      return false;
    }
  }

  Widget _buildLocationScreen() {
    return FutureBuilder<bool>(
      future: _checkLocationExists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  _completer.complete(controller);
                },
                initialCameraPosition: CameraPosition(target: LatLng(0, 0),
                  zoom: 13.0,),
                myLocationEnabled: true,
                markers: _markers != null ? Set<Marker>.from(_markers!) : Set<
                    Marker>(),
                polylines: _polyline != null
                    ? Set<Polyline>.from([_polyline!])
                    : Set<Polyline>(),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  _completer.complete(controller);
                },
                initialCameraPosition: CameraPosition(target: LatLng(0, 0),
                  zoom: 13.0,),
                myLocationEnabled: true,
                markers: _markers != null ? Set<Marker>.from(_markers!) : Set<
                    Marker>(),
                polylines: _polyline != null
                    ? Set<Polyline>.from([_polyline!])
                    : Set<Polyline>(),
              ),
              Center(
                child: Text('Error checking location'),
              ),
            ],
          );
        } else if (snapshot.data == false) {
          return Center(
            child: Text('No location found'),
          );
        } else {
          return GoogleMap(
            onMapCreated: (controller) {
              _completer.complete(controller);
            },
            initialCameraPosition: CameraPosition(target: LatLng(0, 0),
              zoom: 13.0,),
            myLocationEnabled: true,
            markers: _markers != null ? Set<Marker>.from(_markers!) : Set<
                Marker>(),
            polylines: _polyline != null
                ? Set<Polyline>.from([_polyline!])
                : Set<Polyline>(),
          );
        }
      },
    );
  }

}
