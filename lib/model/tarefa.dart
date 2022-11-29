class Tarefa {
  int id;
  String nome;

  Tarefa(this.nome, {this.id = 0});

  @override
  String toString() {
    return 'Tarefa{id: $id, nome: $nome';
  }
}