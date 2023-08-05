
import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';

Widget customAlertDialog(
    {required BuildContext context,
      required String title,
      required String description,
      required String imagePath,
      bool? hasLoading,
    Widget ?body}){
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0))),
    alignment: Alignment.center,
      titlePadding: const EdgeInsets.symmetric(vertical: 40,horizontal: 32),
      title: Column(
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 32),
          Text(title,style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.primary500)),
          const SizedBox(height: 16),
          Text(description,style: AppTheme.bodyLargeRegular.copyWith(color: AppTheme.grey900),textAlign: TextAlign.center,),
          const SizedBox(height: 32),
          (hasLoading==null || hasLoading==true)?loadingSpinner():
          (body!=null)?body:const SizedBox()
        ],
      ),
  );
}