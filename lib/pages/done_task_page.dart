import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mamushi/models/task.dart';

class DoneTaskPage extends StatefulWidget {

  final List<Task> undoneTaskList;
  final List<Task> doneTaskList;

  DoneTaskPage({this.undoneTaskList,this.doneTaskList});

  @override
  _DoneTaskPageState createState() => _DoneTaskPageState();
}

class _DoneTaskPageState extends State<DoneTaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //リストビューで表示してくれる

      // indexに要素の数分だけ入ってくる
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(widget.doneTaskList[index].title),
            value: widget.doneTaskList[index].isDone,
            onChanged: (bool value) {
              widget.doneTaskList[index].isDone = value;

              // 未完了に戻す作業
              widget.undoneTaskList.add(widget.doneTaskList[index]);
              widget.doneTaskList.removeAt(index);
              setState(() {});
            },
            secondary: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: (){
                showModalBottomSheet(context: context, builder: (context){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('編集'),
                        leading: Icon(Icons.edit),
                        onTap: (){

                        },
                      ),
                      ListTile(
                        title: Text('削除'),
                        leading: Icon(Icons.delete),
                        onTap: (){


                        },
                      )
                    ],
                  );

                });
              },
            ),

        );
        },


      // 配列をとってくるのに何回繰り返すかを定義している
      itemCount: widget.doneTaskList.length,
    );
  }
}
