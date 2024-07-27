import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/place.dart';
import 'package:wilcoerp/pages/check_out_page.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class LocationStep2Page extends StatefulWidget {
  Widget afterPage;

  LocationStep2Page(this.afterPage, {super.key});

  @override
  State<LocationStep2Page> createState() => _LocationStep2PageState();
}

class _LocationStep2PageState extends State<LocationStep2Page>
    with WidgetsBindingObserver {
  Completer<GoogleMapController> _controllerMap = Completer();
  final MarkerId markerId = MarkerId("1");
  Map<MarkerId, Marker> markersLocation = <MarkerId, Marker>{};

  dynamic mapController = null;
  dynamic globalLatLng = null;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      try {
        if (mapController != null) mapController.setMapStyle("[]");
      } catch (e) {}
    }
  }

  void createMarkerSelectLocation() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(provider.lat, provider.long),
        infoWindow: InfoWindow(title: "Ubicación", snippet: ''),
        draggable: true,
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          print("marker tap");
        },
        onDragEnd: (LatLng position) {
          endDrag(position);
        });
    setState(() {
      // adding a new marker to map
      markersLocation[markerId] = marker;
    });
    focus(new Place(lat: provider.lat, lng: provider.long));
    globalLatLng = LatLng(provider.lat, provider.long);
  }

  void updatePositionMarker(Place place) async {
    print("ENTRE  A updatePositionMarker");
    final provider = Provider.of<AppProvider>(context, listen: false);
    Marker marker = markersLocation[markerId]!;
    setState(() {
      markersLocation = <MarkerId, Marker>{};
    });
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      final Marker marker = Marker(
          markerId: markerId,
          position:
              LatLng(place.lat ?? provider.lat, place.lng ?? provider.long),
          infoWindow: InfoWindow(title: "Ubicación", snippet: ''),
          draggable: true,
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            print("marker tap");
          },
          onDragEnd: (LatLng position) {
            endDrag(position);
          });
      markersLocation[markerId] = marker;
    });

    try {
      if (mapController != null) mapController.setMapStyle("[]");
    } catch (e) {}
    focus(place);
    //progressLocationMap();
  }

  void endDrag(LatLng position) {
    simpleLoading(context, (BuildContext contextDialog) {
      try {
        Marker? marker = markersLocation[markerId];

        WebService(context)
            .reverseGeocode(
                position.latitude.toString(), position.longitude.toString())
            .then((List<Place> places) {
          if (places.length > 0) {
            places[0].lat = position.latitude;
            places[0].lng = position.longitude;
            globalLatLng = LatLng(position.latitude, position.longitude);
            Navigator.pop(contextDialog);
          } else {
            Navigator.pop(contextDialog);
          }
          setState(() {});
        }).catchError((e) {
          Navigator.pop(contextDialog);
          print(e);
        });
      } catch (e) {
        Navigator.pop(contextDialog);
        print(e);
      }
    });
  }

  void focus(Place place) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    _controllerMap.future.then((controller) {
      controller
          .animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: (place != null && place is Place)
                  ? LatLng((place as Place).lat ?? provider.lat,
                      (place as Place).lng ?? provider.long)
                  : LatLng(provider.lat, provider.long),
              zoom: 15.0,
            ),
          ))
          .then((value) {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<AppProvider>(context, listen: true);

    Widget map = GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      mapType: MapType.normal,
      liteModeEnabled: false,
      compassEnabled: false,
      indoorViewEnabled: false,
      rotateGesturesEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(provider.lat, provider.long),
        bearing: 0,
        zoom: 15.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          mapController = controller;
          mapController.setMapStyle("[]");
        });

        _controllerMap.complete(controller);
        createMarkerSelectLocation();
      },
      onCameraMoveStarted: () {
        /* setState(() {
          showBtnConfirmLocationMap = true;
        });*/
      },
      onCameraIdle: (() {}),
      markers: Set<Marker>.of(markersLocation.values),
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: map),
          Positioned(
              top: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Container(
                color: Colors.white,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 30, left: 20),
                    child: Text(
                      "IS THE LOCATION CORRECT?",
                      style:
                          TextStyle(color: CustomColors.primary, fontSize: 18),
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: 65,
              child: Container(
                  child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        onPressed: () {
                          if (globalLatLng == null) {
                            showErrorsDialog(context, [
                              "An error occurred, set a location on the map"
                            ]);
                          } else {
                            simpleLoading(context,
                                (BuildContext contextDialog) {
                              try {
                                WebService(context)
                                    .reverseGeocode(
                                        (globalLatLng as LatLng)
                                            .latitude
                                            .toString(),
                                        (globalLatLng as LatLng)
                                            .longitude
                                            .toString())
                                    .then((List<Place> places) {
                                  if (places.length > 0) {
                                    places[0].lat =
                                        (globalLatLng as LatLng).latitude;
                                    places[0].lng =
                                        (globalLatLng as LatLng).longitude;
                                    lat = (globalLatLng as LatLng).latitude;
                                    lng = (globalLatLng as LatLng).longitude;
                                    place = places[0].formatted_address;
                                    Navigator.pop(contextDialog);

                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: DonePage(widget.afterPage),
                                            type: PageTransitionType.slideInUp,
                                            duration:
                                                Duration(milliseconds: 500)));
                                  } else {
                                    Navigator.pop(contextDialog);
                                    showErrorsDialog(context, [
                                      "An error occurred, set a location on the map"
                                    ]);
                                  }
                                  setState(() {});
                                }).catchError((e) {
                                  Navigator.pop(contextDialog);
                                  print(e);
                                });
                              } catch (e) {
                                Navigator.pop(contextDialog);
                                print(e);
                              }
                            });
                          }
                        },
                        child: Container(
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                  flex: 2,
                                  child: Image.asset(
                                      'assets/images/correcto.png',
                                      width: 50)),
                              Flexible(
                                flex: 12,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "SELECT",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: CustomColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                  flex: 2,
                                  child: Image.asset('assets/images/borrar.png',
                                      width: 50)),
                              Flexible(
                                flex: 12,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "BACK",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))),
        ],
      ),
    );
  }
}
