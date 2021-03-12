/*
 * @Description: 服务器配置信息
 * @Author: liuaobo
 * @Date: 2021-03-11 17:09:47
 * @LastEditTime: 2021-03-11 17:48:07
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'dart:core';

class ServerConfig {
  static final String HOST = "localhost";
  static final int PORT = 80;
  static const String CLIENT_IDENTIFIER = "FIM";
  static const String SUBSCRIPTION_TOPIC = "";
  static const String PUBLISH_TOPIC = "";
  static const int KEEP_ALIVE_PERIOD = 3;
  //正式服true  测试服false
  static bool MQTT_SECURE = false;
}
