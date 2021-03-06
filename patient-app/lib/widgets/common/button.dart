import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/configs/app_colors.dart';
// TODO: Understand This File
class Button extends StatelessWidget {
  final String buttonLabel;
  final Function onPressed;

  Button({@required this.buttonLabel, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 120,
      height: 60,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Theme.of(context).accentColor,
        disabledColor: AppColors.darkSlateBlue,
        child: Text(
          buttonLabel,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}