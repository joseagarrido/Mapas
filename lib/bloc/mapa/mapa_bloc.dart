import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/themes/uber_map.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());
  GoogleMapController _mapController;
  Polyline _miRuta = new Polyline(
      polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.transparent);

  Polyline _miRutaDestino = new Polyline(
      polylineId: PolylineId('mi_ruta_destino'), width: 4, color: Colors.black87);

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    if (event is OnMapaListo) {
      yield state.copyWith(mapaListo: true);

    } else if (event is OnNuevaUbicacion) {
      yield* this._onNuevaUbicacion(event);

    } else if (event is OnMarcarRecorrido) {
      yield* this._onMarcarRecorrido(event);
    } else if (event is OnSeguirUbicacion){
      
      if (!state.seguirUbicacion){
        this.moverCamara(this._miRuta.points[this._miRuta.points.length-1]);
      }
      yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);

    } else if (event is OnMovioMapa){
      //if (event.centroMapa != state.ubicacionCentral)
      yield state.copyWith(
        ubicacionCentral: event.centroMapa,
        //seguirUbicacion: false
        );
    } else if(event is OnCrearRutaCoord){
        yield* this._onCrearRutaCoord(event);
    }
  }

  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {
    if (state.seguirUbicacion){
      this.moverCamara(event.ubicacion);
    }
    List<LatLng> points = [...this._miRuta.points, event.ubicacion];
    this._miRuta = this._miRuta.copyWith(pointsParam: points);
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    (!state.dibujarRecorrido)
        ? this._miRuta = this._miRuta.copyWith(colorParam: Colors.black87)
        : this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;
    yield state.copyWith(
        polylines: currentPolylines, dibujarRecorrido: !state.dibujarRecorrido);
  }

  Stream<MapaState> _onCrearRutaCoord(OnCrearRutaCoord event) async*{
    this._miRutaDestino = this._miRutaDestino.copyWith(pointsParam: event.rutaCoord);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta_destino'] = this._miRutaDestino;
    yield state.copyWith(
        polylines: currentPolylines);
  }
}
