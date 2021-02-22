part of "widgets.dart";

class SearchBar extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) return Container();

        return buildSearchBar(context);
 
      },
    );
  }

  
  Widget buildSearchBar(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    return SafeArea(
      child: FadeIn(
              child: Container(
          width: ancho,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: GestureDetector(
            onTap: ()async{
              final SearchResult resultado = await showSearch(context: context, delegate: BuscarDestino());
              retornoBusqueda(context, resultado);
            },
                    child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: Text('¿Donde quieres ir?',
                  style: TextStyle(color: Colors.black87)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda (BuildContext context, SearchResult resultado){

    if (resultado.cancelo) return;
    if (resultado.manual){
      context.read<BusquedaBloc>().add(OnCambiarMarcadorManual());
    }



  }



}
