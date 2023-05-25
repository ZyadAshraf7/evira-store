import 'package:evira_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CategoriesBox extends StatelessWidget {
  const CategoriesBox({Key? key, required this.isSelected, required this.title})
      : super(key: key);
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      decoration: BoxDecoration(
        color: isSelected == true ? AppTheme.primary500 : Colors.transparent,
        border: Border.all(color: AppTheme.primary500),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        title,
        style: AppTheme.bodyLargeSemiBold.copyWith(
            color: isSelected == true ? Colors.white : AppTheme.primary500),
      ),
    );
  }
}
