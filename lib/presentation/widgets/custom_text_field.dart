import 'package:evira_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
   CustomTextField({Key? key,
    required this.controller,
    required this.hintText,
    required this.iconPath, this.isPasswordField, required this.obsecure, this.validator, this.readOnly, this.onSubmit})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String iconPath;
  final bool? isPasswordField;
  late bool obsecure;
  final String? Function(String?)? validator;
  final bool?readOnly;
  final void Function(String)? onSubmit;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTheme.bodyMediumSemiBold,
      controller: widget.controller,
      obscureText: widget.isPasswordField != null ? widget.obsecure : false,
      validator: widget.validator,
      readOnly: widget.readOnly==null?false:true,
      onFieldSubmitted: widget.onSubmit,
      decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: SizedBox(
            child: SvgPicture.asset(
              widget.iconPath, fit: BoxFit.scaleDown,
              color: AppTheme.primary500,
            ),
          ),
          suffixIcon: widget.isPasswordField != null ? InkWell(
            onTap: (){
              setState(() {
                widget.obsecure=!widget.obsecure;
              });
            },
            child: SizedBox(
              child: SvgPicture.asset(
                widget.obsecure?"assets/icons/Hide.svg":"assets/icons/Show.svg", fit: BoxFit.scaleDown,
                color: AppTheme.primary500,
              ),
            ),
          ) : const SizedBox()
      ),
    );
  }
}
