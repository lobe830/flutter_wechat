/*
 * @Description: 客户端配置信息
 * @Author: liuaobo
 * @Date: 2021-03-11 17:09:39
 * @LastEditTime: 2021-03-11 17:20:03
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flutter/foundation.dart';

class ClientConfig {
  static const bool isUseBugly = false;
  static const bool isOpenAndroidUpd = true;
  // 打包上架需要修改为true
  static const bool upLoadToAppStore = kDebugMode ? false : true;
}
