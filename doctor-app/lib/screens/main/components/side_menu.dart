import 'package:exercise_tracker_doctor/constants.dart';
import 'package:flutter/material.dart';
import 'package:exercise_tracker_doctor/constants.dart';
import 'package:exercise_tracker_doctor/screens/profile/profile.dart';
import 'package:exercise_tracker_doctor/services/authServices/FirebaseUser.dart';

class SideMenu extends StatelessWidget {

  final Function(int) notifyParent;
  final Function refreshPage;
  final filterActive;
  final first_name, last_name, designation, department, hospital;

  const SideMenu({
    Key key, @required this.notifyParent, this.filterActive, @required this.refreshPage,
    @required this.designation, @required this.department, @required this.hospital,
    @required this.first_name, @required this.last_name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('${this.first_name} ${this.last_name}'),
              accountEmail: Text('${this.designation}'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/Images/doctor.jpg'),
              ),

            ),

            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DashboardThreePage(),
                  ),
                );
              },
            ),

            ListTile(
              title: Text('Refresh Page'),
              leading: Icon(Icons.refresh),
              onTap: () {
                refreshPage();
                Navigator.of(context).pop();
              },
            ),

            Divider(),

            ListTile(
              title: Text('Patient Filters',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                )
              ),
              leading: Icon(Icons.filter_alt_outlined),
            ),

            Container(
              color: filterActive==1 ? kBgDarkColor : null,
              child: ListTile(
                  title: Text('All Patients'),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.of(context).pop();
                    notifyParent(1);
                  }
              ),
            ),

            Container (
              color: filterActive==2 ? kBgDarkColor : null,
              child: ListTile(
                  title: Text('On Schedule'),
                  leading: Icon(Icons.schedule),
                  onTap: () {
                    Navigator.of(context).pop();
                    notifyParent(2);
                  }
              ),
            ),

            Container(
              color: filterActive==3 ? kBgDarkColor : null,
              child: ListTile(
                  title: Text('Off Schedule'),
                  leading: Icon(Icons.assignment_late),
                  onTap: () {
                    Navigator.of(context).pop();
                    notifyParent(3);
                  }
              )
            ),

            Container(
              color: filterActive==4 ? kBgDarkColor : null,
              child: ListTile(
                  title: Text('Critical Status'),
                  leading: Icon(Icons.clear),
                  onTap: () {
                    Navigator.of(context).pop();
                    notifyParent(4);
                  }
              ),
            ),

            Container(
              color: filterActive==5 ? kBgDarkColor : null,
              child: ListTile(
                  title: Text('Treatment Completed'),
                  leading: Icon(Icons.done_all),
                  onTap: () {
                    Navigator.of(context).pop();
                    notifyParent(5);
                  }
              ),
            ),

            Container(
              color: filterActive==6 ? kBgDarkColor : null,
              child: ListTile(
                  title: Text('Bookmarked Patients'),
                  leading: Icon(Icons.bookmark),
                  onTap: () {
                    Navigator.of(context).pop();
                    notifyParent(6);
                  }
              ),
            ),




            Divider(),


            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () async {
                await FirebaseSignInService().signOut(context);
              },
            ),


            ListTile(
                title: Text('Close'),
                leading: Icon(Icons.close),
                onTap: (){
                  Navigator.of(context).pop();}
            ),
          ]
      ),
    );
  }
  
}