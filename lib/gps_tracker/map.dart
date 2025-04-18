import 'package:app_chan_doan/connection_manage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GPSPage extends StatefulWidget {
  @override
  _GPSPageState createState() => _GPSPageState();
}

class _GPSPageState extends State<GPSPage> {
  late GoogleMapController mapController;
  LatLng _currentPosition = LatLng(10.762622, 106.660172);
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('${verifyId}/gps');

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  void _fetchLocation() {
    _dbRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        double latitude = data['latitude'];
        double longitude = data['longitude'];
        setState(() {
          _currentPosition = LatLng(latitude, longitude);
        });
        mapController.animateCamera(
          CameraUpdate.newLatLng(_currentPosition),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi GPS'),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 145, 220, 255),
        leading: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            Navigator.of(context).pop();
          },
          child: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 2.0,
          ),
        ),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('currentPosition'),
            position: _currentPosition,
            infoWindow: InfoWindow(title: 'Vị trí hiện tại'),
          ),
        },
      ),
    );
  }
}