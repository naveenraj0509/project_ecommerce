import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String Text;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? hintTextColor;
  final EdgeInsetsGeometry? contentPadding;

  final bool? obscureText;
  const TextFieldWidget(
      {super.key,
      required this.Text,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.fillColor,
      this.contentPadding,
      this.hintTextColor});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText ?? false,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        fillColor: widget.fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.transparent),
        ),
        filled: true,
        hintText: widget.Text,
        hintStyle:
            TextStyle(color: widget.hintTextColor, fontWeight: FontWeight.w900),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: Colors.white,
        ),
        suffixIcon: widget.suffixIcon ?? SizedBox(),
        // border: OutlineInputBorder(ena
        //     borderRadius: BorderRadius.circular(5),
        //     borderSide: BorderSide(color: Colors.yellow)),
      ),
    );
  }
}
