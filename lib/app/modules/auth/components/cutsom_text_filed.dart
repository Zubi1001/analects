import 'package:analects/app/data/contents/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final VoidCallback? Function(String?)? changeFunction;
  final VoidCallback? Function(String?)? completeFunction;
  final bool isPasswordField;
  final int maxlines;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.focusNode,
    super.key,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.changeFunction,
    this.completeFunction,
    this.isPasswordField = false,  this.maxlines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: widget.isPasswordField && isObscure,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onChanged: widget.changeFunction,
      onFieldSubmitted: widget.completeFunction,
      maxLines: widget.maxlines,
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
      decoration: InputDecoration(
        fillColor: AppColors.kPrimary1Color,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
        suffixIcon: widget.isPasswordField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: AppColors.kWhiteColor.withOpacity(.5), fontSize: 16.w),
        filled: true,
      ),
    );
  }
}
