import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/helping_Screens/notification_personalTrainer.dart';
import 'package:treatment_checkup_app/services/personalTrainer/priceRevenue.dart';
import 'package:treatment_checkup_app/widgets/clickableTabBarButton.dart';




class PricingRevenueHome extends StatefulWidget {
  @override
  _PricingRevenueHomeState createState() => _PricingRevenueHomeState();
}

class _PricingRevenueHomeState extends State<PricingRevenueHome> {

  final priceModel = Injector.get<PriceRevenue>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff6c4791),
        title: Text( 'Pricing & Revenue',
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
            icon: Icon(Icons.add,color: Colors.white,size: 24,),
          ),
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationFC())
              );
            },
            icon: Icon( Icons.notifications_none,
              color: Colors.white,
              size: 24.0,
            ),

          ),
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.more_vert,color: Colors.white,size: 24,),
          ),
        ],
      ),
      body: StateBuilder(
        models: [priceModel],
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  ClickableTitleWithModel(priceModel.filters[0],0,priceModel),
                  ClickableTitleWithModel(priceModel.filters[1],1,priceModel),
                  ],
                ),
              ),

              Expanded(

                child: priceModel.activeFilter ==0 ?

                    Pricing()
                    :
                    Revenue()
              )

            ],

          );

        },
      ),
    );
  }
}




class Pricing extends StatefulWidget {
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {


  final priceModel = Injector.get<PriceRevenue>();
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final Widget button = SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                priceModel.priceSubscriptions[priceModel.selectedSubscription],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            SizedBox(
                width: 17,
                height: 17,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ))),
          ],
        ),
      ),
    );



    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Text("Choose Subscription",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            Padding(padding: EdgeInsets.only(bottom: 10),),

            MenuButton(
              child: button,
              items: priceModel.priceSubscriptions,
              topDivider: true,
              itemBuilder: (value) => Container(
                  height: 45,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),

                  )),
              toggledChild: Container(
                color: Colors.white,
                child: button,
              ),
              divider: Container(
                height: 1,
                color: Colors.grey.withOpacity(0.2),
              ),
              onItemSelected: (value) async {

                    // await change
                  await priceModel.changeSubscription(priceModel.priceSubscriptions.indexOf(value));
              },
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: const BorderRadius.all(Radius.circular(22.5)),
                  color: Colors.white
              ),
            ),

            Padding(padding: EdgeInsets.only(bottom: 30),),


            Container(
              width: MediaQuery.of(context).size.width/1.1,
             // height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(

                        width: 4*MediaQuery.of(context).size.width/11.5,

                        decoration: BoxDecoration(
                          border: Border(right: BorderSide())
                        ),


                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Center(
                            child: Text("Service Type",),
                          ),
                        ),
                      ),
                      Container(

                        width: 3*MediaQuery.of(context).size.width/11.5,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide())
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Center(
                            child: Text("Service Type"),
                          ),
                        ),
                      ),
                      Container(

                        width: 3*MediaQuery.of(context).size.width/11.5,
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Center(
                            child: Text("Service Type"),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide())
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4*MediaQuery.of(context).size.width/11.5,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide())
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                          child: ListView.builder(
                              shrinkWrap:  true ,
                              itemCount: priceModel.serviceType.length,
                              itemBuilder: (context,index){
                              return Padding(

                                padding: const EdgeInsets.only(top: 10,bottom: 10),
                                child: Text(
                                  priceModel.serviceType[index],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14
                                  ) ,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                          }),
                        ),
                      ),
                      Container(

                        width: 3*MediaQuery.of(context).size.width/11.5,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide())
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                          child: ListView.builder(
                              shrinkWrap:  true ,
                              itemCount: priceModel.clientPrice.length,
                              itemBuilder: (context,index){
                                return Padding(

                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  child: Text(
                                    priceModel.clientPrice[index],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14
                                    ) ,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }),
                        ),
                      ),
                      Container(

                        width: 3*MediaQuery.of(context).size.width/11.5,
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                          child: ListView.builder(
                              shrinkWrap:  true ,
                              itemCount: priceModel.yourPayout.length,
                              itemBuilder: (context,index){
                                return Padding(

                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  child: Text(
                                    priceModel.yourPayout[index],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14
                                    ) ,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }),
                        ),
                      ),

                    ],
                  ),
                ],
              )
            ),

          ],
        ),
      ),
    );
  }
}



class Revenue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width/1.2,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Total",
                              style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                            ),
                            Text("Money Earned",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("25,000",
                            style: TextStyle(
                                color: Color.fromRGBO(108, 71, 145, 1),
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Divider(thickness: 1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Current Month",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            Text("Money Earned",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("205,000",
                              style: TextStyle(
                                  color: Color.fromRGBO(108, 71, 145, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width/1.2,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Total",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            Text("Clients Server",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("42",
                              style: TextStyle(
                                  color: Color.fromRGBO(108, 71, 145, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Divider(thickness: 1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Current Month",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            Text("Client Served",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("25",
                              style: TextStyle(
                                  color: Color.fromRGBO(108, 71, 145, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
