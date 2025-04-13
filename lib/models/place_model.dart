import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String name;
  final int id;
  final LatLng latLng;

  PlaceModel({required this.name, required this.id, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(
    name: 'مطعم باب الحارة',
    id: 1,
    latLng: LatLng(31.410427253157703, 31.81228622613421),
  ),
  PlaceModel(
    name: 'مطعم XYZ',
    id: 2,
    latLng: LatLng(31.425110461888085, 31.80520918176499),
  ),
  PlaceModel(
    name: 'مطعم ماكدونالز',
    id: 3,
    latLng: LatLng(31.421185831480784, 31.80897315255716),
  ),
  PlaceModel(
    name: 'مسجد البحر',
    id: 4,
    latLng: LatLng(31.419583607961293, 31.811000896017262),
  ),
];
