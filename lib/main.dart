import 'package:flutter/cupertino.dart';

/**
 * author: liuaobo
 * Date: 2021/3/5 10:52
 * Description:应用入口，提供应用启动前的一些辅助功能和服务，比如sdk初始化，应用异常处理等
 */

void main() async {
  // 胶水程序启动,使用mixins关联基础绑定功能（服务、渲染、组件、手势交互、调度等）
  WidgetsFlutterBinding.ensureInitialized();
  // 异常处理
}
