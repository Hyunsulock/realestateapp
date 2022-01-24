import 'package:realestatemanager/models/apt_model.dart';
import 'package:realestatemanager/models/event_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _aptDBTable = 'apts';
  static final String _eventDBTable = 'events';


  static Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE $_aptDBTable(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              apt TEXT NOT NULL,
              owner TEXT NOT NULL,
              price INTEGER NOT NULL
              )""");

    await db.execute("""
            CREATE TABLE $_eventDBTable(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              event_type TEXT NOT NULL,
              count INTEGER,
              date INTEGER NOT NULL,
              price INTEGER NOT NULL,
              estate_id INTEGER NOT NULL,
              FOREIGN KEY (estate_id) REFERENCES $_aptDBTable (id)
                ON DELETE CASCADE ON UPDATE CASCADE
            )""");
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'estates.db';
      _db = await openDatabase(_path,
          version: _version, onCreate: _create, onConfigure: _onConfigure);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> insertEvent(EventModel? eventModel) async {
    await _db!.insert(_eventDBTable, eventModel!.toJson());
  }

  static Future<void> insertApt(AptDataModel? aptDataModel) async {
    print('insert');
    await _db!.insert(_aptDBTable, aptDataModel!.toJson());
  }

  static Future<List<Map<String, dynamic>>> queryApt() async {
    return await _db!.query(_aptDBTable);
  }

  static Future<List<Map<String, dynamic>>> queryEvent() async {
    return await _db!.query(_eventDBTable);
  }


  static Future<void> deleteByAptId(int? id) async {
    print('clicked');
    await _db!.delete(_aptDBTable, where: 'id=?', whereArgs: [id]);
  }


  static Future<void> deleteByEventId(int? id) async {
    print('clicked');
    await _db!.delete(_eventDBTable, where: 'id=?', whereArgs: [id]);
  }
}
