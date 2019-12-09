import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_again/login/Login.dart';
import 'package:firebase_again/models/CadastrarPage.dart';
import 'package:firebase_again/models/Carrinho.dart';
import 'package:firebase_again/models/PainelADM.dart';
import 'package:firebase_again/models/ProdutosPage.dart';
import 'package:firebase_again/provider/UsuariosProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaPrincipal extends StatelessWidget {
  UsuariosProvider usuarios = UsuariosProvider();
  bool logado = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff1b2064)),
        title: Image(
          image: AssetImage("assets/img/2.png"),
        ),
        backgroundColor: Colors.white,
      ),
      body: _body(),
      backgroundColor: Color(0xff1b2064),
      drawer: Consumer<UsuariosProvider>(
          builder: (context, UsuariosProvider usuariosProvider, chld) {
        return _drawer(context, usuariosProvider);
      }),
    );
  }

  // Future<bool> verifica() async {
  //   bool x = await usuarios.verificarUsuarioLogado();
  //   return x;
  // }

  _drawer(context, usuariosProvider) {
    // print(logado);
    // verifica().then((value) {
    //   // print("aqui");
    //   // print(usuariosProvider.logado);
    //   usuariosProvider.logar(value);
    // });
    // print(logado);

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Center(
            child: Image.asset(
              "assets/img/2.png",
              width: 270,
            ),
          ),
          Divider(),
          Text(
              "------------------------------------------------------------------------------"),
          Divider(),
          _flatButton(
              "Início", Icon(Icons.person_add), context, TelaPrincipal()),
          _flatButton(
              "Produtos", Icon(Icons.access_alarm), context, ProdutosPage()),
          _flatButton("Carrinho de Compras", Icon(Icons.shopping_cart), context,
              CarrinhoPage()),
          _flatButton("Login", Icon(Icons.person_add), context, Login()),
          _flatButton(
              "Cadastre-se", Icon(Icons.person_add), context, CadastrarPage()),
          _flatButton("Painel Administrativo", Icon(Icons.person_add), context,
              PainelADM()),
          _flatButtonSair("Sair", Icon(Icons.exit_to_app), context)
        ],
      ),
    );
  }

  _flatButtonSair(label, icon, context) {
    return AbsorbPointer(
      absorbing: false,
      child: FlatButton.icon(
        onPressed: () {
          FirebaseAuth auth = FirebaseAuth.instance;
          auth.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        icon: icon,
        label: Text(
          label,
          style: TextStyle(
            color: Color(0xff1b2064),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  _flatButton(label, icon, context, page) {
    return AbsorbPointer(
      absorbing: false,
      child: FlatButton.icon(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        icon: icon,
        label: Text(
          label,
          style: TextStyle(
            color: Color(0xff1b2064),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  _body() {
    final List<String> imgList = [
      "assets/img/carousel/1.jpg",
      "assets/img/carousel/2.jpg",
      "assets/img/carousel/3.jpg",
      "assets/img/carousel/4.jpg",
    ];

    return Column(
      children: <Widget>[
        CarouselSlider(
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          autoPlay: true,
          enlargeCenterPage: true,
          height: 300,
          items: imgList.map(
            (url) {
              return Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
