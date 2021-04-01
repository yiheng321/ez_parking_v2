import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ezparking/Controller/CarparkDatabase.dart';
import 'package:ezparking/Controller/ReviewDatabse.dart';
import 'package:ezparking/Services/Auth.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ezparking/Utils/NavDrawer.dart';
import 'package:ezparking/Boundary/SearchPage.dart';
import 'package:uuid/uuid.dart';
import 'package:ezparking/Services/PlaceAutoComplete.dart';
import 'package:ezparking/Boundary/ViewCarparkInfoPage.dart';

const kGoogleApiKey = "AIzaSyAzedSahYVFaCTK3_YP19NYYd9_mW3EI5A";

class MapPage extends StatefulWidget {
  MapPage({Key key, @required this.auth}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
  final AuthBase auth;
  final _textController = TextEditingController();
}

class _MapPageState extends State<MapPage> {
  double _radius = 1;
  GoogleMapController _mapController;
  LatLng _initialcameraposition;
  Set<Marker> _markers = {};
  Set<Circle> _circle = {};
  BitmapDescriptor _carparkRedIcon;
  BitmapDescriptor _carparkYellowIcon;
  BitmapDescriptor _carparkGreenIcon;
  BitmapDescriptor _blueIcon;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getIcons();
    setInitialLocation();
  }

  void getIcons() async{
  final Uint8List markerIcon1 = await getBytesFromAsset('assets/red-dot.png', 100);
  _carparkRedIcon = BitmapDescriptor.fromBytes(markerIcon1);

  final Uint8List markerIcon2 = await getBytesFromAsset('assets/green-dot.png', 100);
  _carparkGreenIcon = BitmapDescriptor.fromBytes(markerIcon2);
  final Uint8List markerIcon3 = await getBytesFromAsset('assets/yellow-dot.png', 100);
  _carparkYellowIcon = BitmapDescriptor.fromBytes(markerIcon3);
  final Uint8List markerIcon4 = await getBytesFromAsset('assets/blue-dot.png', 100);
  _blueIcon = BitmapDescriptor.fromBytes(markerIcon4);
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialcameraposition = LatLng(position.latitude, position.longitude);
      print(_initialcameraposition.latitude);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  void addMarker() async {

    var xmin = _initialcameraposition.latitude - _radius / 101;
    var ymin = _initialcameraposition.longitude - _radius / 101;
    var xmax = _initialcameraposition.latitude + _radius / 101;
    var ymax = _initialcameraposition.longitude + _radius / 101;
    var carparkDB = CarparkDataBase();
    var reviewDB = ReviewDataBase();
    var carparks = await carparkDB.getCarparkByRadius(xmin, ymin, xmax, ymax);
    if(_initialcameraposition != null){
      setState(() {
        _markers.add(
            Marker(
                markerId: MarkerId("Current Position"),
                position: _initialcameraposition,
                icon: _blueIcon,
        ));
        for (var carpark in carparks) {
          print(carpark.carParkNo);
          if(carpark.currentSlot <=10){
            _markers.add(
              Marker(
                  markerId: MarkerId(carpark.carParkNo),
                  position: LatLng(carpark.xCoord, carpark.yCoord),
                  icon: _carparkRedIcon,
                  infoWindow: InfoWindow(
                    title: "Current Slot: "+carpark.currentSlot.toString() +
                        " Total Slot: "+
                        carpark.maxSlot.toString(),
                    snippet: carpark.address,
                  ),
                  onTap: () async{
                    var review = await reviewDB.getSingaleReviewbyCarparkNo(carpark.carParkNo);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> (CarparkInfoPage(carpark: carpark, review: review, currentLocation: _initialcameraposition,))));
                  }
              ),
            );
          }
          else if(carpark.currentSlot>10 && carpark.currentSlot <=30){
            _markers.add(
              Marker(
                  markerId: MarkerId(carpark.carParkNo),
                  position: LatLng(carpark.xCoord, carpark.yCoord),
                  icon: _carparkYellowIcon,
                  infoWindow: InfoWindow(
                    title: "Current Slot: "+carpark.currentSlot.toString() +
                        " Total Slot: "+
                        carpark.maxSlot.toString(),
                    snippet: carpark.address,
                  ),
                  onTap: () async{
                    var review = await reviewDB.getSingaleReviewbyCarparkNo(carpark.carParkNo);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> (CarparkInfoPage(carpark: carpark, review: review,currentLocation: _initialcameraposition,))));
                  }
              ),
            );
          }
          else{
            _markers.add(
              Marker(
                  markerId: MarkerId(carpark.carParkNo),
                  position: LatLng(carpark.xCoord, carpark.yCoord),
                  icon: _carparkGreenIcon,
                  infoWindow: InfoWindow(
                    title: "Current Slot: "+carpark.currentSlot.toString() +
                        " Total Slot: "+
                        carpark.maxSlot.toString(),
                    snippet: carpark.address,
                  ),
                  onTap: () async{
                    var review = await reviewDB.getSingaleReviewbyCarparkNo(carpark.carParkNo);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> (CarparkInfoPage(carpark: carpark, review: review,currentLocation: _initialcameraposition,))));
                  }
              ),
            );
          }

        }
      });
    }

  }

  void _onMapCreated(GoogleMapController _cntlr) async {
    _mapController = _cntlr;
    var zoomlevel = await _mapController.getZoomLevel();
    addMarker();
    setState(() {
      _circle.add(Circle(
          circleId: CircleId("1"),
          center: _initialcameraposition,
          radius: _radius * 1500,
          fillColor: Colors.lightBlue.withOpacity(0.2),
          strokeWidth: 2));
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

        body: _initialcameraposition == null
            ? Container(
                child: Center(
                  child: Text(
                    'loading map..',
                    style: TextStyle(
                        fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                  ),
                ),
              )
            : Stack(children: <Widget>[
                Container(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialcameraposition,
                      zoom: 15,
                    ),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: _markers,
                    circles: _circle,
                  ),
                ),
                Positioned(
                  right: 5,
                  left: 5,
                  top: 70,
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
                                widget._textController.text =
                                    result.description;
                                _initialcameraposition = await getCoordinates(
                                    widget._textController.text);
                                setState(() async {
                                  await _mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: _initialcameraposition,
                                        zoom: 15,
                                      ),
                                    ),
                                  );
                                  _markers.clear();
                                  _circle.clear();
                                  setState(() {
                                    _circle.add(Circle(
                                        circleId: CircleId("1"),
                                        center: _initialcameraposition,
                                        radius: _radius * 1500,
                                        fillColor:
                                            Colors.lightBlue.withOpacity(0.2),
                                        strokeWidth: 2));
                                  });
                                  addMarker();
                                });
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
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      color: Colors.amber.shade300,
                      padding: EdgeInsets.all(2.0),
                      child: DropdownButton(
                          value: _radius,
                          items: [
                            DropdownMenuItem(
                              child: Text("Radius 1.5km"),
                              value: 1.0,
                            ),
                            DropdownMenuItem(
                              child: Text("Radius 3km"),
                              value: 2.0,
                            ),
                            DropdownMenuItem(
                                child: Text("Radius 4.5km"), value: 3.0),
                            DropdownMenuItem(
                                child: Text("Radius 6km"), value: 4.0)
                          ],
                          onChanged: (value) {
                            setState(() {
                              _radius = value;
                            });
                            _markers.clear();
                            _circle.clear();
                            setState(() {
                              _circle.add(Circle(
                                  circleId: CircleId("1"),
                                  center: _initialcameraposition,
                                  radius: _radius * 1500,
                                  fillColor: Colors.lightBlue.withOpacity(0.2),
                                  strokeWidth: 2));
                            });
                            addMarker();
                          }),
                    ))
              ]),
      ),
    );
  }
}
