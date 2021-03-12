/*
 * @Description: 全局类定义，管理全局（顶级)变量、全局(顶级）方法
 * @Author: liuaobo
 * @Date: 2021-03-12 16:12:25
 * @LastEditTime: 2021-03-12 18:06:55
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutterwechat/common/route/routes.dart';

import "function.dart"; // 全局方法文件

class Global {
  // 全局静态路由，用于界面导航
  static FluroRouter router;

  // 全局的事件总线，用于跨模块传输数据
  static final EventBus eventBus = EventBus();

  /// 全局初始化，可以考虑在闪屏页打开后进行初始化
  static init() async {
    // 初始化配置
    await initConfig();
    // 初始化数据
    await initData();
    // 初始化网络
    await initNetwork();
    // 初始化SDK
    await initSDK();
    // todo..
  }

  static initConfig() async {
    // 全局变量配置
    // 路由配置
    await initRoutes();
    // 状态配置
    // 主题配置
    // 多语言配置
    // todo..
  }

  static initRoutes() async {
    FluroRouter router = FluroRouter();
    Global.router = router;
    Routes.configureRoutes(router);
  }

  static initThemes() async {}

  static initLocales() async {}

  static initData() async {
    // 初始化组件 localStorage、prefs、db
    // 数据模块加载本地缓存
  }

  static initNetwork() async {
    // 初始化http服务
    // 读取本地的缓存信息
    // 解析http返回的结果
    // 创建游戏服务器连接
  }

  static initSDK() async {
    // 推送sdk
    // 埋点数据sdk
    // 广告sdk
    // and so on
  }
}
