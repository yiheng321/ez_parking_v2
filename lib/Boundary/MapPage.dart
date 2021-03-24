import 'package:ezparking/Services/Auth.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ezparking/Boundary/SearchPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ezparking/Utils/NavDrawer.dart';

const kGoogleApiKey = "AIzaSyAzedSahYVFaCTK3_YP19NYYd9_mW3EI5A";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapPage extends StatelessWidget {
  MapPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;
  GoogleMapController mapController;
  LatLng _initialcameraposition = LatLng(1.282302, 103.858528);
  final _location = LocationManager.Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    mapController = _cntlr;
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavDrawer(auth: auth),
        appBar: AppBar(
          title: Text('Car parks'),
          backgroundColor: Colors.amber.shade300,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },)
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: _initialcameraposition),
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,

        ),
      ),);
  }
}