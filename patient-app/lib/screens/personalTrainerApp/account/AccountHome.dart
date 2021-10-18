import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/account/editAccount.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/clientsHome/clientsFullDetails.dart';
import 'package:treatment_checkup_app/services/auth/FirebaseUser.dart';
import 'package:treatment_checkup_app/services/personalTrainer/profile.dart';
import 'package:treatment_checkup_app/widgets/IconImages.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;


class AccountHome extends StatefulWidget {
  @override
  _AccountHomeState createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {

  Future<TrainerProfile>  tps;
  @override
  void initState() {


    if(TrainerProfileService().resetData == true){
      TrainerProfileService().trainerProfile = null;
      TrainerProfileService().resetData = false;
    }

    tps = TrainerProfileService().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(108, 71, 145, 1),
        title: Text("Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.edit),
            onTap: () async {
              if(TrainerProfileService().trainerProfile!=null) {
                var temp = TrainerProfileService().trainerProfile.toJson();
                TrainerProfile t = TrainerProfile.fromJson(temp);
                var res = await Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> EditAccountInjector(t) ));
                if(res == true){
                  setState(() {
                    tps = TrainerProfileService().getProfile();
                  });
                }
              }
            },

          ),
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
            child: RaisedButton(
              onPressed: () async {
                await FirebaseSignInService().signOut(context);
              },
              elevation: 5,
              color: Color.fromRGBO(108, 71, 145, 1),
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),

          ),
              child: Text("LOGOUT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: FutureBuilder<TrainerProfile>(
                    future: tps,
                    builder: (context, snapshot){
                      if(snapshot.connectionState ==
                          ConnectionState.done){
                        if(snapshot.hasData){
                          return Stack(
                            children: <Widget>[
                              TrainerProfileService().profileImages.length ==0? Container(
                                child: Center(
                                  heightFactor: 10,
                                  child: Text("NO Image Set")
                                ),

                              )

                                  :

                              SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Swiper(
                                  autoplay: true,
                                  autoplayDelay: 3000,
                                  autoplayDisableOnInteraction: true,
                                  //containerHeight: MediaQuery.of(context).size.height/5,
                                  // itemHeight: MediaQuery.of(context).size.height/5,
                                  outer:false,
                                  itemCount: TrainerProfileService().profileImages.length,
                                  itemBuilder: (c, i) {
                                    return new Container(
                                      child: CachedNetworkImage(
                                        imageUrl: TrainerProfileService().profileImages[i],
                                        fit: BoxFit.fitHeight,
                                        placeholder: (context, uri) => Center(child: CircularProgressIndicator(),),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                      //color: [Colors.orange,Colors.blueAccent][i%2],
                                    );
                                  },
                                  pagination: new SwiperPagination(
                                    alignment: Alignment(0, 0.3),
                                    margin: new EdgeInsets.all(5.0),
                                    builder: const DotSwiperPaginationBuilder(activeColor: Colors.white,color: Color.fromRGBO(75, 31, 44, 0.3),
                                        size: 9, activeSize: 9, space: 4.0),
                                  ),

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 130),
                                child: ExpandableTheme(
                                  data:
                                  const ExpandableThemeData(iconColor: Colors.blue, useInkWell: true),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[

                                      PersonalInfoViewCard(snapshot.data),
                                      EducationCertification(snapshot.data),
                                      TrainingLocationItem(snapshot.data),
                                      BioTrainerItem(snapshot.data),
                                      SizedBox(height: 35,),
                                      DigitalAgreementItem(),
                                      DigitalAgreementItem(),
                                      DigitalAgreementItem(),
                                      SizedBox(height: 35,),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        else if(snapshot.hasError){
                          return InkWell(
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Text(
                                        "ERROR OCCURRED, Tap to retry !"),
                                  ),
                                ),
                              ),
                              onTap: () => setState(() {
                                tps = TrainerProfileService().getProfile();
                              }));
                        }

                      }
                      return SpinKitWave(
                        color: Color.fromRGBO(198, 240, 231, 1),
                        size: 50,
                      );
                    }
                ),
              ),
            ),
          );
        },
      )
    );
  }
}




class PersonalInfoViewCard extends StatefulWidget {
  final TrainerProfile tps;
  PersonalInfoViewCard(this.tps);
  @override
  _PersonalInfoViewCardState createState() => _PersonalInfoViewCardState();
}

class _PersonalInfoViewCardState extends State<PersonalInfoViewCard> {


  Widget buildPersonalItems(){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(height: 30,),
          Text("Name",
          style: TextStyle(
            color: Color.fromRGBO(123, 123, 123, 1),
            fontSize: 13
          ),
          ),
          SizedBox(height: 4,),
          Text(widget.tps.name,
          style: TextStyle(

              fontSize: 12
          ),),
          Divider(height: 30,),


          Text("Date of Birth",
            style: TextStyle(
                color: Color.fromRGBO(123, 123, 123, 1),
                fontSize: 13
            ),
          ),
          SizedBox(height: 4,),
          Text(widget.tps.dOB.length==0 ? "NO Date":widget.tps.dOB,
            style: TextStyle(

                fontSize: 12
            ),),
          Divider(height: 30,),



          Text("Gender",
            style: TextStyle(
                color: Color.fromRGBO(123, 123, 123, 1),
                fontSize: 13
            ),
          ),
          SizedBox(height: 4,),
          Text(widget.tps.dOB.length==0 ? "NO Gender Set":widget.tps.gender,
            style: TextStyle(

                fontSize: 12
            ),),
          Divider(height: 30,),



          Text("Contact Details",
            style: TextStyle(
                color: Color.fromRGBO(123, 123, 123, 1),
                fontSize: 13
            ),
          ),
          SizedBox(height: 4,),
          Row(
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.phone),
                  SizedBox(width: 10,),
                  Text(widget.tps.phone.length ==0 ? "NO Phone Set":widget.tps.phone,
                    style: TextStyle(
                        fontSize: 10
                    ),),
                ],
              ),
              SizedBox(width: 15,),
              Row(
                children: <Widget>[
                  Icon(Icons.email),
                  SizedBox(width: 10,),
                  Text(widget.tps.email.length ==0 ? "NO Email Set":widget.tps.email,
                    style: TextStyle(
                        fontSize: 10
                    ),),
                ],
              ),
            ],
          ),
          Divider(height: 30,),

          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Identity Proof",
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.insert_drive_file),
                ],
              ),
              SizedBox(width: 15,),
              Row(
                children: <Widget>[
                  Text("Address Proof",
                    style: TextStyle(
                        fontSize: 10
                    ),),
                  SizedBox(width: 10,),
                  Icon(Icons.file_download),
                ],
              ),
            ],
          ),

          SizedBox(height: 20,),

        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: ScrollOnExpand(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: false,
                      hasIcon: false,
                    ),
                    header: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,

                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                        child: Row(
                          children: [

                            Expanded(
                              child: Text(
                                "Personal Info",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(108, 71, 145, 1),
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ),
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Color.fromRGBO(108, 71, 145, 1),
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    expanded: buildPersonalItems(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}






class EducationCertification extends StatefulWidget {
  final TrainerProfile tps;
  EducationCertification(this.tps);
  @override
  _EducationCertificationState createState() => _EducationCertificationState();
}

class _EducationCertificationState extends State<EducationCertification> {
  Widget buildEduCerItems(){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text("Education Background",
            style: TextStyle(
                color: Color.fromRGBO(123, 123, 123, 1),
                fontSize: 13
            ),
          ),
          SizedBox(height: 4,),
          Text(widget.tps.education.length == 0 ? "NO Date" : widget.tps.education,
            style: TextStyle(

                fontSize: 12
            ),),
          Divider(height: 30,),


          Text("Certifications",
            style: TextStyle(
                color: Color.fromRGBO(123, 123, 123, 1),
                fontSize: 13
            ),
          ),
          SizedBox(height: 4,),
          Text(widget.tps.certifications.length == 0 ? "NO Date" : widget.tps.certifications,
            style: TextStyle(

                fontSize: 12
            ),),
          Divider(height: 30,),
          SizedBox(height: 4,),

          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Masters",
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.insert_drive_file),
                ],
              ),
              SizedBox(width: 15,),
              Row(
                children: <Widget>[
                  Text("CPR/AED/FA",
                    style: TextStyle(
                        fontSize: 10
                    ),),
                  SizedBox(width: 10,),
                  Icon(Icons.file_download),
                ],
              ),
            ],
          ),

          SizedBox(height: 20,),

        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
//      initialExpanded: true,  ##TODO initial expand
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: ScrollOnExpand(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: false,
                      hasIcon: false,
                    ),
                    header: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,

                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                        child: Row(
                          children: [

                            Expanded(
                              child: Text(
                                  "Education and Certification",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(108, 71, 145, 1),
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                            ),
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Color.fromRGBO(108, 71, 145, 1),
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    expanded: buildEduCerItems(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}







class TrainingLocationItem extends StatefulWidget {
  final TrainerProfile tps;
  TrainingLocationItem(this.tps);
  @override
  _TrainingLocationItemState createState() => _TrainingLocationItemState();
}

class _TrainingLocationItemState extends State<TrainingLocationItem> {

  double longitude,latitude;

  Widget buildTrainingLocationItems(){
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Text(widget.tps.trainingLocation.length == 0 ? "NO Location Address" : widget.tps.trainingLocation,
              style: TextStyle(
                  color: Color.fromRGBO(123, 123, 123, 1),
                  fontSize: 13
              ),
            ),
          ),
          SizedBox(height: 15,),

          (longitude!=null && latitude != null) ?
            MiniMapClientLocation(widget.tps.trainingLocationGeo,"Training Location",""):
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Text("NO Location Geo Coordinates",
                style: TextStyle(
                color: Color.fromRGBO(123, 123, 123, 1),
                fontSize: 13
                ),
              ),
            ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
  @override
  void initState() {
    if(widget.tps.trainingLocationGeo.split(" ").length >= 2){
      latitude = double.parse(widget.tps.trainingLocationGeo.split(" ")[0]);
      longitude = double.parse(widget.tps.trainingLocationGeo.split(" ")[1]);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
//      initialExpanded: true,  ##TODO initial expand
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: ScrollOnExpand(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: false,
                      hasIcon: false,
                    ),
                    header: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,

                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                        child: Row(
                          children: [

                            Expanded(
                              child: Text(
                                  "Training Location",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(108, 71, 145, 1),
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                            ),
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Color.fromRGBO(108, 71, 145, 1),
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    expanded: buildTrainingLocationItems(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}


class BioTrainerItem extends StatefulWidget {
  final TrainerProfile tps;
  BioTrainerItem(this.tps);
  @override
  _BioTrainerItemState createState() => _BioTrainerItemState();
}

class _BioTrainerItemState extends State<BioTrainerItem> {




  buildIconForSocial(String social){
    switch(social.toLowerCase()){
      case "facebook" :{
        return Icons.face;
      }
      break;
      case "instagram" :{
        return Icons.fast_forward;
      }
      break;
      case "youtube" :{
        return Icons.fastfood;
      }
      break;
      case "twitter" :{
        return Icons.format_align_center;
      }
      break;
      default :{
        return Icons.error;
      }
      break;

    }
  }

  List<Widget> buildSocialRow(){
    List<Widget> socialWidget = [];
    for(var elem in TrainerProfileService().socialMedia){
      print(elem);
      List<String> mediaLink = elem.split(":");
      if(mediaLink.length==2) {
        if(mediaLink[1].length>10){
          socialWidget.add(InkWell(
            child: CircleAvatar(
              child: Icon(buildIconForSocial(mediaLink[0])),
              radius: 15,
            ),
            onTap: (){
              //TODO
              //open mediaLink[1];
              print(mediaLink[1]);
            },
          ));
        }
      }
    }
    return socialWidget;
  }




  Widget buildBioTrainerItems(){
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Text(widget.tps.bio.length == 0 ? "NO Bio" : widget.tps.bio,
              style: TextStyle(
                  color: Color.fromRGBO(123, 123, 123, 1),
                  fontSize: 13
              ),
            ),
          ),
          SizedBox(height: 15,),

          (TrainerProfileService().socialMedia.length > 0 || buildSocialRow().length == 0) ?
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildSocialRow(),
          ):
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Text("No Social Media Links",
              style: TextStyle(
                  color: Color.fromRGBO(123, 123, 123, 1),
                  fontSize: 13
              ),
            ),
          ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
//      initialExpanded: true,  ##TODO initial expand
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: ScrollOnExpand(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: false,
                      hasIcon: false,
                    ),
                    header: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,

                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                        child: Row(
                          children: [

                            Expanded(
                              child: Text(
                                  "Bio",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(108, 71, 145, 1),
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                            ),
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Color.fromRGBO(108, 71, 145, 1),
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    expanded: buildBioTrainerItems(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class DigitalAgreementItem extends StatefulWidget {
  @override
  _DigitalAgreementItemState createState() => _DigitalAgreementItemState();
}

class _DigitalAgreementItemState extends State<DigitalAgreementItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        slideDialog.showSlideDialog(
          barrierColor: Colors.black.withOpacity(0.1),
          pillColor: Colors.transparent,

          context: context,
          child: Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30,right: 20,top: 0,bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            "Digital Agreement",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(108, 71, 145, 1),
                                fontWeight: FontWeight.w500
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.exit_to_app,
                        ),
                      )
                    ],
                  )
                ),
                Divider(),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[
                            Text(
                                "helfa adjsdjaksdjkasd asjd asjdaj sda sd ajsddasd\n\n\n\n\n\nsfsf"
                                "sfg\n\n\n\n\nsfssfg\n\n\n\nsf\n\n\n"
                                "adads\n\n\n\n\ndasdasdasd\n\n\n\nn\n"
                            "nadasdasd",
                            textAlign: TextAlign.left,
                            ),
                          ],
                        )
                    )
                ),

              ],
            ),
          )
        );
      },

      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
          side: BorderSide(
            color: Colors.black12
          )
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 20,top: 10,bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        "Digital Agreement",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        )
                    ),
                  ),
                  Icon(Icons.arrow_left)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Text(label),
      );
    }

    buildList() {
      return Column(
        children: <Widget>[
          for (var i in [1, 2, 3, 4]) buildItem("Item ${i}"),
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ScrollOnExpand(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: false,
                      hasIcon: false,
                    ),
                    header: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        // borderRadius: BorderRadius.all(Radius.circular(30))
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Colors.white,
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Items",
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    expanded: buildList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
