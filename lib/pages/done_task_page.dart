import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mamushi/models/task.dart';

class DoneTaskPage extends StatefulWidget {
  // final List<Task> undoneTaskList;
  // final List<Task> doneTaskList;

  // DoneTaskPage({this.undoneTaskList,this.doneTaskList});

  @override
  _DoneTaskPageState createState() => _DoneTaskPageState();
}

class _DoneTaskPageState extends State<DoneTaskPage> {
  TextEditingController editingController = TextEditingController();
  CollectionReference tasks;

  // List<Task> doneTaskList=[];
  //
  // Future <void>getdoneTasks() async{
  //   var collection =Firestore.instance.collection('task');
  //   var snapshot =await collection.where('is_done',isEqualTo: true).getDocuments();
  //   snapshot.documents.forEach((task) {
  //     Task doneTask =Task(
  //       title: task.data['title'],
  //       isDone: task.data['is_done'],
  //       createdTime: task.data['created_time']
  //     );
  //     doneTaskList.add(doneTask);
  //     setState(() {
  //
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getdoneTasks();
    tasks = Firestore.instance.collection('task');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: tasks.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              //リストビューで表示してくれる

              // indexに要素の数分だけ入ってくる
              itemBuilder: (BuildContext context, int index) {
                if(!snapshot.data.documents[index]['is_done']) return Container();

                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(snapshot.data.documents[index]['title']),
                  value: snapshot.data.documents[index]['is_done'],
                  onChanged: (bool value) {
                    // widget.doneTaskList[index].isDone = value;
                    //
                    // // 未完了に戻す作業
                    // widget.undoneTaskList.add(widget.doneTaskList[index]);
                    // widget.doneTaskList.removeAt(index);
                    // setState(() {});
                    snapshot.data.documents[index].reference.updateData({
                      'is_done':value,
                      'update_time':Timestamp.now()
                    });
                  },
                  secondary: IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text('編集'),
                                  leading: Icon(Icons.edit),
                                  onTap: () {
                                    // ボトムシートを非表示にする
                                    Navigator.pop(context);
                                    // シートダイアログを表示する
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            titlePadding: EdgeInsets.all(20),
                                            title: Container(
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Text("タイトルを編集"),
                                                  Container(
                                                      width: 500,
                                                      child: TextField(
                                                        controller:
                                                            editingController,
                                                        decoration: InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                      )),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 30),
                                                      child: Container(
                                                          width: 200,
                                                          height: 30,
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                // widget.doneTaskList[index].title =editingController.text;
                                                                // Navigator.pop(context);
                                                                // setState(() {})
                                                                snapshot.data.documents[index].reference.updateData({
                                                                  'title':editingController.text,
                                                                });
                                                                Navigator.pop(context);
                                                              },
                                                              child:
                                                                  Text('編集'))))
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                ),
                                ListTile(
                                  title: Text('削除'),
                                  leading: Icon(Icons.delete),
                                  onTap: () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              '${snapshot.data.documents[index]['title']}を削除しますか？',
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async{
                                                    // doneTaskList
                                                    //     .removeAt(index);
                                                    await snapshot.data.documents[index].reference.delete();
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Text('はい')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('キャンセル'))
                                            ],
                                          );
                                        });
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
              itemCount: snapshot.data.documents.length,
            );
          }else{
            return Container();
          }
        });
  }
}
