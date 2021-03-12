/*
 * @Description: 基于列表刷新的视图模型基类
 * @Author: liuaobo
 * @Date: 2021-03-10 15:27:27
 * @LastEditTime: 2021-03-10 15:46:06
 * @LastEditors: liuaobo
 * @Reference: 
 */

import './base_view_model.dart';

abstract class BaseListViewModel<T> extends BaseViewModel {
  List<T> dataSource = [];

  initData() async {
    setLoading();
    await refresh();
  }

  /// 加载数据 子类必须要实现此方法
  Future<List<T>> loadData();

  /// 数据加载完成的回调,等价于onReady
  onCompleted(List<T> data) {}

  /// 下拉刷新
  /// [init] 是否是初始化第一次刷新数据
  refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        dataSource.clear();
        setEmpty();
      } else {
        dataSource.clear();
        dataSource.addAll(data);
        onCompleted(data);
        setReady();
      }
    } catch (e, s) {
      if (init) {
        dataSource.clear();
        setError(e, s);
      }
    }
  }
}
