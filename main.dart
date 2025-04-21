import 'package:flutter/material.dart';
import 'screens/clientes_screen.dart';

void main() {
  runApp(CeramicaApp());
}

class CeramicaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cerámica Clientes',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: ClientesScreen(),
    );
  }
}