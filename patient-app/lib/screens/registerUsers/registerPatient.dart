import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/screens/Relative/relative_home.dart';
import 'dart:math' as math;
import 'package:treatment_checkup_app/widgets/IconImages.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';

class RegisterPatientRelative extends StatefulWidget {

  @override
  _RegisterPatientRelativeState createState() => _RegisterPatientRelativeState();
}

class _RegisterPatientRelativeState extends State<RegisterPatientRelative> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameFirst = new TextEditingController();
  final TextEditingController _userNameSecond = new TextEditingController();
  final TextEditingController _relative1 = new TextEditingController();
  final TextEditingController _relative2 = new TextEditingController();
  bool isLoading;
  UserTypeService userService;

  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: const BorderRadius.all(
      const Radius.circular(50),
    ),
  );

  final textFieldPadding = const EdgeInsets.only(bottom: 5, left: 20);

  final filledColor = Color.fromRGBO(0,0,0, 0.11);

  final hintTextStyle = new TextStyle(
      color: Colors.grey.withOpacity(0.5), fontSize: 14);
  final hintTextStyleSolid = new TextStyle(
      color: Colors.grey.withOpacity(1), fontSize: 14);


  void successPushPage(int statusCode){

    print("Pushing with status code " + statusCode.toString());

   if(userService.userType == 0 && statusCode == 200){ // patient
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> DetailsScreen()));
    }
    else if(userService.userType == 1 && statusCode == 200){ // relative
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> RequestsScreenR())); //todo
    }
    else{
      print("Some error");
    }
  }

  Future<void> _registerPatient() async {
    setState(() {
      isLoading = true;
    });
    int statusCode = await userService.registerPatient(_userNameFirst.text, _userNameSecond.text, _relative1.text, _relative2.text);
    successPushPage(statusCode);
  }

  Future<void> _registerRelative() async {
    setState(() {
      isLoading = true;
    });
    int statusCode = await userService.registerRelative(_userNameFirst.text, _userNameSecond.text);
    successPushPage(statusCode);
  }


  String _mobileValidator(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);

    if (value.trim().length != 10)
      return 'Mobile Number must be of 10 digit';
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    else
      return null;
  }

  String _nameValidator(String value) {

    if (value.trim().length == 0)
      return 'Name Can not be Empty';
    else
      return null;
  }

  @override
  void initState() {
    isLoading = false;
    userService = UserTypeService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = constraints.maxWidth;
            return Scaffold(
                body : SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight,
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 38),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container()
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: TreatmentIconLogoSmall()
                                  ),
                                ],
                              ),
                              flex: 100,
                            ),
                            Expanded(
                              child: Container(
                                // color: Colors.pink,
                                  padding: EdgeInsets.only(
                                      left: width * (30 / 375),
                                      right: width * (30 / 375)),
                                  child: Form(
                                    key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                              child: Text(
                                                "Register",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                ),
                                              )),

                                          TextFormField(
                                            onSaved: (String val) {},
                                            validator: _nameValidator,
                                            keyboardType: TextInputType.text,
                                            controller: _userNameFirst,
                                            decoration: new InputDecoration(
                                              suffixIcon: Icon(Icons.supervised_user_circle),

                                              fillColor: filledColor,
                                              filled: true,
                                              contentPadding: textFieldPadding,
                                              enabledBorder: outlineBorder,
                                              focusedBorder: outlineBorder,
                                              hintStyle: hintTextStyleSolid,
                                              hintText: "First Name",
                                            ),
                                            maxLines: 1,
                                          ),

                                          TextFormField(
                                            validator: _nameValidator,
                                            onSaved: (String val) {},
                                            keyboardType: TextInputType.text,
                                            controller: _userNameSecond,
                                            decoration: new InputDecoration(
                                              suffixIcon: Icon(Icons.supervised_user_circle)
                                              ,
                                              fillColor: filledColor,
                                              filled: true,
                                              contentPadding: textFieldPadding,
                                              enabledBorder: outlineBorder,
                                              focusedBorder: outlineBorder,
                                              hintStyle: hintTextStyleSolid,
                                              hintText: "Last Name",
                                            ),
                                            maxLines: 1,
                                          ),


                                          userService.userType == 0 ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, bottom: 9,top: 20),
                                                child: Text(
                                                  "Relative's Information",
                                                  style: hintTextStyleSolid,
                                                ),
                                              ),
                                               TextFormField(
                                                validator: _mobileValidator,
                                                onSaved: (String val) {},
                                                keyboardType: TextInputType.number,
                                                controller: _relative1,
                                                decoration: new InputDecoration(
                                                  prefixText: "+91",
                                                  prefixStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 16),
                                                  suffixIcon:  Icon(Icons.mobile_friendly),
                                                  fillColor: filledColor,
                                                  filled: true,
                                                  contentPadding: textFieldPadding,
                                                  enabledBorder: outlineBorder,
                                                  focusedBorder: outlineBorder,
                                                  hintStyle: hintTextStyleSolid,
                                                  hintText: "Relative 1 Mobile Number",
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ) : Container(),
                                          userService.userType == 0 ? TextFormField(
                                            //validator: _mobileValidator,
                                            onSaved: (String val) {},
                                            keyboardType: TextInputType.number,
                                            controller: _relative2,
                                            decoration: new InputDecoration(
                                              prefixText: "+91",
                                              prefixStyle: TextStyle(color: Colors.black,fontSize: 16),
                                              suffixIcon: Icon(Icons.mobile_friendly)
                                              ,
                                              fillColor: filledColor,
                                              filled: true,
                                              contentPadding: textFieldPadding,
                                              enabledBorder: outlineBorder,
                                              focusedBorder: outlineBorder,
                                              hintStyle: hintTextStyleSolid,
                                              hintText: "Relative 2 Mobile Number(optional)",
                                            ),
                                            maxLines: 1,
                                          ) : Container(),
                                          InkWell(
                                              onTap: () async{
                                                if(userService.userType == 0 && _formKey.currentState.validate()){
                                                  await _registerPatient().catchError((e){
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  });
                                                }else if(userService.userType == 1 && _formKey.currentState.validate()){
                                                  await _registerRelative().catchError((e){
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  });
                                                }
                                              },
                                              child: RaisedPinkButton("Submit")),
                                        ],
                                      ))),
                              flex: 200,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "",

                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",

                                        ),
                                        InkWell(
                                          onTap: (){

                                          },
                                          child: Text(
                                            "",
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              flex: 60,
                            ),
                          ],
                        ),
                      ),
                      isLoading == true? Container(
                          color: Colors.black.withOpacity(0.5),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: CircularProgressIndicator(),)):Container(),
                    ],
                  ),
                )
            );
          }),
    );

  }
}


class RaisedPinkButton extends StatelessWidget {
  RaisedPinkButton(this.str, {this.fontSize = 15, this.onlyBorder = false});
  final String str;
  final double fontSize;
  final bool onlyBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: onlyBorder == false ? LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              transform: GradientRotation((math.pi) / (360 / 191)),
              colors: [
                Color.fromRGBO(228, 34, 69, 1),
                Color.fromRGBO(228, 34, 69, 0),
              ],
              stops: [
                0.5,
                1
              ]
          ) : null,
          border: onlyBorder == false ? null : Border.all(
              color: Color.fromRGBO(228, 34, 69, 1), width: 3)
      ),
      height: 50,
      child: Center(
        child: Text(
            str, style: TextStyle(color: Colors.white, fontSize: fontSize)),
      ),
    );
  }
}
