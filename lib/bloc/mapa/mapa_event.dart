part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent{}

class OnMarcarRecorrido extends MapaEvent{}

class OnSeguirUbicacion extends MapaEvent{}

class OnNuevaUbicacion extends MapaEvent{
  final LatLng ubicacion;
  OnNuevaUbicacion(this.ubicacion);
}

class OnCrearRutaCoord extends MapaEvent{
  final List<LatLng> rutaCoord;
  final double distancia;
  final double duracion;

  OnCrearRutaCoord(this.rutaCoord, this.distancia, this.duracion);
}

class OnMovioMapa extends MapaEvent{
  final LatLng centroMapa;

  OnMovioMapa(this.centroMapa);
}

