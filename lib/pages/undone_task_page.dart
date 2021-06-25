import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mamushi/models/task.dart';

//クラス定義
class UndoneTaskPage extends StatefulWidget {
  @override
  _UndoneTaskPageState createState() => _UndoneTaskPageState();
}

class _UndoneTaskPageState extends State<UndoneTaskPage> {
  TextEditingController editingController = TextEditingController();
  CollectionReference tasks;

// //  遅延処理版
//   List<Task> undoneTaskList =[];
//   //firestoreから情報をとってくるコードを書く
//   Future<void> getUndoneTasks() async{
//
//       var collection =Firestore.instance.collection('task');
//
//       // コレクションの中のisdoneがfalseとなってるものを取得する
//       var snapshot =await collection.where('is_done',isEqualTo: false).getDocuments();
//       snapshot.documents.forEach((task) {
//         Task undoneTask =Task(
//          title: task.data['title'],
//          isDone: task.data['is_done'],
//          createdTime: task.data['created_time']
//         );
//         undoneTaskList.add(undoneTask);
//       });
//       setState(() {
//
//       });
//   }

//イニシャライズ
  @override
  void initState() {
    super.initState();
    // getUndoneTasks();
    tasks = Firestore.instance.collection('task');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // 指定している値に変化が会った時に使う
        stream: tasks.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              //リストビューで表示してくれる

              // indexに要素の数分だけ入ってくる
              itemBuilder: (BuildContext context, int index) {

                if(snapshot.data.documents[index]['is_done']) return Container();
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(snapshot.data.documents[index]['title']),
                  value: snapshot.data.documents[index]['is_done'],
                  onChanged: (bool value) {

                    snapshot.data.documents[index].reference.updateData({
                      'is_done':value,

                      'updated_time':Timestamp.now()
                    });

                  },
                  secondary: IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      // ボトムシートを表示する
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              // カラムを自動調整してくれる
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                ListTile(
                                  title: Text('編集'),
                                  leading: Icon(Icons.edit),
                                  onTap: () {
                                    // 編集の処理
                                    // ボトムシートを非表示
                                    Navigator.pop(context);
                                    //シートダイアログを表示
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
                                                          decoration:
                                                              InputDecoration(
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

                                                                snapshot.data.documents[index].reference.updateData({
                                                                  'title':editingController.text,
                                                                });
                                                                Navigator.pop(context);

                                                              },
                                                              child:
                                                                  Text('編集'))),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        });
                                  },
                                ),
                                ListTile(
                                  title: Text('削除'),
                                  leading: Icon(Icons.delete),
                                  onTap: () {
                                    // 削除の処理
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                '${snapshot.data.documents[index]['title']}を削除しますか？'),
                                            actions: [
                                              TextButton(
                                                onPressed: () async{
                                                  await snapshot.data.documents[index].reference.delete();
                                                  Navigator.pop(context);
                                                  setState(() {

                                                  });

                                                },
                                                child: Text('はい'),
                                              ),
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
              // 何回繰り返すかを定義している
              itemCount: snapshot.data.documents.length,
            );
          }else{
            return Container();
          }
        });
  }
}
