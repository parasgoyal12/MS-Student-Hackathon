import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/bottom_navigation_bar/src/flip_bar_item.dart';
import 'package:treatment_checkup_app/bottom_navigation_bar/src/flip_box_bar.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/account/AccountHome.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/clientsHome/clientsHomePage.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/pricingRevenue/pricingAndRevenue.dart';
import 'package:treatment_checkup_app/services/personalTrainer/calanderHome.dart';
import 'package:treatment_checkup_app/services/personalTrainer/clientHome.dart';
import 'package:treatment_checkup_app/services/personalTrainer/priceRevenue.dart';

import 'calander/calanderHome.dart';



class PersonalTrainerHomeInjector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(

      inject: [
        Inject(() => CalenderHome()),
        Inject(() => PriceRevenue()),
        Inject(() => ClientsHome())
      ],
      builder: (_) {

        print("Reinjected");

        return PersonalTrainerHome();
      },
    );
  }
}

class PersonalTrainerHome extends StatefulWidget {
  @override
  _PersonalTrainerHomeState createState() => _PersonalTrainerHomeState();
}

class _PersonalTrainerHomeState extends State<PersonalTrainerHome> with SingleTickerProviderStateMixin{

  int selectedIndex;
  TabController _tabControll;

  List<Widget> pages = [
    ClientsPersonalTrainer(),
    CalenderHomeScreen(),
    PricingRevenueHome(),
    //CustomerProfileForTrainers(),
    AccountHome(),


    //Container(child: Icon(Icons.directions_bike)),
    // Container(child: Icon(Icons.directions_bike)),
  ];

  @override
  void initState() {
    _tabControll = new TabController(length: 4, vsync: this);
    selectedIndex = 0;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        children: pages,
        index: _tabControll.index,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(42,42,42, 0.5),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(
                0.0,
                0.0,
              ),
            )
          ]
        ),
        child: FlipBoxBar(
          selectedIndex: selectedIndex,
          items: [
            FlipBarItem(
                iconTop: Icon(Icons.home),
                iconBottom: Icon(Icons.home,color: Colors.white,),
                textTop: Text("Clients"),
                textBottom: Text("Clients",style: TextStyle(color: Colors.white),),
                frontColor: Colors.white, backColor: Color.fromRGBO(108, 71, 145, 1)
            ),
            FlipBarItem(
                iconTop: Icon(Icons.calendar_today),
                iconBottom: Icon(Icons.calendar_today,color: Colors.white,),
                textTop: Text("Calendar"), textBottom: Text("Calendar",style: TextStyle(color: Colors.white),),
                frontColor: Colors.white, backColor: Color.fromRGBO(108, 71, 145, 1)
            ),
            FlipBarItem(
                iconTop: Icon(Icons.monetization_on),
                iconBottom: Icon(Icons.monetization_on,color: Colors.white,),
                textTop: Text("Pricing"),
                textBottom: Text("Pricing",style: TextStyle(color: Colors.white),),
                frontColor: Colors.white, backColor: Color.fromRGBO(108, 71, 145, 1)
            ),
            FlipBarItem(
                iconTop: Icon(Icons.person),
                iconBottom: Icon(Icons.person,color: Colors.white,),
                textTop: Text("Account"),
                textBottom: Text("Account",style: TextStyle(color: Colors.white),),
                frontColor: Colors.white, backColor: Color.fromRGBO(108, 71, 145, 1)
            ),
          ],
          onIndexChanged: (newIndex) async {
            selectedIndex = newIndex;
            await Future.delayed(const Duration(milliseconds: 500),(){
              _tabControll.animateTo(newIndex);
            });
            setState((){
            });
          },
        ),
      ),
    );
  }
}
