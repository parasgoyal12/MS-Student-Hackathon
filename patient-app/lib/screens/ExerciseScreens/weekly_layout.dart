import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:treatment_checkup_app/Localization/demo_localization.dart';
import 'package:treatment_checkup_app/Localization/localization_constant.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/main.dart';
import 'package:treatment_checkup_app/models/language.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/daily_layout.dart';
import 'package:treatment_checkup_app/widgets/bottom_nav_bar.dart';
import 'package:treatment_checkup_app/widgets/search_bar.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:treatment_checkup_app/widgets/game_screen/game_screen.dart';
class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  bool isLoading = true;
  bool isError = false;
  UserTypeService userService;
  List<TreatmentDayData> allDayExercises = [];
  List<List<Exercise>> weekExercises = [[], [], [], [], [], [], [], [], [], [], []];
  int weekSize = 0;
  int completedWeekSize=0;
  int curr_prog_day=1;
  Locale _locale;
  Future<void> getMyWeekProgress() async {

    try{
      allDayExercises = await userService.GetPatientWeekExerciseDetails();
      for(int i=0;i<allDayExercises.length;i++){

        int totalTime =0;
        for(int j=0;j<allDayExercises.length;j++){
          if(allDayExercises[i].todayDay == allDayExercises[j].todayDay){
            totalTime+=allDayExercises[j].duration*allDayExercises[j].exerciseRep;
          }
        }
        totalTime=(totalTime/60).toInt();
        weekExercises[(allDayExercises[i].todayDay-1)~/7].add(
          Exercise(
              day: allDayExercises[i].todayDay,
              image:allDayExercises[i].exerciseVideoUrl== '' ? 'https://jflowershealth.com/wp-content/uploads/2020/09/iStock-1172191646-1024x448.jpg' :'https://img.youtube.com/vi/${(Uri.tryParse(allDayExercises[i].exerciseVideoUrl)).queryParameters['v']}/0.jpg' ,
              title: allDayExercises[i].exerciseName,
              time: allDayExercises[i].duration.toString(),
              difficult: 'Medium',
              reps: allDayExercises[i].exerciseRep.toString(),
              url: allDayExercises[i].exerciseVideoUrl == ''?'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide' : allDayExercises[i].exerciseVideoUrl,
              text_instruct: allDayExercises[i].instructions,
              totalTime: totalTime.toString() +' '+getTranslated(context, "minutes")
          ),);
      }
      for(int i=0;i<weekExercises.length;i++){
        if(weekExercises[i].length != 0)
          completedWeekSize+=1;
      }
      //to get curr day
      for(int i=0;i<allDayExercises.length;i++){
        if(curr_prog_day< allDayExercises[i].todayDay)
          curr_prog_day =  allDayExercises[i].todayDay;
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      setState(() {
        isError = true;
      });
    }

  }
@override
void _changeLanguage(Language language) async {
  _locale = await setLocale(language.languageCode);
  print(language.languageCode);
  MyApp.setLocale(context, _locale);
  print(_locale);
}

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    isLoading = true;
    userService = UserTypeService();
    weekSize = weekExercises.length;
    getMyWeekProgress();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;


    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavBar(active_icon: [false,true,false],),
      //drawer: _drawerlist(),
      appBar: AppBar(   backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.info, color:  Color.fromRGBO(108, 71, 145, 1),size:30.0),
          onPressed: () => {
          showDialog(context: context,
          builder: (BuildContext context){
          return CustomDialogBox(
          );
          }
          )

          },
        ),
        elevation: 0,
        actions: <Widget>[Padding(padding: EdgeInsets.all(8.0)
        ,child: DropdownButton(dropdownColor: Colors.white,elevation: 10,focusColor: Color.fromRGBO(108, 71, 145, 1),

            onChanged: (Language language){
              _changeLanguage(language);
              RestartWidget.restartApp(context);
            },


            items:
            Language.languagelist().map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(value:lang,child:
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
            <Widget>[Text(lang.name,style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.w500),)]

            ))).toList(),
            icon:Icon(Icons.g_translate_outlined,color: Color.fromRGBO(108, 71, 145, 1),size: 40,)

          ),
        )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                    SizedBox(
//                      height: size.height * 0.05,
//                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated(context, "exercise"),

                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 0,top: 0,bottom: 0),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return RouteToGameScreen(curr_prog_day);
                                }),
                              );
                            },
                            elevation: 5,
                            color: Color.fromRGBO(108, 71, 145, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),

                            ),
                            child: Row(
                              children: [
                               Icon(Icons.feedback_outlined,color: Colors.white,size: 18,),
                                Text(" "+getTranslated(context, "feedback"),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 10),
                    // Text(
                    //   "3-10 MIN Course",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: Text(
                        getTranslated(context, "motivate_text"),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * .5, // it just take the 50% width
                          // height: size.height*.15
                          // ,
                          child:RadialProgress(
                            width: size.width * 0.4,
                            height: size.width * 0.4
                            ,
                            progress: completedWeekSize*1.0/weekSize*1.0,
                            left: weekSize-completedWeekSize*1.0,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: size.height*0.47,
                      child: GridView.count(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 1,mainAxisSpacing: 10.0,childAspectRatio:5 ,
                        shrinkWrap: true,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(weekSize, (index) {
                          return SeassionCard(seassionNum:index+1, isDone:weekExercises[index].length != 0?true:false,press: () {
                            if(weekExercises[index].length > 0){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DailyScreen(index+1,weekExercises[index]);
                                }),
                              );
                            }
                          }, );
                        }),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          isLoading == true? Container(
              color: Colors.black.withOpacity(0.5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator(),)):Container(),
          isError == true? CustomErrorBox() : Container(),
        ],
      ),
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
     print("curr day sent for feedback is "+widget.currDay.toString());
     List<Feedbak> qs = await userService.GetPatientFeedbackForm(widget.currDay.toString());
     print(qs);
     if(qs != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) {
          return GameScreen(qs, widget.currDay);
        })
      );
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


class CustomDialogBox extends StatefulWidget {



  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {

  UserTypeService userService;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();  userService= UserTypeService();
  }
  @override

  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          // margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(color: Colors.grey,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white ,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.transparent),
                        image: DecorationImage(
                          image: AssetImage('assets/images/iit.jpg'),
                          fit: BoxFit.fill,

                        )

                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white ,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.transparent),
                        image: DecorationImage(
                          image: AssetImage('assets/images/pgi.png'),
                          fit: BoxFit.fill,

                        )

                    ),
                  )
                ],
              ),
              Text("App developed by CSE IIT Ropar in collaboration with PGI Chandigarh",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Cairo',fontSize: 18,fontWeight: FontWeight.w400),),


            ],
          ),
        ),

      ],
    );
  }
}



class CustomErrorBox extends StatefulWidget {



  @override
  _CustomErrorBoxState createState() => _CustomErrorBoxState();
}
class _CustomErrorBoxState extends State<CustomErrorBox> {

  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          // margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(color: Colors.grey,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white ,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.transparent),
                        image: DecorationImage(
                          image: AssetImage('assets/images/pgi.png'),
                          fit: BoxFit.fill,

                        )

                    ),
                  )
                ],
              ),
              Text("Treatment has not been started by the Doctor, please contact PGI Chandigarh",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Cairo',fontSize: 18,fontWeight: FontWeight.w400),),


            ],
          ),
        ),

      ],
    );
  }
}