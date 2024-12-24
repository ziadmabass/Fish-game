import 'package:flutter/material.dart';
import 'package:smka/smka.dart';
void main() {
  runApp(const Smka());
}
class Smka extends StatelessWidget {
  const Smka({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FishGame(),
    );
  }
}