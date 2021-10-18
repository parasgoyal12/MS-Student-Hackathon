import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treatment_checkup_app/Localization/localization_constant.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:treatment_checkup_app/widgets/bottom_nav_bar.dart';
import 'package:treatment_checkup_app/widgets/search_bar.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';

import 'activity_detail.dart';
class DailyScreen extends StatefulWidget {
  final int weekNumber;
  final List<Exercise> thisWeekExercise;
  DailyScreen(this.weekNumber,this.thisWeekExercise);
  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  int count = 0;
  int completedDaySize=0;
  List<List<Exercise>> exercises = [[], [], [], [], [], [], []];

  getMyWeekProgress() async {
    for(int i=0;i<widget.thisWeekExercise.length;i++){
      exercises[(widget.thisWeekExercise[i].day-1)%7].add(widget.thisWeekExercise[i]);
    }
    for(int i=0;i<exercises.length;i++){
      if(exercises[i].length != 0)
        completedDaySize+=1;
    }
    setState(() {

    });
  }
  @override
  void initState() {
    getMyWeekProgress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(active_icon:[false,true,false]),
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
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      getTranslated(context, "exercise"),
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
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
                          getTranslated(context, "motivate_text")
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5, // it just take the 50% width
                      child:RadialProgress(
                        width: size.width * 0.4,
                        height: size.width * 0.4,
                        progress: completedDaySize*1.0/7.0,
                        left: 7-completedDaySize*1.0,
                        type: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.45,
                      child: GridView.count(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 2,mainAxisSpacing: 15.0,crossAxisSpacing: 5.0,childAspectRatio:2.5 ,
                        shrinkWrap: true,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(7, (index) {
                          return SeassionCard(seassionNum:index+1, isDone:exercises[index].length != 0?true:false,type: 1,press: () {
                            if(exercises[index].length > 0){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return ActivityDetail(
                                        exercises: exercises[index],
                                        tag: 'imageHeader$count',
                                        day : index+1
                                    );
                                  },
                                ),
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
        ],
      ),
    );
  }
}
