import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treatment_checkup_app/widgets/buttons.dart';

class ClientProfileForTrainers extends StatelessWidget {
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

              height: 100,
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
                            Text('Balfdssdfs',
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

                            Text("30 years old , Male",
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
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0 , top: 17.0, bottom: 17.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(26.0))
                      ),
                      child: Column(
                        children: <Widget>[
                          PersonDetailsContentForPartners(
                            heading: 'Activity',
                            mainbody: 'Yoga and Dance',
                          ),
                          PersonDetailsSessionContentForPartners(
                            heading1: "Number of Session",
                            mainbody1: "1/3 Completed",
                            heading2: "Number of People",
                            mainbody2: "Partner (2 People)",
                          ),
                          PersonDetailsContentForPartners(
                            heading: 'Preffered Workout Time',
                            mainbody: '10:00 am to 12:00 am',
                          ),
                          PersonDetailsContentForPartners(
                            heading: 'Diseases or injury',
                            mainbody: ' ullamco lakjiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiikkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
                          ),
                          PersonDetailsScheduledSessionsForPartners(),
                          ContactDetailsCustomer(
                            phoneNumber: '6283556112',
                            emailId:'contact@asdasdasd.in' ,
                          ),
                          PersonDetailsLocationForPartners()
                        ],

                      ),
                    ),
                  ),

                  Center(
                     child: SizedBox(
                       width: MediaQuery.of(context).size.width/1.8,
                       height: 40,
                       child: purpleButton("Cancel Session",function: (){}),
                     ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
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
      padding: EdgeInsets.only(right: 28.0, left: 28.0, top: 10.0, bottom: 23.0),
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
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black38,
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
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 28,right: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
              ],

            ),
          ),

          Divider(
            color: Colors.black38,
          ),

        ],
      ),
    );
  }
}


class PersonDetailsSessionContentForPartners extends StatelessWidget {
  PersonDetailsSessionContentForPartners({@required this.heading1, @required this.mainbody1,@required this.heading2, @required this.mainbody2});
  final String heading1;
  final String mainbody1;
  final String heading2;
  final String mainbody2;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 28,right: 28),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(heading1 ,
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontFamily: 'Roboto',
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(mainbody1,
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
                  ],

                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(heading2 ,
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontFamily: 'Roboto',
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(mainbody2,
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
                  ],

                ),
              ],
            ),
          ),

          Divider(
            color: Colors.black38,
          ),

        ],
      ),
    );
  }
}

class PersonDetailsScheduledSessionsForPartners extends StatelessWidget {
  PersonDetailsScheduledSessionsForPartners ();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 28,right: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Scheduled Sessions" ,
                  style: TextStyle(
                    color: Color(0xff7b7b7b),
                    fontFamily: 'Roboto',
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 10,),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff6c4791),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 7,bottom: 7),
                              child: Text("8:00 Am to 9:00 Am on Wed 18, Feb 2020",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],

            ),
          ),

          SizedBox(
            height: 10,
          ),

          Divider(
            color: Colors.black38,
          ),

        ],
      ),
    );
  }
}


class PersonDetailsLocationForPartners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 28,right: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Place Of Workout",
                  style: TextStyle(
                    color: Color(0xff7b7b7b),
                    fontFamily: 'Roboto',
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text("sfs df f df sdf sd fs dfw wefefwerwgwgwrgw gw gwg wrgwrg g wrgw gr ",
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
              ],

            ),
          ),


          MiniMapClientLocation("37.42796133580664 -122.085749655962","GeoLocation",""),

          Container(
            height: 10,
          ),

          Center(
            child: Text("(Tap on the marker for Navigation Options)",
              style: TextStyle(
                color: Color(0xff7b7b7b),
                fontFamily: 'Roboto',
                fontSize: 12.0,
              ),
            ),
          ),

          Container(
            height: 20,
          ),


        ],
      ),
    );
  }
}


class MiniMapClientLocation extends StatefulWidget {
  final String geoCoordinate,markerName,extraText;
  MiniMapClientLocation(this.geoCoordinate,this.markerName,this.extraText);
  @override
  State<MiniMapClientLocation> createState() => MiniMapClientLocationState();
}

class MiniMapClientLocationState extends State<MiniMapClientLocation> {

  Completer<GoogleMapController> _controller = Completer();

  double longitude,latitude;

  CameraPosition _initialPosition ;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  void _addMarker() {
    var markerIdVal = widget.markerName == null ? "Location" : widget.markerName;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(latitude,longitude),
      infoWindow: InfoWindow(title: markerIdVal, snippet: widget.extraText == null ? "" : widget.extraText),
      onTap: () {
        //_onMarkerTapped(markerId);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  Future<void> _goToThePosition(LatLng ll) async {
    final CameraPosition _kpos = CameraPosition(
        target: ll,
        zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kpos));
  }

  @override
  void didUpdateWidget(MiniMapClientLocation oldWidget) {
    if(oldWidget.geoCoordinate != widget.geoCoordinate){
      setState(() {
        markers.clear();
        locationUpdate();
        _goToThePosition(LatLng(latitude,longitude));
      });

    }
    super.didUpdateWidget(oldWidget);
  }


  void locationUpdate(){
    latitude = double.parse(widget.geoCoordinate.split(" ")[0]);
    longitude = double.parse(widget.geoCoordinate.split(" ")[1]);
    print(latitude);
    print(longitude);
    _addMarker();
  }

  @override
  void initState() {
    locationUpdate();
    if(latitude!= null && longitude!=null){
      _initialPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14.4746,
      );
    }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: new SizedBox(
        height: MediaQuery.of(context).size.height/3.5,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _initialPosition,

          markers: Set<Marker>.of(markers.values),
          gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
            ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer()))
          ,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}

