import 'package:ezparking/Controller/CarparkDatabase.dart';
import 'package:ezparking/Services/ApiService.dart';
import 'package:ezparking/Services/Auth.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ezparking/Utils/NavDrawer.dart';
import 'package:ezparking/Boundary/SearchPage.dart';
import 'package:uuid/uuid.dart';
import 'package:ezparking/Services/PlaceAutoComplete.dart';

const kGoogleApiKey = "AIzaSyAzedSahYVFaCTK3_YP19NYYd9_mW3EI5A";

class MapPage extends StatefulWidget {
  MapPage({Key key, @required this.auth}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
  final AuthBase auth;
  final _textController = TextEditingController();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  LatLng _initialcameraposition = LatLng(1.282302, 103.858528);
  final _location = LocationManager.Location();
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void addMarker(LatLng mLatLng) async {
    // await loadCarparkList();
    double radius = 1;
    var xmin = mLatLng.latitude - radius/101;
    var ymin = mLatLng.longitude  - radius/101;
    var xmax = mLatLng.latitude + radius/101;
    var ymax = mLatLng.longitude  + radius/101;
    var carparkDB = CarparkDataBase();
    var carparks = await carparkDB.getCarparkByRadius(xmin, ymin, xmax, ymax);
    setState(() {
      for (var carpark in carparks) {
        print(carpark.carParkNo);
        _markers.add(
          Marker(
            markerId: MarkerId(carpark.carParkNo),
            position: LatLng(carpark.xCoord, carpark.yCoord),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: carpark.currentSlot.toString() + "/" + carpark.maxSlot.toString(),
              snippet: carpark.address,
            ),
          ),
        );
      }
    });
  }

  // LatLng utmToLatLon(double x, double y)
  // {
  //   var utm1 = UTM.fromUtm(easting: x, northing: y, zoneNumber: 48, zoneLetter: "N");
  //   return LatLng(utm1.lat, utm1.lon);
  // }
  void _onMapCreated(GoogleMapController _cntlr) async {
    mapController = _cntlr;
    _location.onLocationChanged.listen((l) async {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
      addMarker(LatLng(l.latitude, l.longitude));
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
        drawer: NavDrawer(auth: widget.auth),
        // appBar: FloatAppBar(),
        body: Stack(children: <Widget>[
          Container(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: _markers,
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
                      controller: widget._textController,
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
                          widget._textController.text = result.description;
                          print(widget._textController.text);
                          getCoordinates(widget._textController.text);
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
