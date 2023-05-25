import 'package:evira_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.buttonColor,
      this.titleColor})
      : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Color? buttonColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.resolveWith<Size>(
          (Set<MaterialState> states) {
            return const Size(100, 55);
          }
        ),
        maximumSize: MaterialStateProperty.resolveWith<Size>(
                (Set<MaterialState> states) {
              return  Size(size.width-48, 55);
            }
        ),
        elevation: MaterialStateProperty.all<double>(10),
        shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor??AppTheme.primary500),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      child: Text(
        title,
        style: AppTheme.bodyLargeBold.copyWith(color: titleColor??Colors.white),
      ),
    );
  }
}
