import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mamushi/models/task.dart';

//クラス定義
class UndoneTaskPage extends StatefulWidget {
  final List<Task> undoneTaskList;
  final List<Task> doneTaskList;

  UndoneTaskPage({this.undoneTaskList,this.doneTaskList});

  @override
  _UndoneTaskPageState createState() => _UndoneTaskPageState();
}

class _UndoneTaskPageState extends State<UndoneTaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //リストビューで表示してくれる

      // indexに要素の数分だけ入ってくる
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(widget.undoneTaskList[index].title),
            value: widget.undoneTaskList[index].isDone,

            onChanged: (bool value) {

              // 完了未完了の情報を更新
              widget.undoneTaskList[index].isDone = value;

              // 完了したタスクを完了したタスクリストに追加
              widget.doneTaskList.add(widget.undoneTaskList[index]);

              // 完了したタスクを未完了タスクリストから削除する
              widget.undoneTaskList.removeAt(index);

              // 画面を再描画
              setState(() {});
            },
            secondary: IconButton(
            icon: Icon(Icons.more_horiz),
              onPressed: (){
              // ボトムシートを表示する
                showModalBottomSheet(context: context, builder: (context){
                  return Column(
                    // カラムを自動調整してくれる
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      ListTile(
                        title: Text('編集'),
                        leading: Icon(Icons.edit),
                        onTap: (){
                          // 編集の処理
                          // ボトムシートを非表示
                          Navigator.pop(context);
                          //シートダイアログを表示
                          showDialog(context: context, builder: (context){
                            return SimpleDialog(
                              title: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text("タイトルを編集")
                                    Container(
                                      width: 50,
                                      child: TextField(),
                                    )
                                  ],
                                ),
                              )
                            );

                          });

                        },
                      ),
                      ListTile(
                        title: Text('削除'),
                        leading: Icon(Icons.delete),
                        onTap: (){
                          // 削除の処理


                        },
                      )
                    ],
                  );
                });
              },
        ),
            );
      },
      // 何回繰り返すかを定義している
      itemCount: widget.undoneTaskList.length,
    );
  }
}
