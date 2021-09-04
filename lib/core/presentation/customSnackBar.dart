import 'package:flutter/material.dart';

enum LunchBarEvents {
  LunchBarError,
  LunchBarSuccess,
}

SnackBar LunchBars(
    {required String lunchBarText, required LunchBarEvents event}) {
  IconData icon = Icons.error;
  if (event == LunchBarEvents.LunchBarSuccess) {
    icon = Icons.verified;
  }

  return SnackBar(
      content: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          SizedBox(
            width: 20,
          ),
          Text(lunchBarText, style: TextStyle(fontSize: 16)),
        ],
      ),
      // backgroundColor: ,
      behavior: SnackBarBehavior.floating);
}
