/*
 * @Description: 数据加载中的widget
 * @Author: liuaobo
 * @Date: 2021-03-10 13:48:13
 * @LastEditTime: 2021-03-10 13:50:36
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'package:flutter/material.dart';

class ViewStateLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
