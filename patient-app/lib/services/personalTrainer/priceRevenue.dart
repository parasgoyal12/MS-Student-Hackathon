import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:flutter/material.dart';



class PriceRevenue extends StatesRebuilder {

  int activeFilter = 0;

  List<String> filters = ['Pricing',
    'Revenue'];

  List<String> serviceType = ["dfsfsf","fsdsfbs"];
  List<String> clientPrice = ["dfsfsf","fsdsfbs"];
  List<String> yourPayout = ["dfsfsf","fsdsfbs"];


  List<String> priceSubscriptions = ["asdadadad","adadfsgfgswef","afsgqrfqfrewfg"];
  int selectedSubscription = 1;




  void changeActiveFilter(int ind){
    activeFilter = ind;
    print(ind);
    rebuildStates();
  }

  Future<void> changeSubscription(int index) async{

    selectedSubscription = index;
    rebuildStates();

  }



}