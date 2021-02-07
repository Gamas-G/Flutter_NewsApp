import 'package:flutter/material.dart';

import 'package:newsapp/src/pages/tabs_page.dart';
import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/themes/tema.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider( //Se coloca este widget en la parte mas alta en el arbol de widget
      providers: [
        ChangeNotifierProvider(create: (_) => new NewsService()),
      ],
      child: MaterialApp(
        theme: miTema, //Tema adquirido en el archivo tema. Con ayuda de la clase ThemeData
        debugShowCheckedModeBanner: false,
        title: 'Noticias',
        home: TabsPage() //Inicias con el Widget TabsPage que nos servira como contenedor para los Wodget Tabs 1 y 2 (no son muchos) usando PageView
      ),
    );
  }
}