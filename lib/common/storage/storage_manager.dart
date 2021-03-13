/*
 * @Description: 数据本地存储，提供本地缓存、偏好设置、db大数据存储
 * @Author: liuaobo
 * @Date: 2021-03-12 17:59:43
 * @LastEditTime: 2021-03-13 15:26:59
 * @LastEditors: liuaobo
 * @Reference: 
 * 
 * 1. SharedPreferences 简单存储（偏好配置)
 * 缓存少量的键值对信息（比如记录用户是否阅读了公告，或是简单的计数），可以使用 SharedPreferences。
 * 2. Sqflite 大数据持久化存储
 * 持久化大量格式化后的数据，并且这些数据还会以较高的频率更新，为了考虑进一步的扩展性，通常会选用 sqlite 数据库来应对这样的场景
 */
import './config/db_config.dart';

import 'operation/database_operation.dart';
import 'operation/preference_operation.dart';

class StorageManager with PreferenceOperation, DatabaseOperation {
  static StorageManager _instance = StorageManager._internal();

  static StorageManager get instance => _instance;

  StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  initialize() async {
    await initPrefs();
    await initDatabase(DatabaseConfig.DB_NAME, DatabaseConfig.VERSION);
  }
}
