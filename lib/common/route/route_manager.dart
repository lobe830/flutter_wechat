/*
 * @Description: 路由全局配置,定义各个路由标识符
 * @Author: liuaobo
 * @Date: 2021-03-12 17:00:48
 * @LastEditTime: 2021-03-13 10:34:09
 * @LastEditors: liuaobo
 * @Reference: 
 */
import "package:fluro/fluro.dart";
import 'package:flutterwechat/common/route/route_name.dart';

import 'base/base_route.dart';
import 'routes/login_router.dart';
import 'routes/register_router.dart';

class RouteManager {
  static List<BaseRouter> _routeList = [];
  static FluroRouter _router;

  /// 路由管理器初始化
  static Future<FluroRouter> initialize() async {
    _router = FluroRouter();
    configureRoutes(_router);
    return _router;
  }

  /// 注册路由
  static configureRoutes(FluroRouter router) {
    _routeList.add(LoginRouter(RouteName.Login, router));
    _routeList.add(RegisterRouter(RouteName.Register, router));
  }
}
