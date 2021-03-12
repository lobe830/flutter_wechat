/*
 * @Description: 消息管理器，处理消息分发
 * @Author: liuaobo
 * @Date: 2021-03-12 10:49:53
 * @LastEditTime: 2021-03-12 12:46:35
 * @LastEditors: liuaobo
 * @Reference: 
 */

import 'package:flutter/material.dart';
import 'package:flutterwechat/framework/net/socket/mqtt_data_handler.dart';
import 'package:typed_data/typed_data.dart';

typedef MessageCallback = Function(dynamic message);

class MessageProcessManager {
  static final MessageProcessManager _instance =
      MessageProcessManager._internal();

  static MessageProcessManager get instance => _instance;

  factory MessageProcessManager() {
    return _instance;
  }

  static Map<int, List<Function>> _processList;

  MessageProcessManager._internal() {
    // 初始化
    _processList = Map<int, List<Function>>();
  }

  regist(int messageId, Function handler) {
    var handlers = _processList[messageId];
    if (handlers == null) {
      handlers = new List<Function>();
      _processList[messageId] = handlers;
    }
    handlers.add(handler);
  }

  unregist(int messageId, Function handler) {
    var handlers = _processList[messageId];
    if (handlers != null) {
      handlers.remove(handler);
    }
  }

  unregistAll(int messageId) {
    var handlers = _processList[messageId];
    if (handlers != null) {
      handlers.clear();
    }
  }

  process(Uint8Buffer data) {
    MqttDataHandler.unPackData(data).then((result) {
      var messageId = result[0];
      var messageData = result[1];
      var handlers = _processList[messageId];
      handlers?.map((handler) {
        handler(messageData);
      });
    }).catchError((e) {
      debugPrint("[MessageProcessManager]->process ERROR! msg = " + e.toString);
    });
  }
}
