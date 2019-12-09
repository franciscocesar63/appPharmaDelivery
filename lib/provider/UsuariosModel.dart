import 'package:firebase_again/provider/ProdutosModel.dart';

class UsuariosModel {
  String _id;
  String _nome;
  String _cpf;
  String _imagemDir;
  String _email;
  String _senha;
  String _cargo;
  List<ProdutosModel> lista = new List<ProdutosModel>();
  static bool passVisible = true;
 
  UsuariosModel(id, nome, cpf, email, senha, cargo) {
    this._id = id;
    this._nome = nome;
    this._cpf = cpf;
    this._email = email;
    this._senha = senha;
    this._cargo = cargo;
  }


  set cargo(cargo) => this._cargo = cargo;

  set id(id) => this._id = id;

  set nome(nome) => this._nome = nome;

  set cpf(cpf) => this._cpf = cpf;

  set imagemDir(imagemDir) => this._imagemDir = imagemDir;

  set email(email) => this._email = email;

  set senha(senha) => this._senha = senha;

  get id => this._id;

  get nome => this._nome;

  get cargo => this._cargo;

  get cpf => this._cpf;

  get imagemDir => this._imagemDir;

  get email => this._email;

  get senha => this._senha;


  UsuariosModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    imagemDir = json['imagemDir'];
    nome = json['nome'];
    id = json['id'];
    senha = json['senha'];
    cpf = json['cpf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['imagemDir'] = this.imagemDir;
    data['nome'] = this.nome;
    data['id'] = this.id;
    data['senha'] = this.senha;
    data['cpf'] = this.cpf;
    return data;
  }

}
