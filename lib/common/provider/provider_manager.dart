/*
 * @Description: 状态管理器
 * @Author: liuaobo
 * @Date: 2021-03-13 10:25:23
 * @LastEditTime: 2021-03-13 10:48:44
 * @LastEditors: liuaobo
 * @Reference: 
 */
import "package:provider/single_child_widget.dart";
import "package:provider/provider.dart";

class ProviderManager {
  static List<SingleChildWidget> providers = [
    ...independentServices,
    ...dependentServices
  ];

  /// 独立的状态服务列表
  static List<SingleChildWidget> independentServices = [];

  /// 需要依赖的状态服务列表
  static List<SingleChildWidget> dependentServices = [];
}
