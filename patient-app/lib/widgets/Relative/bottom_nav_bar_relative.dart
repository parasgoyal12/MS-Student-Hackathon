import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';
import 'package:treatment_checkup_app/screens/Relative/friend_request_screen.dart';
import 'package:treatment_checkup_app/screens/Relative/relative_home.dart';
import 'package:treatment_checkup_app/screens/Requests_screen/patients_request_screen.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/account/AccountHome.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/patient_profile.dart';

class BottomNavBarR extends StatefulWidget {
  final List<bool> active_icon;
  const BottomNavBarR({
    Key key,
   this.active_icon,
  }) : super(key: key);

  @override
  _BottomNavBarRState createState() => _BottomNavBarRState();
}

class _BottomNavBarRState extends State<BottomNavBarR> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Patients",
            svgScr: "assets/icons/calendar.svg",
            isActive: widget.active_icon[0],
            press: () {
              if(!widget.active_icon[0])Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return FriendRequestScreenR();
                }),
              );

            },
          ),
          BottomNavItem(
            title: "All Requests",
            svgScr: "assets/icons/gym.svg",
            isActive: widget.active_icon[1],
            press: () {
              if(!widget.active_icon[1]) Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return RequestsScreenR();
                }),
              );

            },
          ),
          BottomNavItem(
            title: "Settings",
            isActive: widget.active_icon[2],
            svgScr: "assets/icons/Settings.svg",
            press: () {
              if(!widget.active_icon[2]) Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ProfilePageP();
                }),
              );

            },
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgScr,
            color: isActive ? kActiveIconColor : kTextColor,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}
