import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomerProfileForTrainers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6c4791),
        elevation: 0,

      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xfff4f5f9),
            child: Container(

              height: 246.0-92,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)
                ),
                color: Color(0xff6c4791),

              ),
              child:  Padding(
                padding: EdgeInsets.only(top: 0, bottom: 17.0, left: 14.0, right: 14.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.network('https://picsum.photos/250?image=9',
                          height: 55.0,
                          width: 47.0,),
                        SizedBox(
                          width: 20.0,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Name',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),

                            Text('Location',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,

                              ),
                            ),
                          ],
                        ),





                      ],

                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 66.0,
                        decoration: BoxDecoration(
                          color: Color(0xff7d55a4),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ParametersTopRounded(
                              parameter: 'Age',
                              parametervalue: '27',
                            ),
                            ParametersTopRounded(
                              parameter: 'Height',
                              parametervalue: '171',
                            ),ParametersTopRounded(
                              parameter: 'Weight',
                              parametervalue: '55',
                            ),

                          ],
                        ),




                      ),

                    ),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xfff4f5f9),

                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0 , top: 17.0, bottom: 17.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(26.0))
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          PersonDetailsContentForPartners(
                            heading: 'Activity',
                            mainbody: 'Yoga and Dance',
                          ),
                          PersonDetailsContentForPartners(
                            heading: 'Preffered Workout Time',
                            mainbody: '10:00 am to 12:00 am',
                          ),
                          PersonDetailsContentForPartners(
                            heading: 'Diseases or injury',
                            mainbody: ' ullamco lakjiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiikkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
                          ),

                          ContactDetailsCustomer(
                            phoneNumber: '6283556112',
                            emailId:'contact@asdasd.in' ,
                          )



                        ],

                      ),
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),

    );
  }
}

class ParametersTopRounded extends StatelessWidget {
  ParametersTopRounded({this.parametervalue, this.parameter});

  final String parametervalue;
  final String parameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 14.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text( parametervalue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text( parameter,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactDetailsCustomer extends StatelessWidget {
  ContactDetailsCustomer({@required this.phoneNumber, @required this.emailId});
  final String phoneNumber;
  final String emailId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 28.0, left: 28.0, top: 23.0, bottom: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Contact Details',
            style: TextStyle(
              color: Color(0xff7b7b7b),
              fontFamily: 'Roboto',
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 9.5,
                backgroundColor:  Color(0xff6c4791),
                child: Icon(Icons.call,
                  color: Colors.white,
                  size: 12.0,
                ),

              ),
              SizedBox(width: 11.0,),
              Text(phoneNumber,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(width: 19.0,),
              CircleAvatar(
                radius: 9.5,
                backgroundColor:  Color(0xff6c4791),
                child: Icon(Icons.email,
                  color: Colors.white,
                  size: 12.0,
                ),
              ),
              SizedBox(width: 11.0,),
              Text(emailId,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto',
                ),
              ),


            ],
          ),
        ],
      ),
    );
  }
}

class PersonDetailsContentForPartners extends StatelessWidget {
  PersonDetailsContentForPartners({@required this.heading, @required this.mainbody});
  final String heading;
  final String mainbody;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 28.0, left: 28.0, top: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(heading ,
            style: TextStyle(
              color: Color(0xff7b7b7b),
              fontFamily: 'Roboto',
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(mainbody,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Roboto',
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Divider(
            color: Color(0xff7b7b7b) ,
          ),

        ],
      ),
    );
  }
}


