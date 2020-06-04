import 'package:flutter/material.dart';
import 'constants.dart';


class CustomTextField extends StatelessWidget {
  final String initialValue;
  final Function onChanged;
  final String hint;
  final bool error;
  final Color fillColor;
  final Color textColor;
  final double height;
  final double width;
  final bool filled;
  final double radius;
  final Color prefixIconColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double prefixIconOpacity;
  final validator;
  final Color hintColor;
  final Color cursorColor;
  final double hintOpacity;
  final int maxLength;
  final bool obscureText;
  final Color bgColor;
  final double bgOpacity;
  final Widget suffix;
  final IconData prefixIcon;

  CustomTextField({
    this.initialValue = "",
    this.textColor = Colors.white,
    this.validator,
    this.prefixIconColor = Colors.white,
    this.prefixIconOpacity = 0.8,
    this.bgColor = Colors.white,
    this.height = 60,
    this.width = double.infinity,
    this.maxLength = 100,
    this.radius = 40,
    this.bgOpacity = 0.4,
    this.fillColor = Colors.white,
    this.cursorColor = Colors.white,
    this.filled = false,
    this.hintOpacity = 0.8,
    this.verticalPadding = 0,
    this.horizontalPadding = 10,
    this.hintColor = Colors.white,
    this.error = false,
    this.suffix,
    this.onChanged,
    this.prefixIcon,
    this.hint = "",
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: bgColor.withOpacity(bgOpacity),
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        alignment: Alignment.center,
        child: TextFormField(
            validator: validator,
            initialValue: initialValue,
            maxLength: maxLength,
            cursorColor: cursorColor,
            onChanged: onChanged == null ? (text) {} : onChanged,
            obscureText: obscureText,
            decoration: prefixIcon == null
                ? inputDecoration.copyWith(
              hintText: hint,
              suffix: suffix,
              hintStyle: poppinsLight.copyWith(
                color: error
                    ? Colors.red.withOpacity(0.7)
                    : hintColor.withOpacity(0.8),
                fontSize: 20,
              ),
              filled: filled,
              fillColor: fillColor,
            )
                : inputDecoration.copyWith(
              filled: filled,
              fillColor: fillColor,
              suffix: suffix,
              hintText: hint,
              hintStyle: poppinsMedium.copyWith(
                color: error
                    ? Colors.red.withOpacity(0.7)
                    : hintColor.withOpacity(hintOpacity),
                fontSize: 20,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: error
                    ? Colors.red.withOpacity(0.7)
                    : prefixIconColor.withOpacity(prefixIconOpacity),
              ),
            ),
            style: poppinsMedium.copyWith(color: textColor, fontSize: 20)),
      ),
    );
  }
}

