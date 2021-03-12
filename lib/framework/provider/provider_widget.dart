/*
 * @Description: 基于Provider的数据状态封装，方便数据初始化。创建viewmodel，初始化数据
 * @Author: liuaobo
 * @Date: 2021-03-09 15:50:31
 * @LastEditTime: 2021-03-09 17:15:23
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;

  /// 当前界面关联的vm对象
  final T viewModel;
  final Widget child;

  /// vm初始化完成的回调方法
  final Function(T viewModel) onViewModelReady;

  /// 当前组件是否自动销毁
  final bool autoDispose;

  ProviderWidget(
      {Key key,
      @required this.builder,
      @required this.viewModel,
      this.child,
      this.onViewModelReady,
      this.autoDispose: true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    widget.onViewModelReady?.call(viewModel);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      viewModel.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<T1 extends ChangeNotifier, T2 extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(
      BuildContext context, T1 viewModel1, T2 viewModel2, Widget child) builder;
  final T1 viewModel1;
  final T2 viewModel2;
  final Widget child;
  final Function(T1 viewModel1, T2 viewModel2) onViewModelReady;
  final bool autoDispose;

  ProviderWidget2(
      {Key key,
      @required this.builder,
      @required this.viewModel1,
      @required this.viewModel2,
      this.child,
      this.onViewModelReady,
      this.autoDispose: true});

  @override
  State<StatefulWidget> createState() {
    return _ProviderWidget2State<T1, T2>();
  }
}

class _ProviderWidget2State<T1 extends ChangeNotifier,
    T2 extends ChangeNotifier> extends State<ProviderWidget2<T1, T2>> {
  T1 viewModel1;
  T2 viewModel2;

  @override
  void initState() {
    viewModel1 = widget.viewModel1;
    viewModel2 = widget.viewModel2;
    widget.onViewModelReady?.call(viewModel1, viewModel2);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      viewModel1.dispose();
      viewModel2.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<T1>.value(value: viewModel1),
        ChangeNotifierProvider<T2>.value(value: viewModel2),
      ],
      child: Consumer2<T1, T2>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
