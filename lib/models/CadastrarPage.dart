import 'package:firebase_again/provider/UsuariosModel.dart';
import 'package:firebase_again/provider/UsuariosProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CadastrarPage extends StatefulWidget {
  @override
  _CadastrarPageState createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  TextEditingController login = TextEditingController();

  TextEditingController senha = TextEditingController();
  TextEditingController nome = TextEditingController();
  var cpf = new MaskedTextController(mask: '000.000.000-00');
  var passVisible = true;

  UsuariosProvider usuariosProvider = UsuariosProvider();
  var _mensagemErro = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b2064),
      appBar: AppBar(
          title: Text(
            "Cadastrar-se",
            style: TextStyle(color: Color(0xff1b2064)),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color(0xff1b2064),
          )),
      body: _cadastro(),
    );
  }

  _cadastro() {
    return Column(
      children: <Widget>[
        //Login
        Container(
          color: Colors.white,
          child: TextField(
            controller: login,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "E-Mail",
              prefixIcon: Icon(Icons.supervised_user_circle),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        //senha
        Container(
          color: Colors.white,
          child: TextField(
            controller: senha,
            autocorrect: false,
            obscureText: passVisible ? true : false,
            decoration: InputDecoration(
              labelText: "Senha",
              prefixIcon: Icon(Icons.supervised_user_circle),
              suffixIcon: IconButton(
                icon: passVisible
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passVisible = !passVisible;
                  });
                },
              ),
            ),
          ),
        ),
        //cpf
        Container(
          color: Colors.white,
          child: TextField(
            controller: nome,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Nome Completo",
              prefixIcon: Icon(Icons.dock),
            ),
            keyboardType: TextInputType.text,
          ),
        ),

        //cpf
        Container(
          color: Colors.white,
          child: TextField(
            controller: cpf,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "CPF",
              prefixIcon: Icon(Icons.dock),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: new RaisedButton(
              child: Column(
                children: <Widget>[
                  new Text(
                    'Confirmar',
                    style: TextStyle(
                        color: Color(0xff1b2064), fontWeight: FontWeight.bold),
                  ),
                  Text("$_mensagemErro"),
                ],
              ),
              onPressed: () {
                _validarCampos();
              }),
        ),
      ],
    );
  }

  Future _cadastrarUsuario(
      TextEditingController email,
      TextEditingController senha,
      TextEditingController nome,
      MaskedTextController cpf) async {
    String senhaCriptografada = usuariosProvider.criptografar(senha.text);
    UsuariosModel usuarioModel = UsuariosModel(
        "1", nome.text, cpf.text, email.text, senhaCriptografada, "usuario");
    var resultado = await usuariosProvider.addUsuario(usuarioModel);
    print("resultado $resultado");
    return resultado;
  }

  _finish(label) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context)=> new CupertinoAlertDialog(
        content: new Container(
          width: 40.0,
          child: Column(
            children: <Widget>[
              Text(
                label,
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

  _validarCampos() {
    //Recupera dados dos campos
    String email = login.text;
    String senhaValida = senha.text;

    if (email.isNotEmpty && email.contains("@") && email.contains(".")) {
      if (senhaValida.isNotEmpty && senhaValida.length > 6) {
        setState(() {
          _mensagemErro = "";
        });

         _cadastrarUsuario(login, senha, nome, cpf) as bool;

        _finish("Usuario cadastrado com Sucesso!!");
        
      } else {
        _finish("Houve um erro ao realizar o cadastro!");
        if (senhaValida.length < 6) {
          setState(() {
            _mensagemErro = "A senha precisa de 6 dígitos!";
          });
        }

        setState(() {
          _mensagemErro = "Preencha a senha!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail utilizando @";
      });
    }
  }
}
