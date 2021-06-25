import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mamushi/models/task.dart';

class AddTaskPage extends StatefulWidget {
// ローカル環境で受け取り
  // final List<Task> undoneTaskList;
  // AddTaskPage({this.undoneTaskList});
  @override
  _AddTaskPageState createState() => _AddTaskPageState();

}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController titleController = TextEditingController();

  Future<void> insertTask(String title) async{
    var collection =Firestore.instance.collection('task');
    collection.add({
      'title':title,
      'is_done':false,
      'created_time':Timestamp.now()
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('マムシの錬金術師が今ここにあり'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('タイトル'),
            ),
            Container(
              width: 500,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: 350,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      //タスクを作成
                  Task newTask =Task(
                    title:titleController.text,
                    isDone:false,
                  );

                  //タスク追加
                  // widget.undoneTaskList.add(newTask);
                  insertTask(titleController.text);

                  setState(() {

                  });
                  Navigator.pop(context);
                }, child: Text('追加ボタン')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
