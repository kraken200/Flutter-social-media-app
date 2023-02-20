import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  late TextEditingController textEditingController;
  late bool isPass;
  late String hintText;
  late TextInputType textInputType;
  TextFieldInput(
      {Key? key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: InputBorder,
          border: InputBorder,
          focusedBorder: InputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
