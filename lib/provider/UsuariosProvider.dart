import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_again/provider/ProdutosProvider.dart';
import 'package:firebase_again/provider/UsuariosModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsuariosProvider extends ChangeNotifier {
  bool logado = false;
  get online => this.logado;
  // set online(online) => this._logado = online;

//aqui vai ser as chamadas para inserção no banco de dados e o notifyAll;
  Firestore db = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  DocumentReference ref;
  ProdutosProvider produtosProvider = ProdutosProvider();
  UsuariosModel usuariosModel;
  Future<bool> addUsuario(UsuariosModel usuarioModel) async {
    Map<String, dynamic> data = {
      "id": "" + "Not Defined",
      "nome": "" + usuarioModel.nome,
      "cpf": "" + usuarioModel.cpf,
      "email": usuarioModel.email,
      "senha": usuarioModel.senha,
      "cargo": usuarioModel.cargo
    };
    try {
      auth.createUserWithEmailAndPassword(
          email: usuarioModel.email, password: usuarioModel.senha);
    } on PlatformException catch (e) {
      print(e);
    }
    var email = await db
        .collection("usuarios")
        .where("email", isEqualTo: usuarioModel.email)
        .getDocuments();

    var cpf = await db
        .collection("usuarios")
        .where("cpf", isEqualTo: usuarioModel.cpf)
        .getDocuments();

    print("aqui embaixo");
    print(cpf.documents.length);
    if (email.documents.length == 0 && cpf.documents.length == 0) {
      ref = await db.collection("usuarios").add(data);
      usuarioModel.id = ref.documentID;
      updateUsuarios(usuarioModel);
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  void removeUsuario(UsuariosModel usuariosModel) {
    db.collection("usuarios").document(usuariosModel.id).delete();
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUsuario(id) async {
    DocumentSnapshot snapshot =
        await db.collection("usuarios").document(id).get();
    return snapshot.data;
  }

  Future<List<DocumentSnapshot>> getUsuarios() async {
    QuerySnapshot querySnapshot =
        await db.collection("usuarios").getDocuments();
    return querySnapshot.documents.toList();
  }

  Future<List<DocumentSnapshot>> getListUsuarios() async {
    QuerySnapshot querySnapshot =
        await db.collection("usuarios").getDocuments();
    return querySnapshot.documents.toList();
  }

  void updateUsuarios(UsuariosModel usuariosModel) {
    Map<String, dynamic> data = {
      "id": usuariosModel.id,
      "nome": usuariosModel.nome,
      "cpf": usuariosModel.cpf,
      "email": usuariosModel.email,
      "senha": usuariosModel.senha,
      "cargo": usuariosModel.cargo
    };

    db.collection("usuarios").document(usuariosModel.id).updateData(data);
    notifyListeners();
  }

  Future<bool> autenticar(email, senha) async {
    var senhaCripto = criptografar(senha);

    var usuario = await db
        .collection("usuarios")
        .where("email", isEqualTo: email)
        .where("senha", isEqualTo: senhaCripto)
        .getDocuments();
    if (usuario.documents.length == 1) {
      return true;
    } else {
      return false;
    }
  }

  String criptografar(senha) {
    return md5.convert(utf8.encode(senha)).toString();
  }

  List<Map<String, dynamic>> conversor(snapshot) {
    List<Map<String, dynamic>> novo = List<Map<String, dynamic>>();

    for (DocumentSnapshot item in snapshot.data) {
      novo.add(item.data);
    }
    print("aqui");
    print(novo[0].toString());
    return novo;
  }

  void visible() {
    UsuariosModel.passVisible = !UsuariosModel.passVisible;
    print(UsuariosModel.passVisible);
    notifyListeners();
  }

  Future<bool> verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();

    if (usuarioLogado != null) {
      return true;
    } else {
      auth.signOut();
      return false;
    }
  }

  void logar(logar) {
    logado = logar;
  }
}
