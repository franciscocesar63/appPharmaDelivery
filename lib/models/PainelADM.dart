import 'package:flutter/material.dart';

class PainelADM extends StatelessWidget {
  var usuario;

  PainelADM({this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login")),
      ),
    );
  }
}
