import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:flutter/material.dart';



class CalenderHome extends StatesRebuilder{


  DateTime currentDate = DateTime.now();

  DateTime selectedDate  = DateTime.now();

//  void changeCurrentDate(DateTime dt){
//    currentDate = dt;
//    rebuildStates();
//  }

  void changeSelectedDate(DateTime date){
    currentDate = date;
    selectedDate = date;
    rebuildStates();
  }


}