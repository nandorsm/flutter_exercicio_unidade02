import 'package:flutter/material.dart';
import 'package:thiago_exercicio_unidade02/model/tarefa.dart';
import '../database/database.dart';
import '../views/main_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final tarefa = TextEditingController();

  //List<String> tarefas = [];

  


  // buildListView() {
  //   final tarefas = List<Tarefa>;
  //   return ListView(
  //     itemCount : tarefas.length;
  //     tarefasBuilder: (context, index){
  //       return ListTile(
  //         title: Text('${tarefas[index]}'),
  //       )
  //     },
  //   );
  //   }
  // }


  // listaTarefas(){
  //   return ListView.builder(
  //     itemCount: tarefas.length, //lenBugado
  //     itemBuilder: (context, index){
  //        return ListTile(
  //         title: Text('${tarefas[index]}'),
  //        );
  //     }
  //   );
  // }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas App'),
      ),
      body:Container(
        child: Column(
          children: [
            TextField(
              controller: tarefa,
              decoration: InputDecoration(
                icon: Icon(Icons.bookmark_outline),
                labelText: 'Tarefa',
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    insert(Tarefa(tarefa.text));
                    //tarefas = findAll();
                  });
                },
                child: Text('Cadastrar')),
            ),
            FutureBuilder(
              future: findAll(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].nome),
                        );
                      }));
                }
              }),
            
            // listaTarefas()


          ],
        ),
      ),
    );
  }
}