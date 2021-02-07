import 'package:flutter/material.dart';

import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/themes/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            _ListaCategorias(),

            Expanded(
              child: ListaNoticias(newsService.getArticulosCategoriasSeleccionada)
            )

          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

  final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(), //Aqui cambiamos el efecto de tope de desplazamiento. Osea cuando deslizamos y no hay mas cambia el sombreado tipico que vemos en un scroll
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: ( BuildContext context, int index ){

          final cName = categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryButton( categories[index] ),
                SizedBox( height: 5.0 ),
                Text( '${cName[0].toUpperCase()}${cName.substring(1)}' )
              ],
            ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category categoria;

  const _CategoryButton( this.categoria );

  // final List<Category> categories;

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector( //Con este widget estamos haciendo al containes que funcione como boton
      onTap: (){
        final newsService = Provider.of<NewsService>(context, listen: false);//en un evento OnTap esto no se tiene que redibujar
        newsService.selectedCategory = categoria.name;
      },
      
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name )
          ? miTema.accentColor
          : Colors.black54,
        ),
      ),
    );
  }
}