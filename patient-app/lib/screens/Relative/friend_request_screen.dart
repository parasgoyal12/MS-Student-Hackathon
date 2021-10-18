import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treatment_checkup_app/constants.dart';

import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:treatment_checkup_app/widgets/Relative/friend_request_card.dart';

import 'package:treatment_checkup_app/widgets/Relative/bottom_nav_bar_relative.dart';










//type denotes day or week 1 for day and 0 for week







class FriendRequestScreenR extends StatefulWidget {


  @override
  _FriendRequestScreenRState createState() => _FriendRequestScreenRState();
}

class _FriendRequestScreenRState extends State<FriendRequestScreenR> {

  bool isLoading;
  UserTypeService userService;
  AsyncMemoizer _memoizer;
  // ignore: non_constant_identifier_names
  String my_number;
  List<FRequestModel> req_list;
  Future<void> _getFriendRequests() async {
    return this._memoizer.runOnce(() async{
    setState(() {
      isLoading = true;
    });
    FriendRequest response = await userService.GetFriendRequests();

    req_list = response.Req_list;
    my_number = response.my_number;

    setState(() {
      isLoading = false;
    });
    return req_list;
  });
  }



  @override
  void initState() {
    super.initState();
    isLoading = false;
    userService = UserTypeService();
    _memoizer= AsyncMemoizer();


   // _future= _getFriendRequests().catchError((e){
   //    setState(() {
   //      isLoading = false;
   //    });
   //  });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBarR(active_icon: [true,false,false],),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .18,
            decoration: BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Friend Requests",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    SizedBox(
                      height: size.height*0.75,

                      child: isLoading == true? Container(
                          color: Colors.black.withOpacity(0.5),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: CircularProgressIndicator(),)):
                      FutureBuilder(future: _getFriendRequests(),
    builder: (context, projectSnap) {
    if (projectSnap.connectionState == ConnectionState.none &&
    projectSnap.hasData == null) {
    //print('project snapshot data is: ${projectSnap.data}');
    return Container();
    }
    if(projectSnap.hasData){
    return  GridView.builder(
                            itemCount: projectSnap.data.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,mainAxisSpacing: 10.0,childAspectRatio:4
                            ),
                            // Generate 100 widgets that display their index in the List.
                            itemBuilder: (ctx, index) {
                              FRequestModel project = projectSnap.data[index];
                              return FriendRequestCardRelative(request: project,number:my_number,press: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) {
                                //     return FriendRequestScreenR();
                                //   }),
                                // );

                              }, );
                            }
                            );}
    return Container(
        color: Colors.black.withOpacity(0.1),
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
        child: Center(child: CircularProgressIndicator(),));
                      }
                      )
                    ),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

