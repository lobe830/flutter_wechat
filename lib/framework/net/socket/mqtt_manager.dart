/*
 * @Description: 基于mqtt传输协议的管理器
 * @Author: liuaobo
 * @Date: 2021-03-10 16:42:19
 * @LastEditTime: 2021-03-12 14:12:24
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterwechat/common/config/server_config.dart';
import 'package:flutterwechat/framework/net/process/message_process_manager.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_data.dart' as typed;

import './mqtt_data_handler.dart';

class MqttManager {
  static MqttManager _instance;
  static MqttManager get Instance => _instance;
  MqttServerClient _client;

  MqttManager(this._host, this._port, this._identifier, this._token,
      this._useSSL, this._subscriptionTopic, this._publishTopic) {
    _instance = this;
  }

  final String _host;
  final int _port;
  final String _identifier; // username
  final String _token; // password
  final bool _useSSL; // 是否开启加密
  final String _subscriptionTopic;
  final String _publishTopic;
  int _uid; // 当前用户id

  Future<MqttClientConnectionStatus> connect(int userId) async {
    debugPrint("MqttManager start connect. userId = $userId");
    _uid = userId;

    _client = MqttServerClient.withPort(_host, _identifier, _port);
    _client.keepAlivePeriod = ServerConfig.KEEP_ALIVE_PERIOD;
    _client.autoReconnect = false;
    _client.resubscribeOnAutoReconnect = false;

    if (_useSSL) {
      _client.secure = true;
      _client.onBadCertificate = (dynamic p) => true;
    }

    _client.onConnected = _onConnected;
    _client.onAutoReconnect = _onAutoReconnect;
    _client.onSubscribed = _onSubscribed;
    _client.onSubscribeFail = _onSubscribeFail;
    _client.onUnsubscribed = _onUnsubscribed;
    _client.onDisconnected = _onDisconnected;

    _client.logging(on: false);
    _client.updates.listen(_onData, onError: _onError, onDone: _onDone);

    return _client.connect(_identifier, _token);
  }

  /// 断开服务器连接
  void disconnect() {
    if (_client != null) {
      _client.disconnect();
      _client = null;
      debugPrint("客户端主动断开连接");
    }
  }

  /// 发布消息
  /// [topic] 主题
  /// [message] 消息
  int publish(String topic, String message) {
    debugPrint("[mqtt]->publish topic = $topic message = $message");
    typed.Uint8Buffer buffer = typed.Uint8Buffer();
    buffer.addAll(message.codeUnits);
    return _client.publishMessage(
      topic,
      MqttQos.atLeastOnce,
      buffer,
    );
  }

  int publishWithList(String topic, List<int> list) {
    debugPrint("[mqtt]->publishWithList topic = $topic message = $list");
    typed.Uint8Buffer buffer = typed.Uint8Buffer();
    buffer.addAll(list);
    return _client.publishMessage(
      topic,
      MqttQos.atLeastOnce,
      buffer,
    );
  }

  /// 发布消息 基于唯一主题_publishTopic（信道）
  /// [message] 消息
  int publishOnly(String message) {
    if (_publishTopic == null) {
      debugPrint("publishTopic未定义, 请检查!");
    }
    return publish(_publishTopic, message);
  }

  /// 发布消息
  int _publishOnlyWithBuffer(typed.Uint8Buffer message) {
    if (_publishTopic == null) {
      debugPrint("publishTopic未定义, 请检查!");
    }
    return _client.publishMessage(_publishTopic, MqttQos.atLeastOnce, message);
  }

  /// 发送消息（现有项目定制接口）
  /// [messageId] 消息id
  /// [message] 消息内容
  int sendMessage(int messageId, Uint8List message) {
    debugPrint("[mqtt]->sendMessage messageId = $messageId");
    typed.Uint8Buffer buffer =
        MqttDataHandler.packData(messageId, _uid, message);
    return _publishOnlyWithBuffer(buffer);
  }

  /// 订阅消息
  Subscription subscribe(String topic) {
    debugPrint("[mqtt]->subscribe topic = $topic");
    return _client.subscribe(topic, MqttQos.atLeastOnce);
  }

  unSubscribe(String topic) {
    debugPrint("[mqtt]->unSubscribe topic = $topic");
    return _client.unsubscribe(topic);
  }

  void _onConnected() {
    debugPrint("[mqtt]->onConnected");
  }

  void _onAutoReconnect() {
    debugPrint("[mqtt]->onAutoReconnect");
  }

  void _onSubscribed(String topic) {
    debugPrint("[mqtt]->onSubscribed");
  }

  void _onSubscribeFail(String topic) {
    debugPrint("[mqtt]->onSubscribeFail");
  }

  void _onUnsubscribed(String topic) {
    debugPrint("[mqtt]->onSubscribeFail");
  }

  void _onDisconnected() {
    debugPrint("[mqtt]->onDisconnected");
  }

  void _onData(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttReceivedMessage<MqttMessage> receiveMessage = event[0];
    final MqttPublishMessage message = receiveMessage.payload;
    final String topic = receiveMessage.topic;
    final typed.Uint8Buffer data = message.payload.message;
    debugPrint("[mqtt]->onData topic = $topic");

    MessageProcessManager.instance.process(data);
  }

  void _onDone() {
    debugPrint("[mqtt]->onDone");
  }

  _onError() {
    debugPrint("[mqtt]->onError");
  }
}
