import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/calander/calaenderAdd.dart';
import 'package:treatment_checkup_app/services/personalTrainer/calanderHome.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:treatment_checkup_app/widgets/buttons.dart';



class CalenderHomeScreen extends StatefulWidget {
  @override
  _CalenderHomeScreenState createState() => _CalenderHomeScreenState();
}

class _CalenderHomeScreenState extends State<CalenderHomeScreen> {

  final calenderModel = Injector.get<CalenderHome>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff6c4791),
        title: Text( 'Calender',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.settings,color: Colors.white,size: 24,),
          ),
          IconButton(
            onPressed: (){

            },
            icon: Icon( Icons.notifications_none,
              color: Colors.white,
              size: 24.0,
            ),

          ),

        ],
      ),
      body: StateBuilder(
        models: [calenderModel],
        builder: (context,_){
          return  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                height: 75.0,
                decoration: BoxDecoration(
                    color: Color(0xff6c4791),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff6c4791).withAlpha(400),
                        blurRadius: 15.0,
                        spreadRadius: 0.0,
                        offset: Offset(
                          0.0,
                          5.0,
                        ),
                      ),
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          DateFormat("EE, MMM yy").format(calenderModel.currentDate),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold
                          ),
                      ),
                      Text(
                        DateFormat("yyyy").format(calenderModel.currentDate),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Expanded(

                  child: Container(

                    child: Column(
                      children: <Widget>[
                        Container(
                          //color: Colors.green,
                          height: MediaQuery.of(context).size.height/2,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20,right: 20),
                            child: CalendarCarousel(
                             weekDayFormat: WeekdayFormat.narrow,
                              weekdayTextStyle: TextStyle(
                                color: Colors.grey
                              ),
                              prevDaysTextStyle: TextStyle(color: Colors.transparent),
                              selectedDateTime: calenderModel.selectedDate,
                              selectedDayButtonColor: Color(0xff6c4791),
                              onDayPressed: (date,_){
                               calenderModel.changeSelectedDate(date);
                              },

                              selectedDayBorderColor: Colors.transparent,
                              headerTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 22
                              ),
                              todayButtonColor: Colors.red.withOpacity(0.5),
                              todayBorderColor: Colors.transparent,
                              minSelectedDate: DateTime.now().subtract(Duration(days: 1)),
                              maxSelectedDate: DateTime.now().add(Duration(days: 360)),
                              nextDaysTextStyle: TextStyle(
                                color: Colors.transparent
                              ),
                              iconColor: Colors.black,
                              selectedDayTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                              pageScrollPhysics: BouncingScrollPhysics(),
                              //daysHaveCircularBorder: false,

                            ),
                          ),
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width/3,
                              child: greyButton("Cancel",function: (){}),
                            ),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width/3,
                              child: purpleButton("OK",function: (){

                                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> CalenderAddInjector(calenderModel.selectedDate)));
                              }),
                            )

                          ],
                        )

                      ],
                    ),

                  )
              )

            ],

          );
        },
      )
    );
  }
}


