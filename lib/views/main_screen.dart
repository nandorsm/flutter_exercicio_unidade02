import 'package:flutter/material.dart';
import 'package:thiago_exercicio_unidade02/model/tarefa.dart';
import '../database/database.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final tarefa = TextEditingController();

  // listaDeTarefas() {
  //   return FutureBuilder(
  //       future: Future.delayed(Duration(seconds: 5)).then((value) => findAll()),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           List<Tarefa> tarefas = snapshot.data as List<Tarefa>;
  //           return ListView.builder(
  //               itemCount: tarefas.length,
  //               itemBuilder: (context, i) {
  //                 return Card(
  //                   child: Text("${tarefas[i].nome}"),
  //                 );
  //               });
  //         } else if (snapshot.hasError) {
  //           return Text("Error");
  //         } else {
  //           return CircularProgressIndicator();
  //         }
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: AppBar(
        title: Text('Tarefas App'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(12, 10, 12, 2),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),],
                borderRadius: BorderRadius.circular(15),

              ),
              child: TextField(
                controller: tarefa,
                decoration: InputDecoration(
                  icon: Icon(Icons.bookmark_add),
                  labelText: 'Adicionar Tarefa',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(12, 0, 12, 2),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      insert(Tarefa(tarefa.text));
                      tarefa.clear();
                    });
                  },
                  child: Text('Cadastrar')),
            ),
            FutureBuilder(
                future: findAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Tarefa> tarefas = snapshot.data as List<Tarefa>;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tarefas.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(12, 14, 12, 2),
                            child: CheckboxListTile(
                              title: Text("${tarefas[i].nome}", 
                                style: TextStyle(
                                  fontSize: 18,
                                  decoration: tarefas[i].checked ? TextDecoration.lineThrough : null
                                ),
                              ),
                              tileColor: Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                
                              ),
                              secondary: Icon(Icons.bookmark_outline, color: Colors.blue,),
                              controlAffinity: ListTileControlAffinity.platform,
                              value: tarefas[i].checked,
                              onChanged: (value){
                                setState(() {
                                  tarefas[i].checked = value!;
                                  update(tarefas[i]);
                                  print(tarefas[i].checked);

                                  // if(tarefas[i].checked == true){
                                  //   var temp = tarefas.insert(tarefas.length, tarefas[i]);
                                  //   update(temp);
                                  // }
                                  
                                  
                                  var temp = tarefas[i];
                                  if (tarefas[i].checked == true) {
                                    delete(tarefas[i].id);
                                    insert(temp);
                                  }



                                  //tarefas[i].checked.toString;
                                  //tarefas[i].checked.toString().sort(((a, b) => a.length.compareTo(b.length)));

                                });
                              },
                              activeColor: Colors.green,
                              checkColor: Colors.black,
                            ),
                          );
                        })
                    );
                    

                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
