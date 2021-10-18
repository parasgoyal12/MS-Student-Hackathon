import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treatment_checkup_app/Localization/localization_constant.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/daily_layout.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:treatment_checkup_app/widgets/bottom_nav_bar.dart';
import 'package:treatment_checkup_app/widgets/request_card.dart';
import 'package:treatment_checkup_app/widgets/search_bar.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';
import 'package:treatment_checkup_app/models/requests.dart';




//TODO GET API DATA




//type denotes day or week 1 for day and 0 for week
//
// final List<Request> requests= [
//   Request(
//     Relative_name: 'Anshul',
//     status: 'No action',
//     date: 'yesterday',
//     image: 'Low',
//     url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
//
//   ),
//   Request(
//     Relative_name: 'Sanskar',
//     status: 'Accepted',
//     date: 'yesterday',
//     image: 'Low',
//     url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
//
//   ),
//   Request(
//     Relative_name: 'Anshul',
//     status: 'Accepted',
//     date: '7th march',
//     image: 'Low',
//     url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
//
//   ),
//   Request(
//     Relative_name: 'Sanskar',
//     status: 'Accepted',
//     date: '7th March',
//     image: 'Low',
//     url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
//
//   ),
//
// ];







class RequestsScreenP extends StatefulWidget {
  @override
  _RequestsScreenPState createState() => _RequestsScreenPState();
}

class _RequestsScreenPState extends State<RequestsScreenP> {
  UserTypeService userService;
  AsyncMemoizer _memoizer;
  var grp_list;
  Future<void> _getPatientExerciseRequests() async {
    return this._memoizer.runOnce(() async{

      List<PatientRequestModel> req_list = await userService.GetPatientExerciseRequests();
      grp_list=groupBy(req_list, (PatientRequestModel req) {
        return '${req.todayDay}';//+${req.relativeName}';
      }).values.toList();



     //  print(grp_list);//grp_list.sort((a, b) => (a[0].todayDay)<=((b[0].todayDay)));
      return grp_list;
    });
  }
  @override
  void initState() {
    super.initState();
    userService = UserTypeService();
    _memoizer= AsyncMemoizer();
    // _getRelativeExerciseRequests().catchError((e){
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(active_icon: [true,false,false],),
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
                      getTranslated(context, "requests"),
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
                      child:FutureBuilder(future: _getPatientExerciseRequests(),
                          builder: (context, projectSnap) {
                            if (projectSnap.connectionState == ConnectionState.none &&
                                projectSnap.hasData == null) {
                              //print('project snapshot data is: ${projectSnap.data}');
                              return Container();
                            }
                            // ignore: missing_return
                            if(projectSnap.hasData){     return
                              GridView.builder(
                                  itemCount: projectSnap.data.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,mainAxisSpacing: 10.0,childAspectRatio:4.1,

                                  ),
                                  // Generate 100 widgets that display their index in the List.
                                  itemBuilder: (ctx, index) {
                                    return RekuestCard(request: projectSnap.data[index],press: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) {
                                      //     return RequestsScreenP();
                                      //   }),
                                      // );

                                    }, );
                                  });}
                            return Container(
                                color: Colors.black.withOpacity(0.1),
                                height: MediaQuery.of(context).size.height*0.8,
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: CircularProgressIndicator(),));

                          })

                      // child: GridView.builder(
                      //   itemCount: requests.length,
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 1,mainAxisSpacing: 10.0,childAspectRatio:4
                      //  ),
                      //   // Generate 100 widgets that display their index in the List.
                      //   itemBuilder: (ctx, index) {
                      //     return RekuestCard(request: requests[index],press: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) {
                      //           return RequestsScreenP();
                      //         }),
                      //       );
                      //
                      //     }, );
                      //   }),
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

