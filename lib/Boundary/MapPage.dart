import 'package:ezparking/Services/Auth.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ezparking/Utils/NavDrawer.dart';
import 'package:ezparking/Boundary/SearchPage.dart';
import 'package:uuid/uuid.dart';
import 'package:ezparking/Services/PlaceAutoComplete.dart';

const kGoogleApiKey = "AIzaSyAzedSahYVFaCTK3_YP19NYYd9_mW3EI5A";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapPage extends StatelessWidget {
  MapPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;
  final _controller = TextEditingController();

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
            child: AppBar()),
        drawer: NavDrawer(auth: auth),
        // appBar: FloatAppBar(),
        body: Stack(children: <Widget>[
          Container(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
          ),
          Positioned(
            right: 5,
            left: 5,
            top: 60,
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: 2),
                ],
              ),
              padding: const EdgeInsets.all(5),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Theme(
                    data: new ThemeData(
                        primaryColor: Colors.grey,
                        primaryColorDark: Colors.grey),
                    child: new TextField(
                      style: TextStyle(fontSize: 15),
                      controller: _controller,
                      readOnly: true,
                      onTap: () async {
                        // generate a new token here
                        final sessionToken = Uuid().v4();
                        final Suggestion result = await showSearch(
                          context: context,
                          delegate: AddressSearch(sessionToken),
                        );
                        // This will change the text displayed in the TextField
                        if (result != null) {
                          final placeDetails =
                              await PlaceApiProvider(sessionToken)
                                  .getPlaceDetailFromId(result.placeId);
                          _controller.text = result.description;
                          print(_controller.text);
                          getCoordinates(_controller.text);
                        }
                      },
                      decoration: new InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 20,
                        ),
                        hintText: "Enter Address ...",
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
