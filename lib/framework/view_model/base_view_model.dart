/*
 * @Description: 视图模型的基类,维护当前视图状态, 当数据发生变化时通知视图更新
 * @Author: liuaobo
 * @Date: 2021-03-10 14:54:51
 * @LastEditTime: 2021-03-10 15:25:09
 * @LastEditors: liuaobo
 * @Reference: 
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/framework/state/view_state.dart';

class BaseViewModel extends ChangeNotifier {
  bool _disposed = false;

  ViewState _viewState = ViewState.idle;
  ViewStateError _viewStateError;

  BaseViewModel({ViewState viewState}) {
    _viewState = viewState ?? ViewState.idle;
  }

  ViewState get viewState => _viewState;
  ViewStateError get viewStateError => _viewStateError;

  set viewState(viewState) {
    if (viewState != _viewState) {
      _viewState = viewState;
      _viewStateError = null;
      notifyListeners();
    }
  }

  void onError(ViewStateError viewStateError) {}
  bool get isIdle => _viewState == ViewState.idle;
  bool get isLoading => _viewState == ViewState.loading;
  bool get isReady => _viewState == ViewState.ready;
  bool get isEmpty => _viewState == ViewState.empty;
  bool get isError => _viewState == ViewState.error;

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setLoading() {
    viewState = ViewState.loading;
  }

  void setReady() {
    viewState = ViewState.ready;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String message}) {
    ViewStateErrorType errorType = ViewStateErrorType.stackException;

    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        // timeout
        errorType = ViewStateErrorType.networkTimeout;
        message = e.error;
      } else if (e.type == DioErrorType.RESPONSE) {
        // incorrect status, such as 404, 503...
        message = e.error;
      } else if (e.type == DioErrorType.CANCEL) {
        // to be continue...
        message = e.error;
      } else {
        e = e.error;
        message = e.message;
      }
    }
    viewState = ViewState.error;
    _viewStateError = ViewStateError(
      errorType: errorType,
      errorMessage: message,
    );
    printErrorStack(e, stackTrace);
    onError(_viewStateError);
  }

  @override
  String toString() {
    return "BaseViewModel{_viewState: $_viewState, _viewStateError: $_viewStateError}";
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
}
