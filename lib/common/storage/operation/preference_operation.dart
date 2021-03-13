/*
 * @Description: 偏好设置
 * @Author: liuaobo
 * @Date: 2021-03-13 14:26:57
 * @LastEditTime: 2021-03-13 15:15:43
 * @LastEditors: liuaobo
 * @Reference: SharedPerference
 */
import 'package:shared_preferences/shared_preferences.dart';

mixin PreferenceOperation {
  SharedPreferences _prefs;

  /// 获取偏好设置
  SharedPreferences get prefs {
    assert(_prefs == null);
    return _prefs;
  }

  /// 初始化偏好设置
  Future<SharedPreferences> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  /// 清空偏好设置
  clearPrefs() {
    _prefs?.clear();
    _prefs = null;
  }
}
