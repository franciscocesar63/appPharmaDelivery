import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_again/models/PainelADM.dart';
import 'package:firebase_again/provider/UsuariosModel.dart';
import 'package:firebase_again/provider/UsuariosProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();
  Firestore db = new Firestore();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b2064),
      appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(color: Color(0xff1b2064)),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color(0xff1b2064),
          )),
      body: Consumer<UsuariosProvider>(
        builder: (context, usuariosProvider, child) {
          return _login(context, usuariosProvider);
        },
      ),
    );
  }

  _login(context, usuarios) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //   color: Colors.white,
          //     borderRadius: BorderRadius.circular(90),
          //   ),
          //   child: SizedBox(
          //     width: 200,
          //     child: Image.asset(
          //       "assets/img/logo_sem_nome.png",
          //     ),
          //   ),
          // ),
          // Divider(),

          //Login
          Container(
            color: Colors.white,
            child: TextFormField(
              controller: _email,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "E-Mail",
                prefixIcon: Icon(Icons.supervised_user_circle),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  value.isEmpty ? 'Por favor, digite um email válido' : null,
              onSaved: (value) =>
                  _email = value.trim() as TextEditingController,
            ),
          ),
          //senha

          Container(
            color: Colors.white,
            child: TextFormField(
              controller: _senha,
              autocorrect: false,
              obscureText: UsuariosModel.passVisible ? true : false,
              decoration: InputDecoration(
                labelText: "Senha",
                prefixIcon: Icon(Icons.supervised_user_circle),
                suffixIcon: IconButton(
                  icon: UsuariosModel.passVisible
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    usuarios.visible();
                  },
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'A senha não pode estar vazia' : null,
              onSaved: (value) =>
                  _senha = value.trim() as TextEditingController,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: new RaisedButton(
              child: new Text(
                'Entrar',
                style: TextStyle(
                    color: Color(0xff1b2064), fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                var resultado =
                    await usuarios.autenticar(_email.text, _senha.text);
                if (resultado) {
                  await _finish("Login efetuado com Sucesso!", context);

                  var usuario = db
                      .collection("usuarios")
                      .where("email", isEqualTo: _email)
                      .where("senha",
                          isEqualTo: usuarios.criptografar(_senha.text))
                      .snapshots();

                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PainelADM(
                                usuario: usuario,
                              )));
                } else {
                  _finish("E-Mail ou Senha Incorretos!", context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _finish(resultado, context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        content: new Container(
          width: 40.0,
          child: Column(
            children: <Widget>[
              Text(
                resultado,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text("OK"))
        ],
      ),
    );
  }
}
