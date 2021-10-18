import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationFC extends StatefulWidget {
  @override
  _NotificationFCState createState() => _NotificationFCState();
}

class _NotificationFCState extends State<NotificationFC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6c4791),
        title: Text(
          'NOTIFICATIONS',
          textAlign: TextAlign.center,

        ),
      ),
      body: Container(
        color: Color(0xfff4f5f9),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Notifications(notificationtext: ' Session with SOhail at 5 tomorrow',
              imagesource: 'https://picsum.photos/250?image=9',),
            Notifications(notificationtext: ' New User Registered',
              imagesource: 'https://picsum.photos/250?image=9',),
            Notifications(notificationtext: ' New User Registered',
              imagesource: 'https://picsum.photos/250?image=9',),
            Notifications(notificationtext: ' New User Registered',
              imagesource: 'https://picsum.photos/250?image=9',),
            Notifications(notificationtext: ' New User Registered',
              imagesource: 'https://picsum.photos/250?image=9',),
            Notifications(notificationtext: ' New User Registered',
              imagesource: 'https://picsum.photos/250?image=9',),
            Notifications(notificationtext: ' New User Registered',
              imagesource: 'https://picsum.photos/250?image=9',),
          ],
        ),
      ),
//      body: Column(
//        children: <Widget>[
//          SafeArea(
//            child: Container(
//        padding: EdgeInsets.only(
//        top: 19.0,
//        left: 16.0,),
//              height: 87.0,
//              color: Color(0xff6c4791),
//              child: Row(
//                children: <Widget>[
//                  Text(
//                    'Notifications',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 14.0,
//                      fontWeight: FontWeight.w600
//                    ),
//                  ),
//                  IconButton(
//                    alignment: Alignment.centerLeft,
//                    onPressed: (){
//                      Navigator.pop(context);
//                    },
//                    icon: Icon(Icons.arrow_back,
//                    size: 14.0,
//                    color: Colors.white,
//                    ),
//
//
//                  ),
//                ],
//              ),
//
//            ),
//          ),
//          Container(
//            color: Color(0xfff4f5f9),
//            child: ListView(
//              scrollDirection: Axis.vertical,
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.symmetric(vertical: 10.0,
//                    horizontal: 13.0,
//                  ) ,
//                  child: Card(
//                    child: Text(' Sohan Joined 3 days program'),
//                  ),
//                ),
//                Divider(),
//
//
//              ],
//            ),
//          )
//        ],
//


    );
  }
}

class Notifications extends StatelessWidget {
  Notifications({ @required this.notificationtext, @required this.imagesource});
  final String notificationtext ;
  final String imagesource;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),

        ),
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5.0 ),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35.0,
                child: Image.network(imagesource),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(notificationtext
              ),



            ],
          ),
        ),

      ),
    );
  }
}

