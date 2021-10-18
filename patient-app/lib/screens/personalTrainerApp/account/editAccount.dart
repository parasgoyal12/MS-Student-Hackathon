
import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/apiKeys.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/account/AccountHome.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/clientsHome/clientsFullDetails.dart';
import 'package:treatment_checkup_app/services/personalTrainer/editProfile.dart';
import 'dart:math' as math;

import 'package:treatment_checkup_app/services/personalTrainer/profile.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:treatment_checkup_app/widgets/buttons.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';





class EditAccountInjector extends StatelessWidget {
  final TrainerProfile tp;
  EditAccountInjector(this.tp);
  @override
  Widget build(BuildContext context) {
    return Injector(

      inject: [Inject(() => ProfileEdit(tp))],
      builder: (_) {
        return EditAccount();
      },
    );
  }
}



class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState()  {
    return _EditAccountState();
  }
}

class _EditAccountState extends State<EditAccount> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyEduCer = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyLocation = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyBio = GlobalKey<FormState>();

  final profileEdit = Injector.get<ProfileEdit>();
  @override
  void initState() {
    super.initState();
  }


  Widget profilePhotos(BuildContext context,String uri){

    return InkWell(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/6,
            width: MediaQuery.of(context).size.width/4,
            child: CachedNetworkImage(
              imageUrl: uri,
              fit: BoxFit.fitHeight,
              placeholder: (context, uri) => Center(child: CircularProgressIndicator(),),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: (){
                profileEdit.profileImages.remove(uri);
                profileEdit.rebuildStates();
              },
              child: Container(
                alignment: Alignment.center,
                child: Icon(Icons.remove,color: Colors.white,size: 12,),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget addMore(BuildContext context){
    return InkWell(
      onTap: () async {
        print("uploading");



        await profileEdit.addUploadImage().catchError((e){
          profileEdit.isLoading = false;
          profileEdit.rebuildStates();
        });

        print("UPLOADED");

        //profileEdit.isLoading = true;

      },
      child: Container(
        height: MediaQuery.of(context).size.height/6,
        width: MediaQuery.of(context).size.width/4,
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }


  void saveProfile() async {



    bool status = await profileEdit.saveProfile().catchError((e){
      profileEdit.isLoading = false;
      profileEdit.rebuildStates();
    });

    if(status){
      Navigator.pop(context,true);
    }


  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.close),
            ),

          ],
        ),
        body: StateBuilder(

            models: [profileEdit],
            builder: (context, _) {

              print("rebuilding");
              print(profileEdit.profileImages.length);

              return Stack(
                children: <Widget>[
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20,top: 20),
                                    child: Text("Profile Photos",style: TextStyle(
                                      color: Color.fromRGBO(108, 71, 145, 1),
                                    ),),
                                  ),




                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child:Row(
                                      children: <Widget>[
                                        for(int i=0 ;i< profileEdit.profileImages.length;i++) Padding(
                                          padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                                          child:  profilePhotos(context,profileEdit.profileImages[i]),
                                        ),
                                        addMore(context),
                                      ],
                                    ),


                                  ),


                                  PersonalInfoEditCard(profileEdit.profile,formKey),
                                  EducationCertificationEdit(profileEdit.profile,formKeyEduCer),
                                  TrainingLocationEdit(profileEdit.profile,formKeyLocation),
                                  BioTrainerItem(profileEdit.profile,formKeyBio),
                                  Padding(padding: EdgeInsets.only(bottom: 120),),


//                      PersonalInfoEditCard(),
//                      PersonalInfoEditCard(),
//                      PersonalInfoEditCard()
                                ],
                              )
                          ),
                        ),
                      );
                    },
                  ),


                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 80,
                      // color: Colors.white,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white70
                              ]
                          )
                      ),
                      width: MediaQuery.of(context).size.width,

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 100,
                            child: greyButton("Cancel", function: (){Navigator.of(context).pop();}),
                          ),
                          Container(
                              height: 40,
                              width: 100,
                              child: purpleButton("SAVE",function: (){
                                saveProfile();
                              })
                          ),


                        ],
                      ),
                    ),
                  ),


                profileEdit.isLoading ==true?Container(
                    color: Colors.black26,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ):Container(),
                ],
              );

            }

        ),



    );
  }
}




class PersonalInfoEditCard extends StatefulWidget {
  final TrainerProfile tp;
  final GlobalKey<FormState> formKey;
  PersonalInfoEditCard(this.tp,this.formKey);
  @override
  _PersonalInfoEditCardState createState() => _PersonalInfoEditCardState();
}

class _PersonalInfoEditCardState extends State<PersonalInfoEditCard> {
  final profileEdit = Injector.get<ProfileEdit>();
  TextEditingController _profileName ;
  TextEditingController _phoneNumber ;
  TextEditingController _email ;



  List<String> gender =[
    "Male",
    "Female",
    "Others"
  ];
  int selectedGender = 0;

  @override
  void initState() {

    _profileName = new TextEditingController();
    _profileName.text = widget.tp.name;

    _phoneNumber = new TextEditingController();
    _phoneNumber.text = widget.tp.phone;

    _email = new TextEditingController();
    _email.text = widget.tp.email;

    if(gender.contains(widget.tp.gender)){
      selectedGender = gender.indexOf(widget.tp.gender);
    }

    super.initState();

  }



  Widget buildPersonalItems(BuildContext context){

    final Widget button = SizedBox(
      width: MediaQuery.of(context).size.width/1.7,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                gender[selectedGender],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            SizedBox(
                width: 17,
                height: 17,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ))),
          ],
        ),
      ),
    );


    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Form(
        key: widget.formKey,
        autovalidate: false,
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
            TextFormField(
              controller: _profileName,

              onChanged: (text){
                widget.tp.name = text;
              },
            ),

            Divider(height: 30,),


            Text("Date of Birth",
              style: TextStyle(
                  color: Color.fromRGBO(123, 123, 123, 1),
                  fontSize: 13
              ),
            ),
            SizedBox(height: 5,),
            InkWell(
              child: Container(
                color:Colors.green,
                height: 25,
                width: MediaQuery.of(context).size.width/2,
                child: Text(widget.tp.dOB.length==0?"Please Select a Date": widget.tp.dOB,
                  style: TextStyle(

                      fontSize: 12
                  ),),
              ),
              onTap: (){
                DatePicker.showDatePicker(context,
                onConfirm: (dateTime, List<int> index) {
                  setState(() {
                    widget.tp.dOB = dateTime.toString().split(" ")[0];
                  });
                },
                  onClose: () => print("----- onClose -----"),
                  onCancel: () => print('onCancel'),
                  onChange: (dateTime, List<int> index) {
                    setState(() {
                      print('onChange');
                    });
                  },
                  maxDateTime: DateTime.now()
                );
              },
            ),
            Divider(height: 30,),



            Text("Gender",
              style: TextStyle(
                  color: Color.fromRGBO(123, 123, 123, 1),
                  fontSize: 13
              ),
            ),
            SizedBox(height: 4,),
            MenuButton(
              child: button,
              items: gender,
              topDivider: true,
              itemBuilder: (value) => Container(
                  height: 45,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),

                  )),
              toggledChild: Container(
                color: Colors.white,
                child: button,
              ),
              divider: Container(
                height: 1,
                color: Colors.grey.withOpacity(0.2),
              ),
              onItemSelected: (value) {
                setState(() {
                  selectedGender = gender.indexOf(value);
                  widget.tp.gender = value;
                });
              },
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: const BorderRadius.all(Radius.circular(22.5)),
                  color: Colors.white
              ),
            ),
            Text(widget.tp.gender,
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
            Column(
              mainAxisSize: MainAxisSize.min,
              


              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(Icons.phone),
                    SizedBox(width: 10,),
                    Flexible(
                      child: TextFormField(
                        controller: _phoneNumber,

                        onChanged: (text){
                          widget.tp.phone = text;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(Icons.email),
                    SizedBox(width: 10,),
                    Flexible(
                      child: TextFormField(
                        controller: _email,

                        onChanged: (text){
                          widget.tp.email= text;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 30,),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Identity Proof",
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(

                        onTap: () async {
                          await profileEdit.addUploadIdentityProof().catchError((e){
                            profileEdit.setIsLoading(false);
                          });
                        },
                        child: Icon(Icons.insert_drive_file)),
                  ],
                ),
                SizedBox(width: 15,),
                Row(
                  children: <Widget>[
                    Text("Address Proof",
                      style: TextStyle(
                          fontSize: 10
                      )
                      ,
                    ),
                    SizedBox(width: 10,),
                    InkWell(

                        onTap: () async {
                          await profileEdit.addUploadAddressProof().catchError((e){
                            profileEdit.setIsLoading(false);
                          });
                        },
                        child: Icon(Icons.insert_drive_file)
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20,),

          ],
        ),
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
                    expanded: buildPersonalItems(context),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class EducationCertificationEdit extends StatefulWidget {
  final TrainerProfile tp;
  final GlobalKey<FormState> formKey;
  EducationCertificationEdit(this.tp,this.formKey);
  @override
  _EducationCertificationEditState createState() => _EducationCertificationEditState();
}

class _EducationCertificationEditState extends State<EducationCertificationEdit> {

  final profileEdit = Injector.get<ProfileEdit>();
  TextEditingController _eduBackground ;
  TextEditingController _certifications ;


  @override
  void initState() {

    _eduBackground = new TextEditingController();
    _eduBackground.text = widget.tp.education;

    _certifications = new TextEditingController();
    _certifications.text = widget.tp.certifications;
    super.initState();

  }

  Widget buildEduCerEditItems(){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Form(
        key: widget.formKey,
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
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              controller: _eduBackground,
              onChanged: (text){
                widget.tp.education = text;
              },
            ),
            Divider(height: 30,),


            Text("Certifications",
              style: TextStyle(
                  color: Color.fromRGBO(123, 123, 123, 1),
                  fontSize: 13
              ),
            ),
            SizedBox(height: 4,),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              controller: _certifications,
              onChanged: (text){
                widget.tp.certifications = text;
              },
            ),
            Divider(height: 30,),
            SizedBox(height: 4,),

            Row(
              children: <Widget>[
                Text("Masters",
                  style: TextStyle(
                      fontSize: 10
                  )
                  ,
                ),
                SizedBox(width: 10,),
                InkWell(

                    onTap: () async {
                      await profileEdit.addUploadMastersDocument().catchError((e){
                        profileEdit.setIsLoading(false);
                      });
                    },
                    child: Icon(Icons.insert_drive_file)
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text("CPR/AED/FA",
                  style: TextStyle(
                      fontSize: 10
                  )
                  ,
                ),
                SizedBox(width: 10,),
                InkWell(

                    onTap: () async {
                      await profileEdit.addUploadCprAedFaDocument().catchError((e){
                        profileEdit.setIsLoading(false);
                      });
                    },
                    child: Icon(Icons.insert_drive_file)
                ),
              ],
            ),

            SizedBox(height: 20,),

          ],
        ),
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
                    expanded: buildEduCerEditItems(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}



class TrainingLocationEdit extends StatefulWidget {
  final TrainerProfile tp;
  final GlobalKey<FormState> formKey;
  TrainingLocationEdit(this.tp,this.formKey);
  @override
  _TrainingLocationEditState createState() => _TrainingLocationEditState();
}

class _TrainingLocationEditState extends State<TrainingLocationEdit> {

  double longitude,latitude;
  final profileEdit = Injector.get<ProfileEdit>();


  TextEditingController _trainingAddress ;


  void _updateLatLong(){
    if(widget.tp.trainingLocationGeo.split(" ").length >= 2){
      latitude = double.parse(widget.tp.trainingLocationGeo.split(" ")[0]);
      longitude = double.parse(widget.tp.trainingLocationGeo.split(" ")[1]);
    }
  }

  @override
  void initState() {
    _trainingAddress = new TextEditingController();
    _trainingAddress.text = widget.tp.trainingLocation;
    _updateLatLong();
    super.initState();
  }
  @override
  void didUpdateWidget(covariant oldWidget){
    super.didUpdateWidget(oldWidget);
    _updateLatLong();
  }

  Widget buildTrainingLocationEdits(){
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5),
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text("Full Address",
                style: TextStyle(
                    color: Color.fromRGBO(123, 123, 123, 1),
                    fontSize: 13
                ),
              ),
              SizedBox(height: 4,),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: _trainingAddress,
                onChanged: (text){
                  widget.tp.trainingLocation = text;
                },
              ),
              SizedBox(height: 15,),



              (longitude!=null && latitude != null) ?
              MiniMapClientLocation(profileEdit.profile.trainingLocationGeo,
                  "Training Location",
                  ""):
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Text("NO Location Coordinates",
                  style: TextStyle(
                      color: Color.fromRGBO(123, 123, 123, 1),
                      fontSize: 13
                  ),
                ),
              ),


              SizedBox(height: 15,),

              Row(
                children: <Widget>[
                  Text("Select Location on Map",
                    style: TextStyle(
                        fontSize: 10
                    ),),
                  SizedBox(width: 10,),
                  InkWell(
                      onTap: () async {
                        LocationResult result =
                        await showLocationPicker(context,ApiKeys().googleMaps);
                        print(result.toString());
                        if(result!=null){
                          profileEdit.handleSelectLocation(result);
                        }
                      },
                      child: Icon(Icons.location_on)),
                ],
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
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
                    expanded: buildTrainingLocationEdits(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}


class BioTrainerItem extends StatefulWidget {
  final TrainerProfile tp;
  final GlobalKey<FormState> formKey;
  BioTrainerItem(this.tp,this.formKey);
  @override
  _BioTrainerItemState createState() => _BioTrainerItemState();
}

class _BioTrainerItemState extends State<BioTrainerItem> {

  final profileEdit = Injector.get<ProfileEdit>();

  TextEditingController _bio,_facebook,_instagram,_twitter,_other,_youtube;

  void createUpdateLinks(TextEditingController tec,String social){
    tec.text = "";
    for(var elem in profileEdit.socialMediaLinks){
      List<String> sl = elem.split(":");
      if(sl[0].toLowerCase() == social.toLowerCase() && sl.length>=2){
        tec.text = sl[1];
      }
    }
  }

  @override
  void initState() {
    _bio = new TextEditingController();
    _bio.text = widget.tp.bio;

    _facebook = new TextEditingController();
    _twitter = new TextEditingController();
    _youtube = new TextEditingController();
    _instagram = new TextEditingController();
    _other = new TextEditingController();


    createUpdateLinks(_facebook,"facebook");
    createUpdateLinks(_twitter,"twitter");
    createUpdateLinks(_instagram,"instagram");
    createUpdateLinks(_youtube,"youtube");
    createUpdateLinks(_other,"other");
    super.initState();
  }

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

  String buildSocialAll(){

    String socialMedia = "gg";
    try{
      socialMedia = "twitter:" + _twitter.text.toString()+ "+#+#+" +
          "facebook:" + _facebook.text.toString()  + "+#+#+" +
          "youtube:" + _youtube.text.toString()  + "+#+#+" +
          "instagram:" + _instagram.text.toString()  + "+#+#+" +
          "other:" + _other.text.toString() ;
    }
    catch(e) {
      print(e);
    }
    return socialMedia;
  }

  Widget buildSocialRow(TextEditingController tec,String social){

    return Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(buildIconForSocial(social)),
          SizedBox(width: 10,),
          Expanded(
            child: TextFormField(
              controller: tec,
              onChanged: (text){
                print("inside");
                widget.tp.socialMedia = buildSocialAll();
                print(widget.tp.socialMedia + " hello");
                },
              decoration: InputDecoration(
                hintText: social.toUpperCase(),
              ),
            ),
          ),
        ],
    );
  }

  Widget buildBioTrainerEdit(){
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text("Bio",
              style: TextStyle(
                  color: Color.fromRGBO(123, 123, 123, 1),
                  fontSize: 13
              ),
            ),
            SizedBox(height: 4,),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              controller: _bio,
              onChanged: (text){
                widget.tp.bio = text;
              },
            ),
            SizedBox(height: 15,),

            buildSocialRow(_twitter,"twitter"),
            buildSocialRow(_facebook,"facebook"),
            buildSocialRow(_youtube,"youtube"),
            buildSocialRow(_instagram,"instagram"),
            buildSocialRow(_other,"other"),

          ],
        ),
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
                    expanded: buildBioTrainerEdit(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}