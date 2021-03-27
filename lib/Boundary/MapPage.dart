import 'package:ezparking/Services/Auth.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ezparking/Utils/NavDrawer.dart';
import 'package:ezparking/Boundary/SearchPlacePage.dart';

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
      theme: ThemeData(
        primaryColor: Colors.amber.shade300,
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(32), // here the desired height
            child: AppBar(
            )
        ),
        drawer: NavDrawer(auth: auth),
        // appBar: FloatAppBar(),
        body: Stack(
            children: <Widget>[

            Container(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: _initialcameraposition),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,

              ),
            ),

            FloatAppBar(),
            ]
        ),

      ),);
  }
}
