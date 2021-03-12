/*
 * @Description: 用户注册界面路由
 * @Author: liuaobo
 * @Date: 2021-03-12 17:30:55
 * @LastEditTime: 2021-03-12 17:34:44
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../base/base_route.dart';

class RegisterRouter extends BaseRouter {
  RegisterRouter(String routerName, FluroRouter router)
      : super(routerName, router) {
    router.define(routerName, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      // TODO: 路由参数解析
      return null;
    }));
  }
}
