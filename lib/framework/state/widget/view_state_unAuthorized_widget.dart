/*
 * @Description: 页面未授权的提示组件
 * @Author: liuaobo
 * @Date: 2021-03-10 14:28:13
 * @LastEditTime: 2021-03-10 14:46:14
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flutter/material.dart';
import 'package:flutterwechat/framework/state/widget/view_state_widget.dart';
import 'package:flutterwechat/resource/font/IconFont.dart';

class ViewStateUnAuthorizedWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  ViewStateUnAuthorizedWidget(
      {Key key,
      this.message,
      this.image,
      this.buttonText,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: onPressed,
      image: image ??
          const Icon(IconFont.pageUnAuth, size: 100, color: Colors.grey),
      buttonText: buttonText,
      buttonTextData: "Login",
    );
  }
}
