import 'package:flutter/services.dart';
import 'package:states_rebuilder/states_rebuilder.dart';




class CalenderAdd extends StatesRebuilder{


  DateTime selectedDate,fromTime,toTime,maxFromTime,maxToTime;


  List<DateTime> startTimes=[],endTimes=[];


  void addCurrentTimeRange(){

    if(fromTime.isBefore(toTime)){
      startTimes.add(fromTime);
      endTimes.add(toTime);
      rebuildStates();
    }
}
  void removeCurrentTimeRange(int i){


    startTimes.removeAt(i);
    endTimes.removeAt(i);
    rebuildStates();

  }


  CalenderAdd(DateTime date){
    selectedDate = date;
    fromTime = DateTime(2020,1,1,9,0,0,0);
    toTime = DateTime(2020,1,1,10,0,0,0);
    maxFromTime = DateTime(2020,1,1,23,0,0,0);
    maxToTime = DateTime(2020,1,1,24,0,0,0);
  }

  void calenderFromSet(DateTime date){

    fromTime = date;
    rebuildStates();
  }

  void calenderToSet(DateTime date){
    print("inside");
    toTime = date;
    rebuildStates();
  }







}