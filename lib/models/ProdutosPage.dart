import 'package:firebase_again/provider/ProdutosModel.dart';
import 'package:firebase_again/provider/ProdutosProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutosPage extends StatefulWidget {
  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  int qtd = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Produtos",
            style: TextStyle(color: Color(0xff1b2064)),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color(0xff1b2064),
          )),
      body: Consumer<ProdutosProvider>(
        builder: (context, produtosProvider, child) {
          return _listView(produtosProvider);
        },
      ),
      backgroundColor: Color(0xff1b2064),
    );
  }

  _listView(ProdutosProvider produtosProvider) {
    return FutureBuilder(
        future: produtosProvider.getProdutos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else
            // print(produtosProvider.conversor(snapshot).toString());

            // return Container();

            return GridView.builder(
              itemCount: produtosProvider.conversor(snapshot).length,
              itemBuilder: (context, index) {
                // print(index);
                return Consumer<ProdutosProvider>(
                  builder: (context, produtosProvider, child) => _itemList(
                      context,
                      ProdutosModel.fromJson(
                          produtosProvider.conversor(snapshot)[index]),
                      produtosProvider),
                );
              },
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            );
        });
  }

  _itemList(BuildContext context, ProdutosModel produtosModel,
      ProdutosProvider provider) {
    // print(produtosModel.descricao);
    return ListTile(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new CupertinoAlertDialog(
            content: new Container(
              width: 40.0,
              child: Column(
                children: <Widget>[
                  Text(
                    "Descrição:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\n${produtosModel.descricao}",
                    style: TextStyle(fontSize: 15),
                  ),
                  Column(
                    children: <Widget>[
                      Divider(),
                      FlatButton.icon(
                        icon: Icon(Icons.arrow_drop_up),
                        label: Text(''),
                        onPressed: () {
                          provider.addQuantidade(produtosModel);
                        },
                      ),
                      Center(
                          child:
                              Text("${provider.getQuantidade(produtosModel)}")),
                      FlatButton.icon(
                        icon: Icon(Icons.arrow_drop_down),
                        label: Text(""),
                        onPressed: () {
                          provider.removeQuantidade(produtosModel);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancelar",
                  style: TextStyle(fontSize: 10),
                ),
                onPressed: () {
                  provider.zeraQuantidade(produtosModel);
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                onPressed: () {},
                child: Text(
                  "Adicionar ao Carrinho",
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
        );
      },
      title: Image.network(produtosModel.imagemDir),
      subtitle: Center(
        child: Text(
          produtosModel.nome,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
