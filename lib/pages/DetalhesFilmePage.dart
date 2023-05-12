import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:manipulacao_json/model/FilmeModel.dart';
import '../main.dart';

//Widget para criar tabela
Widget createDataTable(List<String> keys, List<dynamic> values) {
  List<DataColumn> columns = [
    DataColumn(label: Text('aas')),
    DataColumn(label: Text('dd')),
  ];

  List<DataRow> rows = List.generate(keys.length, (index) {
    var pair = [keys[index], values[index]];
    return DataRow(
        cells: pair.map((value) => DataCell(Text(value.toString()))).toList());
  });

  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: DataTable(
      columnSpacing: 30,
      headingRowHeight: 0,
      columns: columns,
      rows: rows,
      dataRowHeight: 60,
    ),
  );
}

class DetalhesFilmePage extends StatefulWidget {
  final Map<String, dynamic> filme;

  const DetalhesFilmePage({Key? key, required this.filme}) : super(key: key);

  @override
  _DetalhesFilmePageState createState() => _DetalhesFilmePageState();
}

class _DetalhesFilmePageState extends State<DetalhesFilmePage> {
  Map<String, dynamic> _movie = {};

  List<Map<String, dynamic>> _foundProducts = [];

  /******************************************************************************************************** */
  List<Map<String, dynamic>> _allMovies = [];
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/FilmeJson.json');
    final data = await json.decode(response);

    //Converte o JSON em uma lista de objetos

    final List<dynamic> itemsJson = data['filme'];
    _allMovies =
        itemsJson.map((json) => Map<String, dynamic>.from(json)).toList();
  }

  bool _isInformacoesActive = true;
  bool _isTabelaVisivel = true;
  List<String> _produtoKeys = ['Nome do Filme', 'Diretor'];

  List<dynamic> _produtoValues = [];

  @override
  //Inicia o estado da aplicação preenchendo os valores correspondentes do filme passado pela página FilmePage de acordo com o item clicado
  void initState() {
    super.initState();
    _movie = widget.filme;
    _produtoValues = [
      _movie['nome_filme'],
      _movie['diretor'],
    ];
    _isTabelaVisivel = _isInformacoesActive;
    _movie['id'];
    _movie['cartaz'];

    readJson().then((_) {
      setState(() {
        _foundProducts = _allMovies;
      });
    });
  }

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
              backgroundColor: Color.fromARGB(
                  255, 203, 236, 184), //Background color da header
            ),
          ),
        ),
        backgroundColor:
            Color(0xFFF6F7F5), //Cor do background da tela principal
        body: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              // código para exibir as informações de aplicação...
              Flexible(
                child: Stack(
                  children: [
                    //Aplica operador ternário para verificar qual imagem apresentar
                    Image(
                      image: _movie['cartaz'] != null &&
                              _movie['cartaz'].isNotEmpty
                          ? AssetImage('assets/images/${_movie['cartaz']}')
                          : AssetImage('assets/images/no_image.jpg'),
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
              //Construção da tabela passando as chaves e valores correspondentes
              Expanded(
                child: Visibility(
                  visible: _isInformacoesActive,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        createDataTable(_produtoKeys, _produtoValues),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // Método para navegar para a HomePage
  void _navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
