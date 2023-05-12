import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manipulacao_json/model/FilmeModel.dart';
import 'package:manipulacao_json/pages/DetalhesFilmePage.dart';

import '../pages/FilmePage.dart';

class FilmePage extends StatefulWidget {
  const FilmePage({Key? key}) : super(key: key);

  @override
  _FilmePageState createState() => _FilmePageState();
}

class _FilmePageState extends State<FilmePage> {
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/images/icons/icon_filme.png',
                      width: 180.0,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                'Filmes',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text('${_foundMovie.length} registros'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                //Texto da searchbox
                hintText: "Pesquisar",
                suffixIcon: const Icon(Icons.search),
                // prefix: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //buildAlphabetSection(),
            Expanded(
              child: Visibility(
                visible: _foundMovie.isEmpty,
                child: const Text(
                  'Não foi encontrado resultados, tente de outra maneira',
                  style: TextStyle(fontSize: 16),
                ),
                replacement: ListView.builder(
                  itemCount: alphabet.length,
                  itemBuilder: (BuildContext context, int index) {
                    final letter = alphabet[index];
                    final productsStartingWithLetter = _foundMovie
                        .where((product) =>
                            product['nome_filme'].startsWith(letter))
                        .toList();
                    if (productsStartingWithLetter.isEmpty) {
                      return Container();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Color.fromARGB(255, 203, 236, 184),
                          height: 50.0,
                          margin: EdgeInsets.only(top: 5.0),
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Text(
                                letter,
                                style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: productsStartingWithLetter.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final filmes = productsStartingWithLetter[index];
                            final nomeFilme = filmes['nome_filme'];
                            final diretor = filmes['diretor'];
                            final id = filmes['id'];

                            if (id != null) {
                              return GestureDetector(
                                child: ListTile(
                                  title: Text(nomeFilme),
                                  subtitle: Text('$diretor'),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    //Através do widget de construção de detalhes: filme
                                    //É passado para ele o filme correspondente da row em questão "filmes"
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetalhesFilmePage(filme: filmes),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Column(
                                children: [
                                  if (index !=
                                      productsStartingWithLetter.length - 1)
                                    Divider(),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
