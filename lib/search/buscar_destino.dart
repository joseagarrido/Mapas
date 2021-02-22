
import 'package:flutter/material.dart';
import 'package:mapas_app/models/search_result.dart';

class BuscarDestino extends SearchDelegate<SearchResult>{

  @override
  final String searchFieldLabel;

  // Constructor
  BuscarDestino(): this.searchFieldLabel='Buscar...';

  @override
  List<Widget> buildActions(BuildContext context) {
     return [
       IconButton(icon: Icon(Icons.clear), onPressed: ()=> this.query='')
     ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return 
       IconButton(icon: Icon(Icons.arrow_back_ios),
        onPressed: ()=> this.close(context, SearchResult(cancelo: true)));

    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Text('buildResults');
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on) ,
          title: Text('Colocar ubicacion manualmente'),
          onTap: () {
            // Terminar de hacer
            this.close(context, SearchResult(cancelo: false, manual: true));
          },
        )
      ]
    );
  }

}