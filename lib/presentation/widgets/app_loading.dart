
import 'package:flutter/material.dart';

import '../../common/app_color.dart';

class AppLoading extends StatelessWidget {
  final Color? color;

  AppLoading({this.color});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color ?? AppColor.kMikadoYellow));
  }
}
