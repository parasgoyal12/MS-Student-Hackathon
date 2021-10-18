import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/helping_Screens/notification_personalTrainer.dart';
import 'package:treatment_checkup_app/helping_Screens/scan_QR.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/eachCoustomerList%5BTemp%5D.dart';
import 'package:treatment_checkup_app/services/personalTrainer/clientHome.dart';




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
    return  Padding(
      padding: EdgeInsets.only( left: 9.0, right: 15.0, bottom:7.5, top: 7.5),
      child: Container(

        height: 100.0,
        width: 330.0,
        child:Card(
          elevation: 6.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

          child: FlatButton(
            onPressed: (){

              Navigator.of(context).push(new MaterialPageRoute(builder: (context) => CustomerProfileForTrainers()));
              //Navigate to user's profile
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  Image.network(widget.imageaddress,
                      width: 67.0,
                      height: 85.0),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: Text(widget.monthsOfMembership,
                      style: TextStyle(fontSize: 10.0,
                          color: Color(0xff6c4791)
                      ),
                    ),
                    height: 22.0,
                    width: 65.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all( Radius.circular(13.6)),
                        border: Border.all(color: Color(0xff6c4791))
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

class ClickableTitleWithModel extends StatefulWidget {
  final String _categoriesofmonths;
  final int index;
  final classModel;
  ClickableTitleWithModel(this._categoriesofmonths,this.index,this.classModel);
  @override
  _ClickableTitleWithModelState createState() => _ClickableTitleWithModelState();
}

class _ClickableTitleWithModelState extends State<ClickableTitleWithModel> {

  var clientModel;

  bool isselected = false;

  bool stateofothermember = false;


  @override
  void initState() {
    clientModel =  widget.classModel;
    if(clientModel.activeFilter == widget.index){
      isselected = true;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ClickableTitleWithModel oldWidget) {
    if(clientModel.activeFilter == widget.index){
      isselected = true;
    }
    else{
      isselected = false;
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
          clientModel.changeActiveFilter(widget.index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget._categoriesofmonths,
            style: TextStyle(
              color: isselected ? Colors.white : Color(0xffac97c1),
              fontSize: isselected ? 15.0 : 13.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7),
          ),
          Container(
            height: 4,
            width: 20,
            
            decoration: BoxDecoration(
              color: isselected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          )
        ],
      ),

    );
  }
}
