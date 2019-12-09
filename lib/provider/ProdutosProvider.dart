import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_again/provider/ProdutosModel.dart';
import 'package:firebase_again/provider/UsuariosModel.dart';
import 'package:flutter/foundation.dart';

class ProdutosProvider extends ChangeNotifier {
//aqui vai ser as chamadas para inserção no banco de dados e o notifyAll;
  Firestore db = Firestore.instance;
  DocumentReference ref;

  void addProduto(ProdutosModel produtosModel) async {
    Map<String, dynamic> data = {
      "id": "" + produtosModel.id,
      "nome": "" + produtosModel.nome,
      "descricao": "" + produtosModel.descricao,
      "imagemDir": "" + produtosModel.imagemDir,
      "preco": produtosModel.preco,
      "quantidade": produtosModel.quantidade
    };
    ref = await db.collection("produtos").add(data);
    produtosModel.id = ref.documentID;

    updateProduto(produtosModel);
    notifyListeners();
  }

  void removeProduto(ProdutosModel produtosModel) {
    db.collection("produtos").document(produtosModel.id).delete();
    notifyListeners();
  }

  Future<Map<String, dynamic>> getProduto(id) async {
    DocumentSnapshot snapshot =
        await db.collection("produtos").document(id).get();
    return snapshot.data;
  }

  Future<List<DocumentSnapshot>> getProdutos() async {
    QuerySnapshot querySnapshot =
        await db.collection("produtos").getDocuments();
    return querySnapshot.documents.toList();
  }

  Future<List<DocumentSnapshot>> getListProdutos() async {
    QuerySnapshot querySnapshot =
        await db.collection("produtos").getDocuments();
    return querySnapshot.documents.toList();
  }

  void updateProduto(ProdutosModel produtosModel) {
    Map<String, dynamic> data = {
      "id": "" + produtosModel.id,
      "nome": "" + produtosModel.nome,
      "descricao": "" + produtosModel.descricao,
      "imagem": "" + produtosModel.imagemDir,
      "preco": produtosModel.preco,
      "quantidade": produtosModel.quantidade
    };

    db.collection("produtos").document(produtosModel.id).updateData(data);
    notifyListeners();
  }

  List<Map<String, dynamic>> conversor(snapshot) {
    List<Map<String, dynamic>> novo = List<Map<String, dynamic>>();

    for (DocumentSnapshot item in snapshot.data) {
      novo.add(item.data);
    }
    // print("aqui");
    // print(novo[0].toString());
    return novo;
  }

  void adicionarAoCarrinho(ProdutosModel produto, UsuariosModel usuariosModel) {
    usuariosModel.lista.add(produto);
    notifyListeners();
  }

  void addQuantidade(ProdutosModel produtosModel) {
    produtosModel.quantidadeAdd = produtosModel.quantidadeAdd + 1;
    print("quantidade: ${produtosModel.quantidadeAdd}");
    notifyListeners();
  }

  void removeQuantidade(ProdutosModel produtosModel) {
    produtosModel.quantidadeAdd = produtosModel.quantidadeAdd - 1;
    print("quantidade: ${produtosModel.quantidadeAdd}");
    notifyListeners();
  }

  void zeraQuantidade(ProdutosModel produtosModel) {
    produtosModel.quantidadeAdd = 0;
    notifyListeners();
  }

  int getQuantidade(ProdutosModel produtosModel) {
    return produtosModel.quantidadeAdd;
  }
}
