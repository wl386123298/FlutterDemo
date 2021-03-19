import 'package:flutter/material.dart';


Widget commonAppBar({String title ="None", Widget leading, List<Widget> actions, PreferredSizeWidget bottom}){
  return AppBar(
    leading: leading??null,
    actions: actions?? [],
    bottom: bottom??null,
    centerTitle: true,
    elevation: 0.3,
    title: Text(title, style: TextStyle(fontSize: 16),),
  );
}