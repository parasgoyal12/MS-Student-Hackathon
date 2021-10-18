import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:treatment_checkup_app/screens/Relative/relative_home.dart';
import 'package:treatment_checkup_app/screens/otpVerify/otpEnter.dart';
//import 'package:treatment_checkup_app/screens/personalTrainerApp/homePagePersonalTrainer.dart';
import 'package:treatment_checkup_app/screens/splashScreen/splashScreen.dart';
import 'package:treatment_checkup_app/screens/trainingCenters/pricingRevenue/pricingAndRevenue.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';
import 'package:treatment_checkup_app/screens/welcomeBoarding/welcomeBoarding.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/services/auth/FirebaseUser.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:treatment_checkup_app/screens/registerUsers/registerPatient.dart';

import 'Localization/demo_localization.dart';
import 'Localization/localization_constant.dart';
main() {
  runApp(
      RestartWidget(
        child: MaterialApp(
          supportedLocales: const <Locale>[
            Locale('en','US'),
            Locale('hi','IN'),
            Locale('pa','IN')
          ],


            debugShowCheckedModeBanner: false,
            home: MyApp(),
        ),
      )
  );
}



class TreatmentPartner extends StatefulWidget {


  @override
  _TreatmentPartnerState createState() => _TreatmentPartnerState();
}

class _TreatmentPartnerState extends State<TreatmentPartner> {
  final userService = new UserTypeService();
  final firebaseCheckService= new FirebaseSignInService();


  void _checkAppType(){



    print("inside " + userService.userType.toString() +"   "+ firebaseCheckService.user.toString());

    if((userService.userType == -1) || (firebaseCheckService.user == null) || ((userService.userRegistered == -1)) || ((userService.jwtToken == ""))){
    //Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> RegisterPatientRelative()));
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> WelcomeBoarding()));
    }


    else if((userService.userType ==0) && (firebaseCheckService.user != null)){  // patient
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> DetailsScreen()));
    }
    else if((userService.userType ==1) && (firebaseCheckService.user != null)){   // relative
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> RequestsScreenR())); //todo
    }
    else{
      print("Push Failed");
    }


  }

  @override
  void initState() {
    userService.checkUserType();
    userService.checkUserRegistered();
    userService.checkJWTToken();
    firebaseCheckService.checkLogin();

    Timer(Duration(seconds: 3), _checkAppType);  //TODO
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return SplashScreen();
  }
}



class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

// ///////all related to lang

//
// void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        //title: "Flutter Localization Demo",
        //theme: ThemeData(primarySwatch: Colors.blue),
        locale: _locale,
        supportedLocales: [
            Locale('en','US'),
            Locale('hi','IN'),
            Locale('pa','IN')
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        // onGenerateRoute: CustomRouter.generatedRoute,
        // initialRoute: homeRoute,
        home:
        TreatmentPartner(),
      );
    }
  }
}