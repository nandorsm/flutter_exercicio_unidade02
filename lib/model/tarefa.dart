class Tarefa {
  int id;
  String nome;
  bool checked;

  Tarefa(this.nome, {this.id = 0, this.checked = false});

  @override
  String toString() {
    return 'Tarefa{id: $id, nome: $nome, checked: $checked}';
  }
}