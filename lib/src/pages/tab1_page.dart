import 'package:flutter/material.dart';

import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

//En este Tab mostraremos los HeadLines
class Tab1Page extends StatefulWidget { //Utilizamos un statefullWidget para mantener el estado de la aplicacion (en este casa al realizar escroll y movernos a la siguiente pagina y regresaramos el scroll se mantendra en donde lo dejamos)

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin { //Para mantener el estado del scroll se utilizara el mixin siguiente
  @override
  Widget build(BuildContext context) {

  //Aqui obtenemos los HeadLines(algo que note es que deberia aparecer desde el main ya que desde el Provider padre se instancia pero aparece se consulta desde aqui)
  //Esto provaider lo obtenemos del main
  final headlines = Provider.of<NewsService>(context).headlines; 
  
    return Center(
      child: ( headlines.length == 0 )
      ? Center(
        child: CircularProgressIndicator(),
      ) 
      :ListaNoticias(headlines),//Widget ubicado en la carpeta Widgets
    );
  }

  //El mixin requiere de este override
  @override
  bool get wantKeepAlive => true;
}