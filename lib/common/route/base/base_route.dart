/*
 * @Description: 路由配置基类
 * @Author: liuaobo
 * @Date: 2021-03-12 17:12:44
 * @LastEditTime: 2021-03-12 17:23:52
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:fluro/fluro.dart';

abstract class BaseRouter {
  final String routerName;
  final FluroRouter router;

  BaseRouter(this.routerName, this.router);
}
