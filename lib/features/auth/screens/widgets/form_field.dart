import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String errorMessage;
  final Function(String) onValueChange;
  final String label;

  const CustomFormField(
      {Key? key,
      required this.errorMessage,
      required this.onValueChange,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: UnderlineInputBorder(),
          labelText: label,
          hintStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
          helperText: 'Not empty',
          errorText: errorMessage,
        ),
        cursorColor: Colors.black,
        textInputAction: TextInputAction.done,
        onChanged: onValueChange,
      ),
    );
  }
}
