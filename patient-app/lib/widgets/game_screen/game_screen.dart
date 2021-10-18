import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/configs/app_colors.dart';
import 'package:treatment_checkup_app/widgets/game_screen/quiz.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';

class GameScreen extends StatefulWidget {
  final List<Feedbak> questions;
  final int day;
  GameScreen(this.questions,this.day);
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isLoading;

  static const numberOfQuestions = 3;

  @override
  void initState() {
    super.initState();

    getQuestions();
  }

  void getQuestions() async {
    setState(() {
      isLoading = true;
    });



    if (widget.questions == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Ooops!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Try again'),
              onPressed: () {
                Navigator.pop(context);
                getQuestions();
              },
            ),
          ],
          backgroundColor: AppColors.dodgerBlue,
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Quiz(
          questions: widget.questions,day: widget.day,
        ),
      ),
    );
  }
}
