/*
 * @Description: 消息处理的基类，子类基于模块进行定义，负责管理模块内消息的收发。
 * 解析消息数据并组织新的数据对象，通过eventbus，将数据广播出去， 
 * viewmodel中监听eventbus 广播的事件，更新数据状态后，通知UI刷新
 * ViewModel 与 Process 通过mixins 进行关联组合
 * @Author: liuaobo
 * @Date: 2021-03-04 17:46:00
 * @LastEditTime: 2021-03-12 16:01:27
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterwechat/framework/net/socket/mqtt_manager.dart';

abstract class BaseMessageProcess {
  /// 初始化，比如进行服务器消息的注册
  ///
  init() {}

  /// 发送服务器消息
  /// 消息id、消息内容
  sendMessage(int messageId, Uint8List messageData) {
    if (MqttManager.Instance != null) {
      MqttManager.Instance.sendMessage(messageId, messageData);
    } else {
      debugPrint("Error! MqttManager 未初始化， 请检查！");
    }
  }
}
