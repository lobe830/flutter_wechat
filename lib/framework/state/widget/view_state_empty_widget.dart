/*
 * @Description: 空数widget
 * @Author: liuaobo
 * @Date: 2021-03-10 13:51:02
 * @LastEditTime: 2021-03-10 14:27:19
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flutter/material.dart';
import 'package:flutterwechat/resource/font/IconFont.dart';

import 'view_state_widget.dart';

class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateEmptyWidget(
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
          const Icon(IconFont.pageEmpty, size: 100, color: Colors.grey),
      title: message ?? "404 Error",
      buttonText: buttonText,
      buttonTextData: "Refresh",
    );
  }
}
