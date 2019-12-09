import 'package:firebase_again/PageSplash.dart';
import 'package:firebase_again/models/TelaPrincipal.dart';
import 'package:firebase_again/provider/ProdutosProvider.dart';
import 'package:firebase_again/provider/UsuariosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProdutosProvider>.value(
          value: ProdutosProvider(),
        ),
        ChangeNotifierProvider<UsuariosProvider>.value(
          value: UsuariosProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Drogaria Nova Aliança',
        home: new PageSplash(),
        routes: <String, WidgetBuilder>{
          '/HomePage': (BuildContext context) => new TelaPrincipal()
        },
      ),
    );
  }
}
