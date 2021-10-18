import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:flutter/material.dart';



class ClientsHome extends StatesRebuilder {

  int activeFilter = 0;

  List<String> dayFilters = ['ALL',
    'TODAY',
    'TOMORROW',
    'WEEK',
    'PENDING'];

  void changeActiveFilter(int ind){
        activeFilter = ind;
        print(ind);
        rebuildStates();
  }



}