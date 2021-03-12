/*
 * @Description: 路由全局配置,定义各个路由标识符
 * @Author: liuaobo
 * @Date: 2021-03-12 17:00:48
 * @LastEditTime: 2021-03-12 17:38:05
 * @LastEditors: liuaobo
 * @Reference: 
 */
import "package:fluro/fluro.dart";
import 'package:flutterwechat/common/route/route_name.dart';

import 'base/base_route.dart';
import 'routes/login_router.dart';
import 'routes/register_router.dart';

class Routes {
  static List<BaseRouter> routeList = [];

  /// 注册路由
  static void configureRoutes(FluroRouter router) {
    routeList.add(LoginRouter(RouteName.Login, router));
    routeList.add(RegisterRouter(RouteName.Register, router));
  }
}
