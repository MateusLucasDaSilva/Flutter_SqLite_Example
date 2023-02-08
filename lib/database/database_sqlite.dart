// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqlite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXAMPLE');

    return await openDatabase(
      databaseFinalPath,
      version: 2,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreing_keys = ON');
      },
      //Chamado somente no omento de criaçãi do banco de dados
      //primera vez que carrega o aplicativo
      onCreate: (db, version) {
        final batch = db.batch();
        batch.execute('''
                 create table teste(
                  id Integer primary key autoincrement,
                  nome varchar(200)
                  )
                  ''');
        batch.execute('''
                 create table produto(
                  id Integer primary key autoincrement,
                  nome varchar(200)
                  )
                  ''');
        // batch.execute('''
        //          create table categoria(
        //           id Integer primary key autoincrement,
        //           nome varchar(200)
        //           )
        //           ''');

        batch.commit();
      },
      //sera chamado sempre que ouver alteração de incremento na versão (1->2)
      onUpgrade: (db, oldVersion, newVersion) {
        final batch = db.batch();
        if (oldVersion == 1) {
          batch.execute('''
                 create table produto(
                  id Integer primary key autoincrement,
                  nome varchar(200)
                  )
                  ''');
        }
        // if (oldVersion == 2) {
        //   batch.execute('''
        //          create table categoria(
        //           id Integer primary key autoincrement,
        //           nome varchar(200)
        //           )
        //           ''');
        // }

        batch.commit();
      },
      //sera chamado sempre que ouver alteração de decremento na versão (2->1)
      onDowngrade: (db, oldVersion, newVersion) {
        print('OnDownGrade chamado');
        final batch = db.batch();
        if (oldVersion == 3) {
          batch.execute('''
                 drop table categoria;
                  ''');
        }

        batch.commit();
      },
    );
  }
}
