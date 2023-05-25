import 'package:evira_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingSpinner(){
  return SpinKitCircle(
    // duration: duration??const Duration(seconds: 2),
    size: 50,
    itemBuilder: (BuildContext context, int index) {
      return const DecoratedBox(
        decoration: BoxDecoration(
          color: AppTheme.primary500,
        ),
      );
    },
  );
}