class ProdutosModel {
  String _id;
  String _nome;
  String _descricao;
  String _imagemDir;
  double _preco;
  int _quantidade = 0;
  int _quantidadeAdd = 0;

  ProdutosModel(id, nome, descricao, imagemDir, preco, quantidade) {
    this._id = id;
    this._nome = nome;
    this._descricao = descricao;
    this._imagemDir = imagemDir;
    this._preco = preco;
    this._quantidade = quantidade;
  }

  set id(id) => this._id = id;

  set nome(nome) => this._nome = nome;

  set descricao(descricao) => this._descricao = descricao;

  set imagemDir(imagemDir) => this._imagemDir = imagemDir;

  set preco(preco) => this._preco = preco;

  set quantidade(quantidade) => this._quantidade = quantidade;
  
  set quantidadeAdd(quantidadeAdd) => this._quantidadeAdd = quantidadeAdd;

  get id => this._id;

  get nome => this._nome;

  get descricao => this._descricao;

  get imagemDir => this._imagemDir;

  get preco => this._preco;

  get quantidade => this._quantidade;

  get quantidadeAdd => this._quantidadeAdd;

  ProdutosModel.fromJson(Map<String, dynamic> json) {
    preco = json['preco'];
    imagemDir = json['imagemDir'];
    nome = json['nome'];
    id = json['id'];
    quantidade = json['quantidade'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['preco'] = this.preco;
    data['imagemDir'] = this.imagemDir;
    data['nome'] = this.nome;
    data['id'] = this.id;
    data['quantidade'] = this.quantidade;
    data['descricao'] = this.descricao;
    return data;
  }
}
