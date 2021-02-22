
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult{
  final bool cancelo;
  final bool manual;
  final LatLng postition;
  final String nombreDestino;
  final String descripcion;

  SearchResult({
    @required this.cancelo, 
    this.manual, 
    this.postition, 
    this.nombreDestino,
   this.descripcion});



  

}