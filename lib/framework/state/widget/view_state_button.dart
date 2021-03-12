/*
 * @Description: 视图状态组件的通用按钮
 * @Author: liuaobo
 * @Date: 2021-03-10 14:01:53
 * @LastEditTime: 2021-03-10 14:07:38
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flutter/material.dart';

class ViewStateButton extends StatelessWidget {
  final Widget child;
  final String textData;
  final VoidCallback onPressed;

  ViewStateButton({this.child, this.textData, @required this.onPressed})
      : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child ??
          Text(
            textData ?? "Retry",
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      highlightedBorderColor: Theme.of(context).splashColor,
      onPressed: onPressed,
    );
  }
}
