import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tic_tac_toe/constantes.dart';

import 'alerta.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _placarX = 0;
  int _placarO = 0;
  bool _rodadaDeO = true;
  int _caixasPreenchidas = 0;
  final List<String> _xOuOLista = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _clearBoard();
            },
          )
        ],
        title: Text(
          'Jogo da Velha',
          style: kCustomText(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          _constroiTabelaDePontos(),
          _constroiGrade(),
          _constroiTurno(),
        ],
      ),
    );
  }

  Widget _constroiTabelaDePontos() {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Jogador O',
                    style: kCustomText(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _placarO.toString(),
                    style: kCustomText(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Jogador X',
                    style: kCustomText(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _placarX.toString(),
                    style: kCustomText(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _constroiGrade() {
    return Expanded(
      flex: 3,
      child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _clicado(index);
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[700])),
                child: Center(
                  child: Text(
                    _xOuOLista[index],
                    style: TextStyle(
                      color:
                          _xOuOLista[index] == 'x' ? Colors.white : Colors.red,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _constroiTurno() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _rodadaDeO ? 'Rodada de O' : 'Rodada de X',
            style: kCustomText(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _clicado(int index) {
    setState(() {
      if (_rodadaDeO && _xOuOLista[index] == '') {
        _xOuOLista[index] = 'o';
        _caixasPreenchidas += 1;
      } else if (!_rodadaDeO && _xOuOLista[index] == '') {
        _xOuOLista[index] = 'x';
        _caixasPreenchidas += 1;
      }

      _rodadaDeO = !_rodadaDeO;
      _checkTheWinner();
    });
  }

  void _checkTheWinner() {
    // check first row
    if (_xOuOLista[0] == _xOuOLista[1] &&
        _xOuOLista[0] == _xOuOLista[2] &&
        _xOuOLista[0] != '') {
      _showAlertDialog('Vencedor', _xOuOLista[0]);
      return;
    }

    // check second row
    if (_xOuOLista[3] == _xOuOLista[4] &&
        _xOuOLista[3] == _xOuOLista[5] &&
        _xOuOLista[3] != '') {
      _showAlertDialog('Vencedor', _xOuOLista[3]);
      return;
    }

    // check third row
    if (_xOuOLista[6] == _xOuOLista[7] &&
        _xOuOLista[6] == _xOuOLista[8] &&
        _xOuOLista[6] != '') {
      _showAlertDialog('Vemcedor', _xOuOLista[6]);
      return;
    }

    // check first column
    if (_xOuOLista[0] == _xOuOLista[3] &&
        _xOuOLista[0] == _xOuOLista[6] &&
        _xOuOLista[0] != '') {
      _showAlertDialog('Vencedor', _xOuOLista[0]);
      return;
    }

    // check second column
    if (_xOuOLista[1] == _xOuOLista[4] &&
        _xOuOLista[1] == _xOuOLista[7] &&
        _xOuOLista[1] != '') {
      _showAlertDialog('Vencedor', _xOuOLista[1]);
      return;
    }

    // check third column
    if (_xOuOLista[2] == _xOuOLista[5] &&
        _xOuOLista[2] == _xOuOLista[8] &&
        _xOuOLista[2] != '') {
      _showAlertDialog('Vencedor', _xOuOLista[2]);
      return;
    }

    // check diagonal
    if (_xOuOLista[0] == _xOuOLista[4] &&
        _xOuOLista[0] == _xOuOLista[8] &&
        _xOuOLista[0] != '') {
      _showAlertDialog('Vencedor', _xOuOLista[0]);
      return;
    }

    // check diagonal
    if (_xOuOLista[2] == _xOuOLista[4] &&
        _xOuOLista[2] == _xOuOLista[6] &&
        _xOuOLista[2] != '') {
      _showAlertDialog('Vencedor', _xOuOLista[2]);
      return;
    }

    if (_caixasPreenchidas == 9) {
      _showAlertDialog('Empate', '');
    }
  }

  void _showAlertDialog(String title, String winner) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == ''
            ? 'A partida terminou em empate'
            : 'O vencedor é ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
        });

    if (winner == 'o') {
      _placarO += 1;
    } else if (winner == 'x') {
      _placarX += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _xOuOLista[i] = '';
      }
    });

    _caixasPreenchidas = 0;
  }
}
