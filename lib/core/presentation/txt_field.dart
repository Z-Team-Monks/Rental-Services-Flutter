import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  TxtField(
      {Key? key,
      required this.label,
      this.initialValue,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
          ),
          SizedBox(
            height: 7,
          ),
          TextFieldBox(
            typr: TextInputType.text,
            initVal: initialValue,
            validator: validator,
            controller: controller,
          ),
        ],
      ),
    );
  }
}

class TextFieldBox extends StatelessWidget {
  final String? hnt;
  final TextInputType? typr;
  final Icon? icons;
  final TextEditingController? controller;
  final String? initVal;
  final String? Function(String?)? validator;

  TextFieldBox(
      {this.hnt,
      @required this.typr,
      this.icons,
      this.controller,
      this.validator,
      this.initVal});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      // color: grey,
      child: TextFormField(
        initialValue: initVal,
        autofocus: false,
        validator: validator,
        keyboardType: typr,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          prefixIcon: icons,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 2.0),
          ),
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: hnt,
        ),
      ),
    );
  }
}
