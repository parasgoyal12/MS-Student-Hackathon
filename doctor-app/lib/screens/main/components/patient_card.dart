import 'package:exercise_tracker_doctor/constants.dart';
import 'package:flutter/material.dart';
import 'package:exercise_tracker_doctor/models/Patient.dart';
import 'package:badges/badges.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PatientCard extends StatelessWidget {

  const PatientCard({
    Key key,
    this.patient,
    this.handleTap,
    this.handleLongPress,
    this.handleCriticalityChange,
  });

  final Patient patient;
  final VoidCallback handleTap;
  final VoidCallback handleLongPress;
  final VoidCallback handleCriticalityChange;

  void showAlertDialog(BuildContext context, bool isMarked) {
    Widget NoButton = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget YesButton = FlatButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        handleLongPress();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: isMarked ? Text("Unpin this patient?") :
        Text("Pin this patient?"),
      actions: [
        NoButton,
        YesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _defaultPic = "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: InkWell(
        onTap: handleTap,
        onLongPress: (){
          showAlertDialog(context, patient.isMarked);
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: kBgLightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                        children: [
                          SizedBox(
                              width: 40,
                              child: Badge(
                                badgeColor: patient.isDoingExerciseOnTime?
                                Colors.green:
                                Colors.red,
                                position: BadgePosition.topEnd(),
                                shape: BadgeShape.circle,
                                borderRadius: BorderRadius.circular(100),
                                badgeContent: Container(
                                  height: 3,
                                  width: 3,
                                  decoration:
                                  BoxDecoration(shape: BoxShape.circle, color: patient.isDoingExerciseOnTime?
                                  Colors.green:
                                  Colors.red),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  // TODO: Add Image From API
                                  child: CachedNetworkImage(
                                    imageUrl: patient.image.length > 10 ? patient.image : _defaultPic,
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 140,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )
                                  // backgroundImage: AssetImage((patient.image !=null && patient.image!= "") ? patient.image : "assets/Images/person8.png"),
                                ),
                              )
                          ),
                          SizedBox(width: kDefaultPadding),
                          Expanded(
                              child: Text.rich(
                                  TextSpan(
                                      text: "${patient.name} \n",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black
                                      ),
                                      children: [
                                        TextSpan(
                                            text: "Week: ${(patient.treatmentDay/7).ceil()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                color: kTextColor
                                            )
                                        )
                                      ]
                                  )
                              )
                          ),
                          CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 2.5,
                            percent: patient.treatmentDay/patient.totalTreatmentLength,
                            center: new Text("${(100*(patient.treatmentDay/patient.totalTreatmentLength)).round()}%", style: TextStyle(fontSize: 10)),
                            progressColor: Colors.green,
                          ),
                          SizedBox(width: kDefaultPadding,),
                          InkWell(
                            child: Icon(patient.criticalStatus?
                            Icons.clear:
                            Icons.check,
                                color: patient.criticalStatus?
                                Colors.red:
                                Colors.green,
                                size: 32
                            ),
                            onTap: (){
                              handleCriticalityChange();
                            },
                          )
                        ]
                    )
                  ],
                )
            ),
            if(patient.isMarked)
              Positioned(
                right: 8,
                top: 0,
                child: WebsafeSvg.asset(
                  "assets/Icons/pin.svg",
                  height: 18,
                  color: Colors.blue,
                )
            )
          ],
        ),
        )
    );
  }

}