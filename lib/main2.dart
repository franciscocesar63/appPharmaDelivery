import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  // Firestore db = Firestore.instance;

  // Map<String, dynamic> data = {"nome": "Cesar", "telefone": "123"};
  // print("opa");
  // db.collection("produtos").document("2").setData(data);
  // print("a");
  /*
  DocumentReference ref = await db.collection("noticias")
  .add(
      {
        "titulo" : "Ondas de calor em São Paulo",
        "descricao" : "texto de exemplo..."
      }
  );

  //print("item salvo: " + ref.documentID );
  
  db.collection("noticias")
  .document("-LhaOOJeVlsPbbAoZaql")
  .setData(
      {
        "titulo" : "Ondas de calor em São Paulo alterado",
        "descricao" : "texto de exemplo..."
      }
  );
  */

  //db.collection("usuarios").document("003").delete();

  /*
  DocumentSnapshot snapshot = await db.collection("usuarios")
      .document("001")
      .get();

  var dados = snapshot.data;
  //print("dados nome: " + snapshot.data.toString());
  print("dados nome: " + dados["nome"] + " idade: " + dados["idade"].toString() );
  
  
  QuerySnapshot querySnapshot = await db
      .collection("usuarios")
      .getDocuments();

  //print("dados usuarios: " + querySnapshot.documents.toString() );
  
  for( DocumentSnapshot item in querySnapshot.documents ){
    var dados = item.data;
    print("dados usuarios: " + dados["nome"] + " - " + dados["idade"].toString() );
  }
 
  
  listar usurarios e atualizar atomaticamente
  db.collection("usuarios").snapshots().listen(
      ( snapshot ){

        for( DocumentSnapshot item in snapshot.documents ){
          var dados = item.data;
          print("dados usuarios: " + dados["nome"] + " - " + dados["idade"].toString() );
        }

      }
  );

  */

/*
  QuerySnapshot querySnapshot = await db.collection("usuarios")
  //.where("nome", isEqualTo: "Bruno")
  //.where("idade", isEqualTo: 31)
  //.where("idade", isGreaterThan: 15)//< menor, > maior, >= maior ou igual, <= menor ou igual
  .where("idade", isLessThan: 30)
  //descendente (do maior para o menor) ascendente (do menor para o maior)
  .orderBy("idade", descending: true )
  //.orderBy("nome", descending: true )
  //.limit(1)
  .getDocuments();

  for( DocumentSnapshot item in querySnapshot.documents ){
    var dados = item.data;
    print("filtro nome: ${dados["nome"]} idade: ${dados["idade"].toString()}");
  }
*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RaisedButton(
        onPressed: () {
          _envia();
        },
        child: Text("Clica"),
      ),
    );
  }

  void _envia() {
    Firestore db = Firestore.instance;
    Map<String, dynamic> data = {"nome": "Francisco", "telefone": "123444"};
    print("opa");
    db.collection("produtos").document().setData(data);
    print("opa2");
  }
}
