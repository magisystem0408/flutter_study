import 'package:flutter/material.dart';
import 'package:flutter_mamushi/pages/top_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TopPage(title: 'Flutter Demo Home Page'),
    );
  }
}

//todo アプリのタイトルを変更
//todo タスククラスを定義
//todo　キャッシュの情報を元にtopageタスクリストを表示
//todo　キャッシュの情報を元にtopageタスクリストを表示
//todo　タスク完了機能を実装
//todo　タブバーの画面下部に配置
//todo　完了タスクと未完了タスクの表示を切り替える
//todo　完了タスクを表示可能に
//todo　タスク追加画面のUI作成
//todo　タスクを追加可能に
//todo　リスト右側のボタンタップでボトムシートを表示
//todo　タスク編集可能に
//todo　タスクを追加可能に

