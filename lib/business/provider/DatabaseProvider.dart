import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Database db;

  Future<void> create() async {
    var path = await join(await getDatabasesPath(), 'weather.db');
    db = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS set_location(location_id INTEGER PRIMARY KEY, name TEXT, country TEXT)'
        ).whenComplete((){
            print('Created set_location table');
        });
        await db.execute(
          'CREATE TABLE IF NOT EXISTS coord(coord_id INTEGER, lon TEXT, lat TEXT, FOREIGN KEY(coord_id) REFERENCES set_location(location_id))'
        ).whenComplete((){
            print('Created coord table');
        });
      },
      version: 1,
    );
  }

   Future<void> open() async {
    var path = await join(await getDatabasesPath(), 'weather.db');
      db = await openDatabase(
      path,
      version: 1,
    );
  }
}

