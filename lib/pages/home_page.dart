import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mtms_task/components/button.dart';
import 'package:mtms_task/components/text_field.dart';
import 'package:mtms_task/pages/destination_page.dart';
import 'package:mtms_task/pages/sorce_page.dart';
import 'package:mtms_task/utils/calculate_distance.dart';
import 'package:mtms_task/utils/location.dart';
import 'package:mtms_task/widget/alert_widget.dart';
import 'package:mtms_task/widget/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _completer = Completer();
  dynamic source;
  dynamic dist;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static Position? position;
  static final CameraPosition _cameraPosition = CameraPosition(
    tilt: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    zoom: 15.0,
  );
  Future<void> getMyCurrentLocation() async {
    await Location.getCurrentLocation();
    position = await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  @override
  void initState() {
    getMyCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawerr(),
      body: Stack(
        children: [
          position != null
              ? Container(
                  child: GoogleMap(
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _completer.complete(controller);
                      },
                      initialCameraPosition: _cameraPosition),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          Positioned(
            top: 100,
            right: 12,
            left: 12,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xffE5E7E9),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                            color: Color(0xffB0AAA4),
                            size: 23,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GenericTextField(
                      hintText:
                          source == null ? "Your Location" : source['name'],
                      // controller: sourceModel.getname == "" ? _source : null,
                      maxLines: 1,
                      enable: false,
                      onTap: () async {
                        var selectedSource = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SorcePage()));
                        setState(() {
                          source = selectedSource;
                        });
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GenericTextField(
                      enable: false,
                      hintText: dist == null ? "Destination" : dist["name"],
                      // controller: sourceModel.getname == "" ? _source : null,

                      maxLines: 1,
                      onTap: () async {
                        var selectedDestination = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DestinationPage()));
                        setState(() {
                          dist = selectedDestination;
                        });
                      },
                    ),
                  ],
                )),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  _goToMyCurrentLocation();
                },
                icon: Icon(Icons.location_on)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Button(
              text: "REQUEST RD",
              onPressed: () {
                if (dist == null || source == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlerWidget(
                        title: "Please",
                        message: "Please select source/destination",
                      );
                    },
                  );
                } else {
                  var totalDistance = calculateDistance(
                    source["latitude"],
                    source["longitude"],
                    double.parse(dist["lat"]),
                    double.parse(dist["lng"]),
                  );
                  String unit = totalDistance > 1000 ? "KM" : "M";
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      print("$totalDistance");
                      return AlerWidget(
                        title: "Result",
                        message: "$totalDistance" "$unit",
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
