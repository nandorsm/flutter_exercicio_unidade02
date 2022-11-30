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

  listaDeTarefas() {
    return FutureBuilder(
              future: Future.delayed(Duration(seconds: 5)).then((value) => findAll()),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List<Tarefa> tarefas = snapshot.data as List<Tarefa>;
                  return ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context,i){
                        return Card(
                          child: Text("${tarefas[i].nome}"),
                        );
                      }
                  );
                }else if(snapshot.hasError){
                  return Text("Error");
                }else{
                    return CircularProgressIndicator();
                }
              }
            );
  }





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
                    //listaDeTarefas();
                  });
                },
                child: Text('Cadastrar')),
            ),
            
            // Container(
            //   child: listaDeTarefas(),
            // ),

            
            // FutureBuilder(
            //   future: findAll(),
            //   builder: (context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasData) {
            //       return Container(
            //         child: ListView.builder(
            //           itemCount: snapshot.data.length,
            //           scrollDirection: Axis.horizontal,
            //           itemBuilder: (BuildContext context, int index) {
            //             return ListTile(
            //               title: Text(snapshot.data[index].nome),
            //             );
            //           }));
            //     } else {
            //       return Center(child: CircularProgressIndicator());
                  
            //     }
            //   }),
            
            // listaTarefas()


          ],
        ),
      ),
    );
  }
}