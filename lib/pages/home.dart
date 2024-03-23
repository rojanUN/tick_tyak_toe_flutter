import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> board = List.filled(9, '');
  bool oTurn = false;

  void markCell(int index) {
    if (board[index] == '') {
      setState(() {
        board[index] = oTurn ? 'O' : 'X';
        oTurn = !oTurn;
      });
    }
    checkGameStatus();
  }

  void checkGameStatus() {
    const winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 2, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] != '' &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[1]] == board[combo[2]]) {
        showWinnerDialog(board[combo[0]]);
        return;
      }
    }
    if(!board.contains('')){
      showDrawDialog();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TicTacToe',
          style: TextStyle(
              fontFamily: 'colorful', color: Color(0xFFFF2079), fontSize: 50),
        ),
        backgroundColor: const Color(0xff04005e),
        actions: [
          IconButton(onPressed: () {resetGame();}, icon: Icon(Icons.refresh_outlined), iconSize: 50, color: Color(0xFFFF2079),)
        ],
      ),
      body: Container(
          color: const Color(0xff04005e),
          child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => markCell(index),
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Color(0xffe92efb))),
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  void showDrawDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('game Draw' , style: TextStyle(fontSize: 60),),
            actions: [
              ElevatedButton(onPressed:() {
                Navigator.pop(context);
              }, child: const Text('ok', style: TextStyle(fontSize: 40),)),
              ElevatedButton(onPressed: () {
                resetGame();
                Navigator.pop(context);
              }, child: const Text('Reset', style: TextStyle(fontSize: 40),))
            ],
          );
        });
  }

  void showWinnerDialog(String winner) {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Game Over', style: TextStyle(fontSize: 60),),
            content: Text('player $winner wins', style: const TextStyle(fontSize: 60),),
            actions: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text('OK', style: TextStyle(fontSize: 40),)),
              ElevatedButton(onPressed: () {
                resetGame();
                Navigator.pop(context);
              }, child: const Text('Reset', style: TextStyle(fontSize: 40),))
            ],
          );
        });
  }
  void resetGame(){
    setState(() {
      board = List.filled(9, '');
      oTurn = false;
    });
  }
}
