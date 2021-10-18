import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/helping_Screens/notification_personalTrainer.dart';
import 'package:treatment_checkup_app/helping_Screens/scan_QR.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/clientsHome/clientsFullDetails.dart';
import 'package:treatment_checkup_app/services/personalTrainer/clientHome.dart';
import 'package:treatment_checkup_app/widgets/clickableTabBarButton.dart';




class ClientsPersonalTrainer extends StatefulWidget {
  @override
  _ClientsPersonalTrainerState createState() => _ClientsPersonalTrainerState();
}

class _ClientsPersonalTrainerState extends State<ClientsPersonalTrainer> {


  final clientModel = Injector.get<ClientsHome>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff6c4791),
        onPressed: (){},
        child: Icon(Icons.filter_list,
          color: Colors.white,),
      ),


      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff6c4791),
        title: Text( 'Clients',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          ScanQR(),
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
        ],
      ),

      body: StateBuilder(
        models: [clientModel],
        builder: (context,_){

          return  Column(
            children: <Widget>[

              Container(
                height: 75.0,
                decoration: BoxDecoration(
                  color: Color(0xff6c4791),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),

                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: clientModel.dayFilters.length,
                  itemBuilder: (context,ind){
                    return ClickableTitleWithModel(clientModel.dayFilters[ind],ind,clientModel);
                  },
                ),
              ),

              Expanded(

                child: Container(
                    color: Color(0xfff4f5f9),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        PersonalTrainerCustomer(
                          customerName: 'Sheldon Cooper',
                          activities: 'Walking Stairs',
                          monthsOfMembership: '3 months',
                          imageaddress: 'https://picsum.photos/250?image=9',
                        ),
                        PersonalTrainerCustomer(
                          customerName: 'Rajesh Koothrapali',
                          activities: 'Anything',
                          monthsOfMembership: 'COMPLETED',
                          imageaddress: 'https://picsum.photos/250?image=9',
                        ),
                        PersonalTrainerCustomer(
                          customerName: 'Lenord Hofstader',
                          activities: 'Walking Stairs',
                          monthsOfMembership: '6 months',
                          imageaddress: 'https://picsum.photos/250?image=9',
                        ),
                        PersonalTrainerCustomer(
                          customerName: 'Howard',
                          activities: 'Doing nothing',
                          monthsOfMembership: '1 months',
                          imageaddress: 'https://picsum.photos/250?image=9',
                        ),
                        PersonalTrainerCustomer(
                          customerName: 'Amy',
                          activities: 'Doing nothing',
                          monthsOfMembership: '1 months',
                          imageaddress: 'https://picsum.photos/250?image=9',
                        ),
                        PersonalTrainerCustomer(
                          customerName: 'Penny',
                          activities: 'Doing nothing',
                          monthsOfMembership: '1 months',
                          imageaddress: 'https://picsum.photos/250?image=9',
                        ),


                      ],
                    )
                ),
              )

            ],

          );

        },
      ),

    );
  }
}

class PersonalTrainerCustomer extends StatefulWidget {
  PersonalTrainerCustomer( { @required this.customerName, @required this.activities, @required this.imageaddress, @required this.monthsOfMembership});

  final String customerName;
  final String activities;
  final String imageaddress;
  final String monthsOfMembership;

  @override
  _PersonalTrainerCustomerState createState() => _PersonalTrainerCustomerState();
}

class _PersonalTrainerCustomerState extends State<PersonalTrainerCustomer> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(

      height: 100.0,
      width: MediaQuery.of(context).size.width,
      child:Padding(
        padding: EdgeInsets.only( left: 9.0, right: 15.0, bottom:7.5, top: 7.5),
        child: Card(
          margin: EdgeInsets.only(left: 0,right: 0),
          elevation: 6.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

          child: FlatButton(
            onPressed: (){

              Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ClientProfileForTrainers()));
              //Navigate to user's profile
            },
            child: Padding(
              padding: EdgeInsets.only(left: 5,top: 10,bottom: 10),
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.network(widget.imageaddress,
                          width: 67.0,
                          height: 85.0),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text( widget.customerName,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(widget.activities,
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      color: Color(0xff747474)
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.calendar_today,size: 15,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text( "Wed - 18 Feb 2020",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.access_time,size: 15,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text( "10:00 - 10:30",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment(1,-0.8),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("1/3 Completed",
                        style: TextStyle(fontSize: 8.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                        ),
                      ),
                      height: 18.0,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xff6c4791),
                          borderRadius: BorderRadius.all( Radius.circular(13.6)),
                          border: Border.all(color: Color(0xff6c4791))
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

