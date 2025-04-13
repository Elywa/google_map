import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:payment/models/place_model.dart';
import 'dart:ui' as ui;

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  Set<Marker> markers = {};
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 16,
      target: LatLng(31.416825645438436, 31.813648140971143),
    );
    // TODO: implement initState
    initMarker();
    super.initState();
  }

  late GoogleMapController mapController;
  @override
  void dispose() {
    mapController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
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
    mapController.setMapStyle(mapStyleNieght);
  }

  void initMarker() async {
    var icon =await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/location.png",
    );
    var markersSet =
        places
            .map(
              (placeModel) => Marker(
                icon: icon,
                markerId: MarkerId(placeModel.id.toString()),
                position: placeModel.latLng,
                infoWindow: InfoWindow(title: placeModel.name),
              ),
            )
            .toSet();

    markers.addAll(markersSet);
    setState(() {});
  }
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
