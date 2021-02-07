import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';

//Clase Tab que sirve como contenedor donde mostraremos con ayuda de un PageView la vista Tab1 y Tab2
class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /** Aquí se declara quien ocupara el Widget padre(ese widget es el ChangeNotifierProvider) de los Widget Hijos que contienen los providers de comunicacion. En este caso recordemos que
     * esos widget son los ButtonNavigationBar y el PageView **/
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(), //Instanciamos la clase para que tenga valores si no ocurrira un error esto seria como datos default, pero no afectara en el controller ya que por default tiene el indice 0 y comenzara en la pagina 1
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  
  final navegacionModel = Provider.of<_NavegacionModel>(context);//Accedemos a la clase Provider de context de la clase _NavigationModel (recuerda que esta en el arbol por que lo instanciamos)
  
    return BottomNavigationBar( //Lista de botones creadas en la parte inferior de la pantalla
      //selectedItemColor: Colors.blue, ////Esto cambia el color de seleccion. El color rojo esta por default
      currentIndex: navegacionModel.paginaActial, //Indica en la lista de Items cual esta activado(esto lo marca)
      onTap: (i) => navegacionModel.paginaActual = i,//Aqui accedemos al metodo Set y le pasamos el valor que tomara para el pageView y agregandolo a su controller
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Para ti')),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Encabezados')),
      ]
      );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);//Accedemos a la clase Provider de context de la clase _NavigationModel (recuerda que esta en el arbol por que lo instanciamos)

    return PageView(
      pageSnapping: false,
      controller: navegacionModel.pageController,//Aqui accedemos al meto Get que nos da el controller con los valores que obtuvo del Setter ejecutado por los botones
      //physics: BouncingScrollPhysics(), //Aqui cambiamos el efecto de tope de desplazamiento. Osea cuando deslizamos y no hay mas cambia el sombreado tipico que vemos en un scroll
      physics: NeverScrollableScrollPhysics(), //Deshabilita la opcion de desplazamiento del PageView
      scrollDirection: Axis.horizontal, //Cambiamos el modo de desplazamiento horizontalmente
      children: [
        Tab1Page(),
        Tab2Page()
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{ //Esto es de flutter y lo en lo que nos ayuda es que notifica a los widget para que se redibujen

  int _paginaActual = 0; //variable privada
  PageController _pageController = new PageController();//Creammos un controller para el PageView el cual contendra el valor de la pagina su duracion y la animacion de desplazamiento

  int get paginaActial => this._paginaActual;//Metodo Get para acceder al valor de la variable

  set paginaActual(int valor){ //Metodo Set el cual modificaremos cada vez que se haga clic en uno de los botones de ButtomNavigation. El Set pide por parametro el valor que se dara asi lo dice la documentacion
    this._paginaActual = valor;//aqui declaramos el valor

    _pageController.animateToPage(//aqui esta el controller. Recordemos que esta en privado
      valor,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut
    );
  
    notifyListeners(); //Los widget recibira este controlador el cual contiene este notify el cual los obligara a redibujarse

  }
  
  PageController get pageController => this._pageController; //Accedemos por un metodo Get al controller, el cual obtendra el PageView para sus propiedades necesarias para su correcto funcionamiento

}