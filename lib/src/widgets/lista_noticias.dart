import 'package:flutter/material.dart';

import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/themes/tema.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias( this.noticias );

  @override
  Widget build(BuildContext context) {
    return ListView.builder( //Listbuilder ya que construiremos una lista apartir de datos obtenidos de internet
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index){//Recordemos que aqui se contruyen los items
        return _Noticia(noticia: this.noticias[index], index: index,);
      },
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({
    @required this.noticia,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _TarjetaTopBar( noticia, index ),

          _TarjetaTitulo( noticia ),

          _TarjetaImagen( noticia ),

          _TarjetaBody( noticia ),

          _TarjetaBotones(),

          SizedBox(height: 10.0),
          Divider()
        ],
      ),
    );
  }
}

class _TarjetaBotones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        RawMaterialButton(
          child: Icon( Icons.star_border ),
          onPressed: (){},
          fillColor: miTema.accentColor,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
        ),

        SizedBox(width: 10.0),

        RawMaterialButton(
          child: Icon( Icons.more ),
          onPressed: (){},
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
        ),

      ],
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;

  const _TarjetaBody( this.noticia );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text( (noticia.description != null) ? noticia.description : '' ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {

  final Article noticia;
  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
            child: Container(
          child: (noticia.urlToImage != null)
          ? FadeInImage(
            placeholder: AssetImage('assets/img/giphy.gif'),
            image: NetworkImage(noticia.urlToImage)
          )
          : Image(image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(noticia.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

    final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text('${index + 1} ', style: TextStyle(color: miTema.accentColor, fontSize: 18.0),),
          Text('${noticia.source.name}', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}