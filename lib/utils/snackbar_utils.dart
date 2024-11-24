import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    const int snackbarDurationInSeconds = 3;
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 30,
            width: 30,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(seconds: snackbarDurationInSeconds),
              tween: Tween(begin: 1.0, end: 0.0),
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: value,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3.0,
                      backgroundColor: Colors.grey.withOpacity(0.4),
                    ),
                    Text(
                      (value * snackbarDurationInSeconds).ceil().toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: const Duration(seconds: snackbarDurationInSeconds),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
