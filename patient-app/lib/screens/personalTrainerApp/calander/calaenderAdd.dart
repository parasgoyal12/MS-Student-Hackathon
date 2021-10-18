import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/services/personalTrainer/calanderAdd.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:treatment_checkup_app/widgets/buttons.dart';

class CalenderAddInjector extends StatelessWidget {
  final DateTime date;

  CalenderAddInjector(this.date);

  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [
        Inject(() => CalenderAdd(date)),
      ],
      builder: (context) => CalendarAddPage(),
    );
  }
}

class CalendarAddPage extends StatefulWidget {
  @override
  _CalendarAddPageState createState() => _CalendarAddPageState();
}

class _CalendarAddPageState extends State<CalendarAddPage> {
  final calendarAddModel = Injector.get<CalenderAdd>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calendar Add",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff6c4791),
        ),
        body: StateBuilder(
            models: [calendarAddModel],
            builder: (context, _) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height/8,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(400),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                        ),
                      ]),

                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 30, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              DateFormat("EE, MMM yy")
                                  .format(calendarAddModel.selectedDate),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat("yyyy")
                                  .format(calendarAddModel.selectedDate),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                //fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Add Sessions",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Default Session : 60 minutes",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Select Dates",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => SomeCalendar(
                                        scrollDirection: Axis.horizontal,
                                        mode: SomeMode.Multi,
                                        isWithoutDialog: false,
                                        //selectedDate: ,
                                        startDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(Duration(days: 900)),
                                        done: (date) {
                                          setState(() {
                                            //selectedDate = date;
                                            print(date.toString());
                                          });
                                        },
                                      ));
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(400),
                                      blurRadius: 4.0,
                                      spreadRadius: -3.0,
                                      offset: Offset(
                                        0.0,
                                        0.0,
                                      ),
                                    ),
                                  ]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Select Dates",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "From",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    maxDateTime: calendarAddModel.maxFromTime,
                                    initialDateTime: calendarAddModel.fromTime,
                                    dateFormat: "HH : mm",
                                    pickerMode: DateTimePickerMode.time,
                                    // show TimePicker

                                    onConfirm: (dateTime, List<int> index) {
                                      calendarAddModel
                                          .calenderFromSet(dateTime);
                                    },

                                  );
                                },
                                child: Container(
                                  height: 45,
                                  //width: MediaQuery.of(context).size.width/4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(400),
                                          blurRadius: 4.0,
                                          spreadRadius: -3.0,
                                          offset: Offset(
                                            0.0,
                                            0.0,
                                          ),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Center(
                                      child: Text(
                                        DateFormat("hh:mma")
                                            .format(calendarAddModel.fromTime),
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(":"),
                              InkWell(
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    initialDateTime: calendarAddModel.fromTime.add(Duration(hours: 1)),
                                    minDateTime: calendarAddModel.fromTime,
                                    //maxDateTime: calendarAddModel.maxToTime,
                                    dateFormat: "HH : mm",
                                    pickerMode: DateTimePickerMode.time,
                                    // show TimePicker

                                    onConfirm: (dateTime, List<int> index) {
                                        print(dateTime.toIso8601String());
                                        calendarAddModel
                                            .calenderToSet(dateTime);
                                    },
                                  );
                                },
                                child: Container(
                                  height: 45,
                                  //width: MediaQuery.of(context).size.width/4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(400),
                                          blurRadius: 4.0,
                                          spreadRadius: -3.0,
                                          offset: Offset(
                                            0.0,
                                            0.0,
                                          ),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Center(
                                      child: Text(
                                        DateFormat("hh:mma")
                                            .format(calendarAddModel.toTime),
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  calendarAddModel.addCurrentTimeRange();
                                },
                                child: Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Color(0xff6c4791),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ADD",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Text(
                            "Days",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            onTap: () {
//                              showDialog(
//                                  context: context,
//                                  builder: (_) => SomeCalendar(
//                                    scrollDirection: Axis.horizontal,
//                                    mode: SomeMode.Multi,
//                                    isWithoutDialog: false,
//                                    //selectedDate: ,
//                                    startDate: DateTime.now(),
//                                    lastDate: DateTime.now()
//                                        .add(Duration(days: 900)),
//                                    done: (date) {
//                                      setState(() {
//                                        //selectedDate = date;
//                                        print(date.toString());
//                                      });
//                                    },
//                                  ));
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(400),
                                      blurRadius: 4.0,
                                      spreadRadius: -3.0,
                                      offset: Offset(
                                        0.0,
                                        0.0,
                                      ),
                                    ),
                                  ]),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Mark As Default",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          calendarAddModel.startTimes.length == 0 ?
                          Container()
                              :
                          Container(
                                margin: EdgeInsets.only(left: 0,right: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.4)
                                    ),
                                    ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: calendarAddModel.startTimes.length,
                                  itemBuilder: (context,i){
                                    return Column(

                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,top: 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  DateFormat("hh:mma").format(calendarAddModel.startTimes[i])
                                                      +" to "+
                                                      DateFormat("hh:mma").format(calendarAddModel.endTimes[i]),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  calendarAddModel.removeCurrentTimeRange(i);
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black),
                                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  ),
                                                  child: Center(
                                                    child: Icon(Icons.remove,size: 17,),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        i == calendarAddModel.startTimes.length-1 ?
                                        Padding(padding: EdgeInsets.only(bottom: 8),)
                                            :
                                        Divider()
                                      ],
                                    );
                                  },
                                ),

                              ),


                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                                //width: 2*MediaQuery.of(context).size.width/5,
                                child: greyButton("Mark As Leave",function: (){


                                }),
                              ),
                              SizedBox(
                                height: 40,
                                width: 1.5*MediaQuery.of(context).size.width/5,
                                child: purpleButton("Add",function: (){
                                }),
                              )
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
