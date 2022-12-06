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
  bool? _checked = false;

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
      appBar: AppBar(
        title: Text('Tarefas App'),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: tarefa,
              decoration: InputDecoration(
                icon: Icon(Icons.bookmark_add),
                labelText: 'Tarefa',
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      insert(Tarefa(tarefa.text));
                      //tarefas = findAll();
                      //listaDeTarefas();
                    });
                  },
                  child: Text('Cadastrar')),
            ),
            FutureBuilder(
                future: Future.delayed(Duration(seconds: 2))
                    .then((value) => findAll()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Tarefa> tarefas = snapshot.data as List<Tarefa>;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tarefas.length,
                        itemBuilder: (context, i) {
                          return CheckboxListTile(
                            title: Text("${tarefas[i].nome}"),
                            secondary: Icon(Icons.bookmark_outline),
                            controlAffinity: ListTileControlAffinity.platform,
                            value: _checked,
                            onChanged: (value){
                              setState(() {
                                _checked = value;
                                
                              });
                            },
                            activeColor: Colors.green,
                            checkColor: Colors.black,
                          );
                        })
                    );
                    

                  } else if (snapshot.hasError) {
                    return Text("Error");
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
