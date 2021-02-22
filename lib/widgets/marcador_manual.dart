part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<BusquedaBloc, BusquedaState>(
        builder: (context, state) {
          if (state.seleccionManual){
            return _BuidMarcadorManual();
          }
          
          return Container();
        },
      );
  }
}

class _BuidMarcadorManual extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
        final width= MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 20,
          child: FadeIn(
                      child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
                        child: IconButton(
                icon: Icon (Icons.arrow_back, color: Colors.black87,), 
                onPressed: (){
                  context.read<BusquedaBloc>().add(OnCambiarMarcadorManual());
                }
              ),
            ),
          ) ,
          ),

          Center(
            child: Transform.translate(
              offset: Offset(0, -12),
              child: BounceInDown (child: Icon(Icons.location_on, size:50, ))
          )),

          Positioned(
            bottom: 70,
            left: 40,
            child: FadeIn(
                          child: MaterialButton(
                minWidth: width-120,
                color:  Colors.black,
                shape: StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                child: Text('Confirmar destino', style: TextStyle(color: Colors.white)),
                onPressed: (){
                  this.calcularDestino(context);
                }
                ),
            ),)
      ],
    );
  }

  void calcularDestino(BuildContext context)async{

    calculandoAlerta(context);

    final mapaBloc = context.bloc<MapaBloc>();

    final trafficService = new TrafficService();
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    final fin = mapaBloc.state.ubicacionCentral;
    
    final trafficResponce = await trafficService.getCoordenadas(inicio, fin);

    //decodificar la ruta;
    final geometry = trafficResponce.routes[0].geometry;
    final duracion = trafficResponce.routes[0].duration;
    final distancia = trafficResponce.routes[0].distance;

    final polyRuta = Poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
    //Transformar en pilyline
    final List<LatLng> rutaCoord = polyRuta.map((point) => LatLng(point[0],point[1])).toList();
    
    mapaBloc.add(OnCrearRutaCoord(rutaCoord, distancia, duracion));

    Navigator.of(context).pop();

    context.read<BusquedaBloc>().add(OnCambiarMarcadorManual());

  }
}