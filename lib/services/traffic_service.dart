
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/models/rutas.dart';

class TrafficService {

//Singleton
TrafficService._privateConstructor();

static final TrafficService _instance = TrafficService._privateConstructor();
factory TrafficService(){
  return _instance;
}

final _dio = new Dio();
final baseUrl ='https://api.mapbox.com/directions/v5/mapbox/driving/';
final apiKey = 'pk.eyJ1Ijoiam9zZWFnYXJyaWRvIiwiYSI6ImNrbGM0OGV2aTBkYnEycG1qY2tpaW5oYmEifQ.hNaLAeajYr9TQaKd2kC2Ew';

Future <Rutas> getCoordenadas(LatLng inicio, LatLng fin)async{

  final url ='${this.baseUrl}${inicio.longitude},${inicio.latitude};${fin.longitude},${fin.latitude}';
  final resp = await this._dio.get(url, queryParameters: {
    'alternatives': 'true',
    'steps':'false',
    'access_token': this.apiKey,
    'geometries':'polyline6',
    'language':'es'
  });
  final data = Rutas.fromJson(resp.data);
  return data;

}


}

