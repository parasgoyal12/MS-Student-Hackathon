import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/Localization/localization_constant.dart';
import 'package:treatment_checkup_app/configs/app_colors.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';
import 'package:treatment_checkup_app/screens/welcomeBoarding/welcomeBoarding.dart';
import 'package:treatment_checkup_app/widgets/common/button.dart';
import 'package:treatment_checkup_app/widgets/game_screen/game_screen.dart';

class ResultScreenExercise extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Card(
                margin: EdgeInsets.all(20),
                color: Colors.white70

                ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Center(child: Icon(Icons.check_circle,size: 120.0,color: Colors.green
                      ,)),
                    Center(
                      child: Text(
                       getTranslated(context, "exercise_recorded"),
                        style: TextStyle(fontFamily:'Cairo',fontSize: 20, fontWeight: FontWeight.w900,color: Colors.deepPurple
                        ),
                      ),
                    ),
                    Center(
                      child: Text(

                        getTranslated(context, 'relative_can_cnfm'),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily:'Cairo',fontSize: 20,color: Colors.green),
                      ),
                    ),
                    Center(
                      child: Text(
                        getTranslated(context, "consider_feedback"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily:'Cairo',fontSize: 18, color: Colors.deepPurple
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      child:  Text(getTranslated(context, 'proceed'),style: TextStyle(fontFamily:'Cairo',fontSize: 20,color:Colors.white),),elevation: 10.0,
                      color: Colors.green,
                      splashColor: Colors.lightBlueAccent,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) => DetailsScreen()),
                                (Route<dynamic> route) => route is WelcomeBoarding
                        );
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) {
                        //     return DetailsScreen();
                        //   }),
                        // );
                      }),
                  // Button(
                  //     buttonLabel: 'Assess Again',
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => GameScreen(),
                  //         ),
                  //       );
                  //     }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}