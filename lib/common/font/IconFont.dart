/*
 * @Description: 图标字体定义
 * @Author: liuaobo
 * @Date: 2021-03-10 14:15:04
 * @LastEditTime: 2021-03-10 14:21:26
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flutter/material.dart';

class IconFont {
  /// 默认字体
  static const String _family = "iconfont";

  IconFont._();

  static const IconData pageEmpty = IconData(0xe63c, fontFamily: _family);
  static const IconData pageError = IconData(0xe600, fontFamily: _family);
  static const IconData pageNetworkError =
      IconData(0xe678, fontFamily: _family);
  static const IconData pageUnAuth = IconData(0xe65f, fontFamily: _family);
}
