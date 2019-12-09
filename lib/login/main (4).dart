import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // Firestore db = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "pdanyllo7@gmail.com";
  String senha = "123456";

  auth
      .createUserWithEmailAndPassword(email: email, password: senha)
      .then((firebaseUser) {
    print("novo usuario: sucesso!! E-mail: " + firebaseUser.user.email);
  }).catchError((erro) {
    print("novo Usuario Erro " + erro.toString());
  });

// // SALVAR E ATUALIZAR DADOS FIRESTORE
//   db.collection("usuarios")
//   .document("002")
//   .setData(
//     {
//       "nome" : "Ana Maria",
//       "idade" : 25
//     }
//   );

// // recuperando o documenteID
//   DocumentReference reference = await db.collection("noticias")
//   .add({
//     "titulo": "Novo planeta é descoberto!",
//     "descricao": "texto de exemplo..."
//     });

//     print("Item salvo: " + reference.documentID);

// // atualizando dados
//     db.collection("noticias")
//     .document("7aWcjfdn8SXq7Ly1Dm8I")
//     .setData(
//       {
//         "titulo" : "ondas de calor em São Paulo alterado",
//        "descricao" : "texto de exemplo..."
//       }
//     );

// db.collection("usuarios")
// .document("003")
// .setData(
// {
//   "nome" : "Daniel",
//   "idade" : 19,

// }
// );

// //Remover usuarios
// db.collection("usuarios").document("003").delete();

// //Recuperar os dados
// DocumentSnapshot snapshot = await db.collection("usuarios")
//   .document("002")
//   .get();

// var dados = snapshot.data;

// print("dados nome: " + dados["nome"] + " idade: " + dados["idade"]);

// //buscar todos os usuarios
// QuerySnapshot querySnapshot = await db
// .collection("usuarios").
// getDocuments();

// //listar todos os usuarios
// for ( DocumentSnapshot item in querySnapshot.documents) {
//   var dados = item.data;
//   print("dados usuarios: " + dados["nome"] + " - " + dados["idade"] );

// }
// db.collection("usuarios").snapshots().listen(
// (snapshot){
// for (DocumentSnapshot ds in snapshot.documents) {
//   var dados = ds.data;
//   print("dados usuarios: " + dados["nome"] + " - " + dados["idade"] );

// }

// }

// );

// //filtros basicos
//   QuerySnapshot querySnapshot = await db
//       .collection("usuarios")
//       //.where("nome", isEqualTo: "danylll").getDocuments();
// // .where("idade", isGreaterThan: 15).getDocuments();
//       //do menor para o maior
//       // .orderBy("idade", descending: false).getDocuments();
// //do maior para o menor
// //       .orderBy("idade", descending: true)
// //       .orderBy("nome", descending: false)
// .where("nome", isGreaterThanOrEqualTo: "an")
// .where("nome", isLessThanOrEqualTo: "an" + "\uf8ff")

//       .getDocuments();

//   for (DocumentSnapshot item in querySnapshot.documents) {
//     var dados = item.data;
//     print("filtro: nome: ${dados["nome"]}  idade: ${dados["idade"]}");
//   }

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(),
    );
  }
}
