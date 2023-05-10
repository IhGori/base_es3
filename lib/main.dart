// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'pages/FilmePage.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized(); -> É uma função que garante que o binding de widgets do Flutter foi inicializado antes de qualquer outra coisa acontecer no aplicativo.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Named Routes',
      initialRoute: '/',
      routes: {
        //Quando navegar para "/" route, construir a Tela Inicial
        '/': (context) => HomePage(),
        '/filmes': (context) => FilmePage(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), //Tamanho da header
        child: SafeArea(
          child: AppBar(
            //Icon menu
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 35,
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'ES3',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/icons/meme_doge_dog.png',
                    fit: BoxFit.contain,
                    height: 82,
                  ),
                ],
              ),
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
            ),

            elevation: 5, //Sombreamento da Header
            backgroundColor:
                Color.fromARGB(255, 203, 236, 184), //Background color da header
          ),
        ),
      ),
      backgroundColor: Color(0xFFF6F7F5), //Cor do background da tela principal
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: GridView.count(
            crossAxisCount: 3, //Quantidade itens por linha
            childAspectRatio: 0.8, //relação largura:altura dos itens
            mainAxisSpacing: 25.0, //espaçamento vertical entre os itens
            crossAxisSpacing: 0.0, //espaçamento horizontal entre os itens
            padding:
                EdgeInsets.all(10.0), //espaçamento personalizado para cada card
            children: <Widget>[
              //Criar novos cards do menu principal
              //MyMenu(title: "NomeDoCard", icon: Icons."NomeDoIcon", iconColor: Colors."Cor")
              MyMenu(
                title: "Filmes",
                img: Image.asset('assets/images/icons/icon_filme.png'),
                index: 1,
              ),
            ],
          ),
        ),
      ),
      drawer: NavigationDrawer(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Color(0xFFF6F7F5),
        width: double.infinity,
        padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 70, //Tamanho do header do sidebar
              decoration: BoxDecoration(
                //shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/icons/meme_doge_dog.png')), //DecorationImage
              ), //BoxDecoration
            ), //Container
            Text(
              "Cinema",
              style: TextStyle(
                  color: Color(0xFF000000), fontSize: 20, letterSpacing: 5),
            ),
            Text(
              "Engenharia de Software 3",
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 14,
              ),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        color: Color(0xFFF6F7F5),
        child: Wrap(
          //runSpacing: 16,
          children: [
            const Divider(
              color: Colors.black54,
            ),
            ListTile(
              //Caso queira adicionar icon
              //leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              //Caso queira adicionar icon
              //leading: const Icon(Icons.home_outlined),
              title: const Text('Filmes'),
              onTap: () {
                Navigator.pushNamed(context, '/filmes');
              },
            ),
            //ListTile(
            //Caso queira adicionar icon
            //leading: const Icon(Icons.home_outlined),
            //title: const Text('Ajuda'),
            //onTap: () {
            // Navigator.pushNamed(context, '/ajuda');
            // },
            //),
          ],
        ),
      );
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.img, this.index});
  final String? title;
  final Image? img;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFE6F1DF),
      child: InkWell(
        onTap: () {
          selectedItem(context, index!);
        },
        splashColor: Color.fromARGB(255, 159, 209, 130),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                child: img,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FilmePage(),
      ));
      break;
  }
}
