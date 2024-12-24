import 'dart:math';
import 'package:flutter/material.dart';

class FishGame extends StatefulWidget {
  @override
  _FishGameState createState() => _FishGameState();
}

class _FishGameState extends State<FishGame> {
  Offset fishPosition = Offset(100, 100);
  List<Offset> ballPositions = List.generate(
      10,
      (index) =>
          Offset(Random().nextDouble() * 300, Random().nextDouble() * 600));
  double fishSize = 60;
  double ballSize = 60;
  int score = 0;
  List<Offset> newBallPositions = List.generate(
      5,
      (index) =>
          Offset(Random().nextDouble() * 300, Random().nextDouble() * 600));

  void _restartGame() {
    setState(() {
      fishPosition = Offset(100, 100);
      ballPositions = List.generate(
          10,
          (index) =>
              Offset(Random().nextDouble() * 300, Random().nextDouble() * 600));
      newBallPositions = List.generate(
          5,
          (index) =>
              Offset(Random().nextDouble() * 300, Random().nextDouble() * 600));
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/water.jpg"), fit: BoxFit.cover)),
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              fishPosition = Offset(fishPosition.dx + details.delta.dx,
                  fishPosition.dy + details.delta.dy);
              ballPositions.removeWhere((ball) {
                bool isEaten =
                    (fishPosition - ball).distance < (fishSize + ballSize) / 2;
                if (isEaten) {
                  score++;
                }
                newBallPositions.removeWhere((ball) {
                  bool isEaten = (fishPosition - ball).distance <
                      (fishSize + ballSize) / 2;
                  if (isEaten) {
                    score--;
                  }
                  return isEaten;
                });
                return isEaten;
              });

              if (ballPositions.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Congratulations!'),
                    content: Text(
                        'You have eaten all the balls. Your score is $score.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _restartGame();
                        },
                        child: Text('Restart'),
                      ),
                    ],
                  ),
                );
              }
            });
          },
          child: Stack(
            children: [
              Positioned(
                  left: fishPosition.dx,
                  top: fishPosition.dy,
                  child: Container(
                    width: fishSize,
                    height: fishSize,
                    child: Image.asset('images/fish.png'),
                  )),
              ...ballPositions.map((ball) => Positioned(
                    left: ball.dx,
                    top: ball.dy,
                    child: Container(
                      width: ballSize,
                      height: ballSize,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                              image: AssetImage("images/lolo.png")),
                          shape: BoxShape.circle),
                    ),
                  )),
              ...newBallPositions.map((ball) => Positioned(
                    left: ball.dx,
                    top: ball.dy,
                    child: Container(
                      width: ballSize,
                      height: ballSize,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                              image: AssetImage("images/boom.png")),
                          shape: BoxShape.circle),
                    ),
                  )),
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
