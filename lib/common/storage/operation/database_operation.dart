/*
 * @Description: 数据库操作
 * @Author: liuaobo
 * @Date: 2021-03-13 14:28:42
 * @LastEditTime: 2021-03-13 15:25:21
 * @LastEditors: liuaobo
 * @Reference: Sqflite
 */
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

mixin DatabaseOperation {
  Database _db;

  /// 获取当前database
  Database get db {
    assert(_db == null);
    return _db;
  }

  /// db 初始化
  Future<Database> initDatabase(String dbName, [int dbVersion = 1]) async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    _db = await openDatabase(path,
        version: dbVersion, onCreate: (db, version) async {});
    return _db;
  }

  // 关闭数据库
  close() {
    _db?.close();
    _db = null;
  }
}
