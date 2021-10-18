import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:treatment_checkup_app/widgets/buttons.dart';


class PricingAndRevenueCenterInjector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PricingAndRevenueHome();
  }
}



class PricingAndRevenueHome extends StatefulWidget {
  @override
  _PricingAndRevenueHomeState createState() => _PricingAndRevenueHomeState();
}

class _PricingAndRevenueHomeState extends State<PricingAndRevenueHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(child: Pricing()),
        ],
      )
    );
  }
}


class Pricing extends StatefulWidget {
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {

  bool isFreeTrialOn = false;

  Widget buildPriceTile(String desc,String price,Function edit){
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(desc,
              style: TextStyle(
                color: Colors.grey,
                  fontSize: 12
              ),
              ),
              SizedBox(
                height: 5,
              ),
              Text( price,
                style: TextStyle(
                color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),
              ),
            ],
          ),
          SizedBox(
              height: 25,
              width: 70,
              child: purpleButton("EDIT",function: (){edit();},fontSz: 12)
          )
        ],
      ),
    );
  }


  Future<String> temp() async {
    await Future.delayed(Duration(seconds: 1));
    return "Test";
  }

  Widget buildCardListItems(){
    String title = "Only Gym";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.only(top: 20,left: 10),
          child: Text(title,
            style: TextStyle(
              color: Color.fromRGBO(108, 71, 145,1),
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          elevation: 3,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context,ind){

            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom:15,right: 20,left: 20),
                  child: buildPriceTile("Per Session Price","Rs. 299",(){
                    print("edit pressed");
                  }),
                ),
                Divider(
                  height: 0,
                ),
              ],
            );
          }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(
              color: Colors.black12
            )
          ),

        ),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 100,bottom: 20),
        child: FutureBuilder<String>(
            future: temp(),
            builder: (context, snapshot){
              if(snapshot.connectionState ==
                  ConnectionState.done){
                if(snapshot.hasData){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            border: Border.all(color: Colors.black38)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30,right: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Text("Free Trial Offer ?"),
                              ),
                              Switch(
                                value: isFreeTrialOn,
                                onChanged: (val){
                                  setState(() {
                                    isFreeTrialOn = val;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20,bottom: 20,right: 20,left: 20),
                          child: buildPriceTile("Per Session Price","Rs. 299",(){
                            print("edit pressed");
                          }),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                            side: BorderSide(
                                color: Colors.black12
                            )
                        ),

                      ),

                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (item,ind){
                            return buildCardListItems();
                          })

                    ],
                  );
                }
                else if(snapshot.hasError){
                  return InkWell(
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                                "ERROR OCCURRED, Tap to retry !"),
                          ),
                        ),
                      ),
                      onTap: () => setState(() {
                        temp();
                      }));
                }

              }
              return SpinKitWave(
                color: Color.fromRGBO(198, 240, 231, 1),
                size: 50,
              );
            }
        ),





      ),
    );
  }
}

