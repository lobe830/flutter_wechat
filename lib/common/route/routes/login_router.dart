/*
 * @Description: 登录路由
 * @Author: liuaobo
 * @Date: 2021-03-12 17:17:13
 * @LastEditTime: 2021-03-12 17:34:32
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../base/base_route.dart';

class LoginRouter extends BaseRouter {
  LoginRouter(String routerName, FluroRouter router)
      : super(routerName, router) {
    router.define(this.routerName, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      // TODO: 路由参数解析
      // 获取传递的参数信息，var value = params["key"][0]
      // 获取传递的实例对象，T obj = context.settings.arguments as T
      return null;
    }));
  }
}
