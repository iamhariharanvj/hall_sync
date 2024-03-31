import 'package:flutter/material.dart';

void snackBarError({String? msg, required GlobalKey<ScaffoldState> scaffoldState}) {
  
  ScaffoldMessenger.of(scaffoldState.currentState!.context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$msg"),
          const Icon(Icons.error)
        ],
      ),
    ),
  );
}