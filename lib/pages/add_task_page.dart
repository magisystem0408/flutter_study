import 'package:flutter/material.dart';
import 'package:flutter_mamushi/models/task.dart';

class AddTaskPage extends StatefulWidget {
  final List<Task> undoneTaskList;
  AddTaskPage({this.undoneTaskList});
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController titleController = TextEditingController();

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
                    createdTime:DateTime.now()
                  );

                  //タスク追加
                  widget.undoneTaskList.add(newTask);
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
