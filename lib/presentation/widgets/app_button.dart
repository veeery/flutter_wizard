

import 'package:flutter/material.dart';

import '../../common/app_color.dart';
import '../../common/app_curve_size.dart';

class AppButton extends StatelessWidget {
  Function() onTap;
  String? title;
  Color? color;

  AppButton({required this.onTap, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? AppColor.shadowColor,
      borderRadius: BorderRadius.circular(CurveSize.extraCurve),
      child: InkWell(
        splashColor: AppColor.shadowColor,
        borderRadius: BorderRadius.circular(CurveSize.extraCurve),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$title",
              maxLines: 2,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, height: 1.1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
