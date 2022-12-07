import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/tarefa.dart';

Future<Database> getDatabase(){
  return getDatabasesPath().then((dbPath){
    final String path = join(dbPath, "tarefas30.db");
    return openDatabase(path, onCreate: (db, version) {
      db.execute("CREATE TABLE tarefas("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "nome TEXT, checked TEXT)");
    }, version: 1);
  });
}

Future<int> insert(Tarefa tarefa){
  return getDatabase().then((db){
    Map<String, dynamic> values = Map();
    values['nome'] = tarefa.nome;
    values['checked'] = tarefa.checked == true ? "true" : "false";
    return db.insert('tarefas', values);
  });
}

Future<int> update(Tarefa tarefa){
  return getDatabase().then((db){
    Map<String, dynamic> values = Map();
    values['nome'] = tarefa.nome;
    values['checked'] = tarefa.checked == true ? "true" : "false";
    return db.update('tarefas', values, where: "id = ?", whereArgs: [tarefa.id],);
  });
}

Future<List<Tarefa>> findAll(){
  return getDatabase().then((db){
    return db.query('tarefas').then((listMaps){
      List<Tarefa> tarefas = [];
      for(Map<String, Object?> map in listMaps){
        Tarefa tarefa = Tarefa(
          map['nome'] as String,
          id: map['id'] as int,
          checked: map['checked'] == "true" ? true : false,
        );
        tarefas.add(tarefa);
      }
      return tarefas;
    });
  });
}

Future<int> delete(int id) async {
  Database db = await getDatabase();
  return db.delete("tarefas", where: 'id = ?', whereArgs: [id]);
}