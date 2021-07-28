import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final ButtonStyle buttonStyle;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final double fontSize;
  final bool isTextButton;

  AdaptiveButton({
    @required this.onPressed,
    @required this.label,
    this.backgroundColor,
    this.buttonStyle,
    this.fontSize = 14.0,
    this.fontWeight,
    this.isTextButton = false,
  });
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: backgroundColor,
            onPressed: onPressed,
            child: Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                )),
          )
        : isTextButton
            ? TextButton(
                onPressed: onPressed,
                child: Text(label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    )),
              )
            : ElevatedButton(
                onPressed: onPressed,
                child: Text(label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    )),
                style: buttonStyle,
              );
  }
}
