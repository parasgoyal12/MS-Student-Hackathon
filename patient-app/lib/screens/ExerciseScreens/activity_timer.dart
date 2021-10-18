import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:treatment_checkup_app/Localization/localization_constant.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/daily_layout.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:treatment_checkup_app/widgets/game_screen/game_screen.dart';
import 'package:treatment_checkup_app/widgets/result_screen/result_screen_exercise.dart';

import 'video_player.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ActivityTimer extends StatelessWidget {
  final List<Exercise> exercises;
  final int index;
  final String image =
    'https://www.verywellhealth.com/thmb/Jz6oLND-JaSfigh7oNu8ylHl-HY=/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-01-2696480-Dorisflexion-598ca2a40d327a0010eb724e.gif';
  final String tag = 'imageHeader';
  ActivityTimer({
    @required this.exercises,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: OrientationBuilder(builder: (context, orientation) {
          return Portrait(image: this.image, tag: this.tag,exercises: this.exercises,index:this.index);

        }),
      ),
    );
  }
}

class Portrait extends StatelessWidget {
  final FlutterTts textsespeech =FlutterTts();
  final String image, tag;
 final List<Exercise> exercises;
 final int index;
  Portrait({@required this.image, @required this.tag, @required this.exercises,@required this.index});

  @override
  Widget build(BuildContext context) {
    final FlutterTts textsespeech =FlutterTts();
    @override
    Future _speak() async{

      await textsespeech.setLanguage("en-IN");
      await textsespeech.setSpeechRate(1);
      await textsespeech.setPitch(1);

     await textsespeech.speak(this.exercises[this.index].title);
    }
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Hero(
              tag: this.tag,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                child: Image.network(
                  this.exercises[this.index].image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Icon(
                        Icons.videocam_outlined,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    onTap: () {  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return VideoPlayer(exercise: this.exercises[this.index],);
                      }),
                    );
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Icon(
                        Icons.record_voice_over,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    onTap: (){  _speak(); }
                    )


                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
          height: size.height - 270.0,
          width: size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      this.exercises[this.index].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                  this.index!=exercises.length-1? getTranslated(context, "next")+':'+ this.exercises[this.index+1].title:getTranslated(context, "next") +' : '+getTranslated(context, "rest"),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CircularPercentIndicator(
                      radius: size.width * 0.60,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 16.0,
                      percent: 1.00,
                      center: new Text(
                       'X'+ this.exercises[this.index].reps,
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[400],
                        ),
                      ),
                      backgroundColor: Colors.grey[300],
                      circularStrokeCap: CircularStrokeCap.round,
                      linearGradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(190, 130, 255, 1.0),
                          Color.fromRGBO(105, 139, 255, 1.0),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        getTranslated(context, "next_explain"),
                       textAlign: TextAlign.center,
                       style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return this.index!=0?ActivityTimer(exercises: this.exercises, index: this.index-1) : ResultScreenExercise(); //TODO
                        }),
                      );
                    },
                    child: Container(
                      width: 80.0,
                      height: 55.0,
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 242, 248, 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Color.fromRGBO(82, 126, 255, 1.0),
                        size: 35.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return this.index!=exercises.length-1?ActivityTimer(exercises: this.exercises, index: this.index+1): RouteToGameScreen(exercises[0].day);
                        }),
                      );
                    },
                    child: Container(
                      width: size.width - 130.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 242, 248, 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          getTranslated(context, "next"),
                          style: TextStyle(
                            color: Color.fromRGBO(82, 126, 255, 1.0),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class RouteToGameScreen extends StatefulWidget {

  final int currDay;
  RouteToGameScreen(this.currDay);
  @override
  _RouteToGameScreenState createState() => _RouteToGameScreenState();
}

class _RouteToGameScreenState extends State<RouteToGameScreen> {



  UserTypeService userService;
  bool isLoading;
  Future<void> getMyWeekProgress() async {
    print("curr day sent is "+widget.currDay.toString());
    bool status = await userService.UpdateDayExerciseStatus(widget.currDay);
    print(status);
    if(status == true){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) {
          return  ResultScreenExercise(); //TODO
        }),
      );


      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) {
      //     return DetailsScreen();
      //   }),
      // );
    }
  }


  @override
  void initState() {
    isLoading = true;
    userService = UserTypeService();
    getMyWeekProgress();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitFoldingCube(color: Colors.green),
      ),
    );
  }
}