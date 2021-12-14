import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  final fieldKey;
  final String? initialValue;
  final bool? enable;
  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final Function(String)? onSave;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final Color? color;
  final Function? onEditingComplete;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final Function()? onTap;

  const GenericTextField(
      {Key? key,
      this.fieldKey,
      this.initialValue,
      this.enable,
      this.maxLength,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSave,
      this.validator,
      this.onFieldSubmitted,
      this.controller,
      this.color,
      this.onEditingComplete,
      this.textInputAction,
      this.maxLines,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: TextFormField(
          onSaved: (onSave) {
            print("kdfkldsmfkldsmfkl ");
          },
          // autovalidate: true,
          validator: (value) {
            if (value!.isEmpty) {
              return "EnterField";
            }

            return null;
          },
          enabled: enable,
          maxLines: maxLines,
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          onChanged: onFieldSubmitted,
          decoration: InputDecoration(
            // filled: true,
            border: InputBorder.none,
            hintText: hintText,
            labelText: labelText,
            labelStyle: TextStyle(
              color: Color(0xffA0A0A0),
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
        ),
      ),
    );
  }
}
