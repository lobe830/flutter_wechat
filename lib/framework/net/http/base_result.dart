/*
 * @Description: 基于http请求的返回结果
 * @Author: liuaobo
 * @Date: 2021-03-10 17:43:13
 * @LastEditTime: 2021-03-10 17:48:41
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:dio/dio.dart';

class BaseResult<T> {
  int code;
  String status;
  String message;
  T data;
  Response response;

  BaseResult(this.code, this.status, this.message, this.data, this.response);
  @override
  String toString() {
    StringBuffer buffer = new StringBuffer('{');
    buffer.write("\"code\":\"$code\"");
    buffer.write("\"status\":\"$status\"");
    buffer.write("\"message\":\"$message\"");
    buffer.write("\"data\":\"$data\"");
    buffer.write("\"code\":\"$code\"");
    buffer.write('}');
    return buffer.toString();
  }
}
