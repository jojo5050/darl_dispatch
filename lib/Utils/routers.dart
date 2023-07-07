import 'package:flutter/cupertino.dart';

class Routers {
  static void push(BuildContext context, Widget widget){
    Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => widget));
  }

  static void pushNamed(BuildContext context, String routeName, {dynamic arguments}){
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void replace(BuildContext context, Widget widget){
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => widget));
  }

  static void replaceAll(BuildContext context, Widget widget){
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => widget),
            (Route<dynamic> r) => false);
  }

  static void replaceAllWithName(BuildContext context, String routeName){
    Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
            (Route<dynamic> r) => false);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}