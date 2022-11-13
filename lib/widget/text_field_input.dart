import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../consts/global_colors.dart';

class TextFieldInput extends StatelessWidget {
  TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  IconData icon;
  Color colorIcon;
  Color colorEnble;
  Color colorForcus;
   TextFieldInput({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    required this.icon,
    required this.colorIcon,
    required this.colorEnble,
    required this.colorForcus,
    required this.isPass,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isPass,
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).cardColor,

          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: colorEnble)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  width: 2,
                  color: colorForcus
              )
          ),
          suffixIcon: Icon(
            icon,
            color: colorIcon,
          )
      ),
    );
  }
}
