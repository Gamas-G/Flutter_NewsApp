import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/models/category_model.dart';

//Con esta Clase realizaremos las peticiones http
class NewsService with ChangeNotifier{ //Debemos notificar a los providers asi que debemos usar la clase ChangeNotifier

  final _URL_NEWS = 'https://newsapi.org/v2';
  final _APIKEY = 'e9f9a5ffdb1d4bdb862c34bb0bd7bc4a';

  List<Article> headlines = []; //Creamos una lista de tipo Article(modelo que obtenemos de news_models en la carpeta models)
  String _selectedCategory = 'business';

  List<Category> categories = [ //Lista de categorias que utilizaremos en el Tab2
    Category( FontAwesomeIcons.building      , 'business'),
    Category( FontAwesomeIcons.tv            , 'entertainment'),
    Category( FontAwesomeIcons.addressCard   , 'general'),
    Category( FontAwesomeIcons.headSideVirus , 'health'),
    Category( FontAwesomeIcons.vials         , 'science'),
    Category( FontAwesomeIcons.volleyballBall, 'sports'),
    Category( FontAwesomeIcons.memory        , 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService(){
    
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor){

    this._selectedCategory= valor;
    this.getArticlesByCategory( valor );

    notifyListeners();
  }

  get getArticulosCategoriasSeleccionada => this.categoryArticles[ this.selectedCategory ];

  getTopHeadlines() async {
    
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx';//concatenamos la url
    final resp = await http.get(url); //aquí pedimos una peticion

    

    final newsResponse = newsResponseFromJson(resp.body);//con ayuda del news_models decodificamos el json con ayuda de este metodo, teneindo acceso a todos sus datos ya modelados

    this.headlines.addAll(newsResponse.articles);//agregadmos todos los headlines en nuestro areglo el cual estaremos utilizando en nuestra aplicacion gracias a este metodo get
    notifyListeners();//una vez conseguido la peticion notificamos
  }

  getArticlesByCategory( String category ) async{

    if(this.categoryArticles[category].length > 0){
      return this.categoryArticles[category];
    }
    
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx&category=$_selectedCategory';//concatenamos la url
    final resp = await http.get(url); //aquí pedimos una peticion

    

    final newsResponse = newsResponseFromJson(resp.body);//con ayuda del news_models decodificamos el json con ayuda de este metodo, teneindo acceso a todos sus datos ya modelados

    this.categoryArticles[category].addAll( newsResponse.articles );

    //this.headlines.addAll(newsResponse.articles);//agregadmos todos los headlines en nuestro areglo el cual estaremos utilizando en nuestra aplicacion gracias a este metodo get
    notifyListeners();//una vez conseguido la peticion notificamos
  }

}