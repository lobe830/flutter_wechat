/*
 * @Description: UI视图 状态定义
 * @Author: liuaobo
 * @Date: 2021-03-09 17:15:57
 * @LastEditTime: 2021-03-10 15:21:10
 * @LastEditors: liuaobo
 * @Reference: 
 */

/// 视图状态定义
enum ViewState {
  /// 空闲
  idle,

  /// 数据加载中
  loading,

  /// 数据准备好
  ready,

  /// 数据为空
  empty,

  /// 数据解析异常
  error,

  /// 没有网络
  no_network,
}

/// 视图状态错误类型定义
enum ViewStateErrorType {
  /// 堆栈异常（一般指运行时程序编码不严谨导致的问题）
  stackException,

  /// 网络超时
  networkTimeout,

  /// 未授权
  unAuthorized,
}

/// 视图状态错误类定义
class ViewStateError {
  ViewStateErrorType errorType;
  String errorMessage;

  ViewStateError({this.errorType, this.errorMessage}) {
    this.errorType ??= ViewStateErrorType.stackException;
    this.errorMessage ??= "异常未定义!";
  }

  @override
  String toString() {
    return "ViewStateError {errorType : $errorType, errorMessage : $errorMessage}";
  }
}
