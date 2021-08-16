import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
  final String label;

  const TxtField({Key? key, required this.label}) : super(key: key);

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
  TextFieldBox({this.hnt, @required this.typr, this.icons, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      // color: grey,
      child: TextField(
        autofocus: false,
        keyboardType: typr,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          prefixIcon: icons,
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.black, width: 2.0),
          // ),
          // enabledBorder: InputBorder.none,
          // errorBorder: InputBorder.none,
          // disabledBorder: InputBorder.none,
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.black54, width: 2.0),
          // ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 2.0),
          ),
          errorBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: hnt,
        ),
      ),
    );
  }
}
