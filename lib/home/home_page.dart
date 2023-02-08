// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/database/database_sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _database();
  }

  Future<void> _database() async {
    final database = await DatabaseSqlite().openConnection();

    //database.insert('teste', {'nome': 'Mateus Lucas'});
    // database.update('teste', {'nome': 'Mateus Lucas Da Silva'},
    //     where: 'nome = ?', whereArgs: ['Mateus Lucas']);
    // database.delete('teste', where: 'nome = ?', whereArgs: ['Mateus Lucas Da Silva']);
    // var result = await database.query('teste');
    // print(result);

    // database.rawInsert('insert into teste values(null, ?)', ['Mateus Lucas']);
    // database.rawUpdate('update teste set nome = ? where id = ? ', ['Mateus Lucas da silva', 2]);
    // database.rawDelete('delete from teste where id = ?', [3]);
    var result = await database.rawQuery('select *from teste');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(),
    );
  }
}
