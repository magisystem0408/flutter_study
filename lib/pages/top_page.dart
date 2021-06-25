import 'package:flutter/material.dart';
import 'package:flutter_mamushi/models/task.dart';
import 'package:flutter_mamushi/pages/add_task_page.dart';
import 'package:flutter_mamushi/pages/done_task_page.dart';
import 'package:flutter_mamushi/pages/undone_task_page.dart';

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {

  List<Task> doneTaskList = [];


  //三項演算子の判定文で使用する
  bool showUndoneTaskPage = true;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('マムシの宝玉の扉'),
      ),

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 三項演算子で記述
          // (条件式)　? trueの場合 : falseのタスクの処理
          showUndoneTaskPage
              ? UndoneTaskPage(
                )
              : DoneTaskPage(
                  // doneTaskList: doneTaskList,
                ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  //押された時の処理をここに書く
                  onTap: () {
                    showUndoneTaskPage = true;
                    // 画面を再描画する
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.redAccent,
                    child: Text('未完了タスク',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  showUndoneTaskPage = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.greenAccent,
                  child: Text(
                    '完了タスク',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ))
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //ナビゲータータスクインポート
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTaskPage(
                      )));
          setState(() {});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors
          .blue, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
