/*
 * @Description: 视图数据发生异常的提示组件
 * @Author: liuaobo
 * @Date: 2021-03-10 14:36:22
 * @LastEditTime: 2021-03-10 14:51:29
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/framework/state/view_state.dart';
import 'package:flutterwechat/resource/font/IconFont.dart';

import 'view_state_unAuthorized_widget.dart';
import 'view_state_widget.dart';

class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  ViewStateErrorWidget(
      {Key key,
      @required this.error,
      this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMsg = error.errorMessage;
    var defaultTextData = "Retry";
    switch (error.errorType) {
      case ViewStateErrorType.networkTimeout:
        defaultImage = Transform.translate(
          offset: Offset(-50, 0),
          child: const Icon(IconFont.pageNetworkError,
              size: 100, color: Colors.grey),
        );
        defaultTitle = "Load failed,Check your network.";
        break;
      case ViewStateErrorType.stackException:
        defaultImage =
            const Icon(IconFont.pageError, size: 100, color: Colors.grey);
        defaultTitle = "Load failed.Check your exceptionStack.";
        break;
      case ViewStateErrorType.unAuthorized:
        return ViewStateUnAuthorizedWidget(
          image: image,
          message: message,
          buttonText: buttonText,
          onPressed: onPressed,
        );
        break;
    }

    return ViewStateWidget(
      onPressed: onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMsg,
      buttonText: buttonText,
      buttonTextData: buttonTextData ?? defaultTextData,
    );
  }
}
