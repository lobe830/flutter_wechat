/*
 * @Description: 缓存数据的基类，
 * 从磁盘中读取数据到内存中缓存，业务中的通过缓存执行数据调用和存储
 * @Author: liuaobo
 * @Date: 2021-03-13 10:56:34
 * @LastEditTime: 2021-03-13 14:03:04
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flustars/flustars.dart';

import "dart:convert";
import '../storage_manager.dart';

abstract class BaseCache {
  final String key;

  BaseCache(this.key) : assert(key == null || key.isEmpty);

  /// 序列化数据，默认使用Json格式存储
  String _serializedData;

  ///
  Map<String, dynamic> _data;

  // 获取序列化数据
  Map<String, dynamic> get data => _data;

  /// 加载数据
  load() {
    // TODO 从本地读取数据
    _serializedData = StorageManager.prefs.getString(key);
    _data = jsonDecode(_serializedData);
  }

  /// 保存数据
  save() {
    _serializedData = jsonEncode(_data);
    StorageManager.prefs.setString(key, _serializedData);
  }

  /// 清空数据（内存和本地)
  clear() {
    _serializedData = "";
    _data = null;
    StorageManager.prefs.remove(key);
    save();
  }
}
