/*
 * @Description: mqtt数据解析处理
 * @Author: liuaobo
 * @Date: 2021-03-12 10:11:46
 * @LastEditTime: 2021-03-12 12:38:41
 * @LastEditors: liuaobo
 * @Reference: 
 */

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutterwechat/framework/net/process/message_process_manager.dart';
import 'package:typed_data/typed_data.dart' as typed;

class MqttDataHandler {
  /// 数据封包
  /// [id] 消息编号
  /// [uid] 当前用户id
  /// [msgBuffer] 消息数据流
  static typed.Uint8Buffer packData(int id, int uid, Uint8List msgBuffer) {
    ByteData bytes = new ByteData(msgBuffer.lengthInBytes + 8);
    ByteData byteData = msgBuffer.buffer.asByteData();
    bytes.setUint16(0, bytes.lengthInBytes);
    bytes.setUint16(2, id);
    bytes.setUint32(4, uid);

    for (int i = 0; i < byteData.lengthInBytes; i++) {
      bytes.setUint8(i + 8, byteData.getUint8(i));
    }

    typed.Uint8Buffer buffer = typed.Uint8Buffer();
    Uint8List list = bytes.buffer.asUint8List();
    buffer.addAll(list);
    return buffer;
  }

  static Future<List> unPackData(typed.Uint8Buffer msgBuffer) async {
    Uint8List uidList = new Uint8List.fromList(msgBuffer.sublist(0, 2));

    int length = (uidList[0] << 8) | uidList[1];
    uidList = new Uint8List.fromList(msgBuffer.sublist(2, 4));
    int id = (uidList[0] << 8) | uidList[1];
    uidList = new Uint8List.fromList(msgBuffer.sublist(4, 8));
    int a = uidList[0],
        b = uidList[1],
        c = uidList[2],
        d = uidList[3]; //uidList[1];
    int uid = (a << 24) | (b << 16) | (c << 8) | d;

    Map replyMap = {'length': length, 'id': id, 'uid': uid.toString()};
    Uint8List list =
        Uint8List.fromList(msgBuffer.sublist(8, msgBuffer.lengthInBytes));

    if (id != 2) {
      //Ping数据不打印
      debugPrint('replyMap === $replyMap');
    }
    return [id, list];
  }
}
