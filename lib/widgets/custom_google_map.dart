import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'dart:ui' as ui;

import 'package:payment/utils/location_service.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  Set<Marker> markers = {};
  late CameraPosition initialCameraPosition;
  GoogleMapController? mapController;
  late LocationService locationService;
  bool isFirstTime = true;
  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 1,
      target: LatLng(31.416825645438436, 31.813648140971143),
    );
    locationService = LocationService();
    updateMyLocation();
    // initMarker();
    // initPolylines();
    // initPolyGones();
    // initCircle();
    super.initState();
  }

  // Set<Polyline> polylines = {};
  // Set<Polygon> polygons = {};
  // Set<Circle> circles = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          // circles: circles,
          // polygons: polygons,
          // polylines: polylines,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          markers: markers,
          onMapCreated: (controller) {
            mapController = controller;
            initMapStyle();
          },
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: LatLng(31.400336949747643, 31.781466767065996),
          //     northeast: LatLng(31.437555056988632, 31.810249128590918),
          //   ),
          // ),
          initialCameraPosition: initialCameraPosition,
        ),
        // Positioned(
        //   left: 16,
        //   bottom: 16,
        //   right: 16,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       CameraPosition newLocation = CameraPosition(
        //         zoom: 12,
        //         target: LatLng(30.18444577794358, 31.472599318154497),
        //       );
        //       mapController.animateCamera(
        //         CameraUpdate.newCameraPosition(newLocation),
        //       );
        //     },
        //     child: Text("Change Location"),
        //   ),
        // ),
      ],
    );
  }

  void initMapStyle() async {
    var mapStyleNieght = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/nieght_map_style.json');
    mapController!.setMapStyle(mapStyleNieght);
  }

  // Fourth Method to get the current location
  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        updateMarkerCurrentPosition(locationData);
        updateMyCamera(locationData);
      });
    }
  }

  void updateMyCamera(LocationData locationData) {
    if (isFirstTime) {
      var newCameraPosition = CameraPosition(
        zoom: 17,
        target: LatLng(locationData.latitude!, locationData.longitude!),
      );
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(newCameraPosition),
      );
      isFirstTime = false;
    } else {
      var newLatLng = LatLng(locationData.latitude!, locationData.longitude!);
      mapController?.animateCamera(CameraUpdate.newLatLng(newLatLng));
    }
  }

  void updateMarkerCurrentPosition(LocationData locationData) {
    Marker myLocationMarker = Marker(
      markerId: MarkerId("my Location Marker"),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );
    markers.add(myLocationMarker);
    setState(() {});
  }

  // void initMarker() async {
  //   var icon = await BitmapDescriptor.fromAssetImage(
  //     ImageConfiguration(),
  //     "assets/images/location.png",
  //   );
  //   var markersSet =
  //       places
  //           .map(
  //             (placeModel) => Marker(
  //               icon: icon,
  //               markerId: MarkerId(placeModel.id.toString()),
  //               position: placeModel.latLng,
  //               infoWindow: InfoWindow(title: placeModel.name),
  //             ),
  //           )
  //           .toSet();

  //   markers.addAll(markersSet);
  //   setState(() {});
  // }

  // void initPolylines() {
  //   var pollyLine1 = Polyline(
  //     polylineId: PolylineId("1"),
  //     width: 5,
  //     zIndex: 1,
  //     points: [
  //       LatLng(31.410427253157703, 31.81228622613421),
  //       LatLng(31.419583607961293, 31.811000896017262),
  //       LatLng(31.421185831480784, 31.80897315255716),
  //       LatLng(31.425110461888085, 31.80520918176499),
  //     ],
  //   );

  //   var pollyLine2 = Polyline(
  //     polylineId: PolylineId("2"),
  //     color: Colors.red,
  //     patterns: [PatternItem.dot],
  //     zIndex: 2,
  //     startCap: Cap.roundCap,
  //     width: 5,
  //     points: [
  //       LatLng(31.42083593018314, 31.821016572394768),
  //       LatLng(31.420180764479618, 31.79840740084362),
  //     ],
  //   );
  //   polylines.add(pollyLine1);
  //   polylines.add(pollyLine2);
  // }

  // void initPolyGones() {
  //   Polygon polygon = Polygon(
  //     holes: [
  //       [
  //         LatLng(31.41840136519584, 31.81310453975973),
  //         LatLng(31.419260665959488, 31.81391971730803),
  //         LatLng(31.418483217532554, 31.81207361323655),
  //       ],
  //     ],
  //     polygonId: PolygonId("1"),
  //     fillColor: Colors.green.withOpacity(0.5),
  //     strokeWidth: 2,

  //     points: [
  //       LatLng(31.41551646098277, 31.81483064230651),
  //       LatLng(31.41952659505581, 31.81562197951934),
  //       LatLng(31.418871959837418, 31.811114610976247),
  //     ],
  //   );
  //   polygons.add(polygon);
  // }

  // void initCircle() {
  //   Circle circle = Circle(
  //     circleId: CircleId("1"),
  //     center: LatLng(31.412684149344845, 31.80885469003949),
  //     radius: 1000,
  //     fillColor: Colors.red.withOpacity(0.5),
  //     strokeWidth: 2,
  //     strokeColor: Colors.black,
  //   );
  //   circles.add(circle);
  // }
  // // used ony when icon is retrieved from api
  //   Future<Uint8List> getImageFromRawData(String image, double width) async {
  //     var imageData = await rootBundle.load(image);
  //     var imageCodec = await ui.instantiateImageCodec(
  //       imageData.buffer.asUint8List(),
  //       targetWidth: width.round(),
  //     );
  //     var imageFrame = await imageCodec.getNextFrame();

  //     var imageByteData = await imageFrame.image.toByteData(
  //       format: ui.ImageByteFormat.png,
  //     );
  //     return imageByteData!.buffer.asUint8List();
  //   }
}
