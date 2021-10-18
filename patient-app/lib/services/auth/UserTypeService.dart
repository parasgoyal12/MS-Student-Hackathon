import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class UserTypeService{

  static final UserTypeService _singleton = UserTypeService._internal();
  factory UserTypeService() {
    return _singleton;
  }
  UserTypeService._internal();




  int userType = -1;
  String jwtToken = "";
  int userRegistered = -1;
  MyProfileUpdated myProfileUpdated;
  FriendRequest myFriendRequests;
  List<RExerciseRequest> myExerciseRequests;

  static String baseUrl = "https://treatment-application-dep.herokuapp.com";
//do not change order of the lists as indexing is used below to access: if want to add then add at end of list in api lists.
   List<String> loginAPI = [
     baseUrl+"/api/v1/users/login",
   ];
  List<String> registerAPI = [
    baseUrl+"/api/v1/register/patient",
    baseUrl+"/api/v1/register/relative",
  ];
  List<String> RelativeAPI=[
    baseUrl+"/api/v1/relative/getRequests",
    baseUrl+"/api/v1/relative/getFriendRequests",
    baseUrl+"/api/v1/relative/update_friend_requests",
    baseUrl+"/api/v1/relative/update_exercise_requests"
  ];

  Future<void> resetSingleton() async{
     userType = -1;
     jwtToken = "";
     userRegistered = -1;
     myProfileUpdated = null;
     myFriendRequests = null;
     myExerciseRequests = null;
  }

  Future<void> setUserRegistered(int status)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('registered',status);
  }

  Future<void> checkUserRegistered() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userRegistered = (prefs.getInt('registered') ?? -1);
  }

  Future<void> checkUserType() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = (prefs.getInt('type') ?? -1);
  }

  Future<void> setUserType(int type)async{
    userType = type;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('type',type);
  }

  Future<String> getAuthIdToken() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult authId = await user.getIdToken();
    return authId.token.toString();
  }

  Future<String> getUID() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    return uid;
  }


  Future<void> checkJWTToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwtToken = (prefs.getString('jwt') ?? "");
    //jwtToken = "";
  }

  Future<void> setJWTToken(String token)async{
    jwtToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt',token);
  }


  Future<int> setRole(FirebaseUser user,String mobileNumber)async{
    await checkUserType();
    if(userType==-1) throw Error();

    String authId  = await getAuthIdToken();

    Map<String, String> requestBody = {
      "mobile_number": mobileNumber,
      "user_type" : (userType == 0) ? "p" : "r",
      "auth_token" : authId
    };
    print("sending set role req");
    var response;
    try{
      response = await http.post(
        loginAPI[0],
        body: requestBody,
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 400){
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    if(response.statusCode == 200){
      setUserRegistered(200);
    }
    await setJWTToken(json.decode(response.body)["token"]);
    print(response.statusCode);
    return response.statusCode;
//    if (response.body.split(" ")[0] != "Registered"){
//      throw Error();
//    }


  }

  Future<int> registerPatient(String firstName, String lastName,String relative1,String relative2)async{
    await checkUserType();
    if(userType==-1) throw Error();

    await checkJWTToken();

    Map<String, String> requestBody = {
      "relative_2": relative2,
      "relative_1" : relative1,
      "first_name" : firstName,
      "last_name" : lastName
    };
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    print("sending reg p req");
    var response;
    try{
      response = await http.post(
        registerAPI[0],
        body: requestBody,
        headers: requestHeaders
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 400){
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    if(response.statusCode == 200){
      setUserRegistered(200);
    }
    print(response.body);
    print(response.statusCode);
    return response.statusCode;

  }
  Future<int> registerRelative(String firstName, String lastName)async{
    await checkUserType();
    if(userType==-1) throw Error();

    await checkJWTToken();

    Map<String, String> requestBody = {
      "first_name" : firstName,
      "last_name" : lastName,
      "mobile_number" :"8109601234"
    };
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    print("sending reg r req");
    var response;
    try{
      response = await http.post(
        registerAPI[1],
        body: requestBody,
        headers: requestHeaders
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 400){
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    if(response.statusCode == 200){
      setUserRegistered(200);
    }
    print(response.body);
    print(response.statusCode);
    return response.statusCode;

  }

  Future<MyProfileUpdated> getMyProfileData()async{


    if(myProfileUpdated != null){
      print("exists");
      print(myProfileUpdated.toJson());
      return MyProfileUpdated.fromJson(myProfileUpdated.toJson());
    }
    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();


    print("sending get profile req");
    var response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      'x-access-token': jwtToken
    };
    try{
      response = await http.get(
        baseUrl + '/api/v1/profile/get' ,
        headers: requestHeaders
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Got Profile");
      Map<String, dynamic> myObj = json.decode(response.body);
      myProfileUpdated = myObj['profile'] != null
          ? new MyProfileUpdated.fromJson(myObj['profile'])
          : new MyProfileUpdated.fromJson({});

      print(myProfileUpdated.toJson());
    }else {
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    print(response.body);
    print(response.statusCode);
    return MyProfileUpdated.fromJson(myProfileUpdated.toJson());

  }

  Future<MyProfileUpdated> updateMyProfileData(MyProfileUpdated updateQueryProfile)async{

    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();


    print("sending update pro data req");
    var response;
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    try{
      print("encoded val is ");
      print( json.encode(updateQueryProfile.toJson()));
      response = await http.post(
          baseUrl + '/api/v1/profile/update' ,
          headers: requestHeaders,
          body: updateQueryProfile.toJson()
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Got Profile");
      Map<String, dynamic> myObj = json.decode(response.body);
      myProfileUpdated = myObj['myProfileUpdated'] != null
          ? new MyProfileUpdated.fromJson(myObj['myProfileUpdated'])
          : new MyProfileUpdated.fromJson({});

      print(myProfileUpdated.toJson());
    }else {
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    print(response.body);
    print(response.statusCode);

    return MyProfileUpdated.fromJson(myProfileUpdated.toJson());

  }

  Future<int> UpdateFriendRequest(String user_id, String status) async {
    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();
    var response;
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    Map<String, String> requestBody = {
      'user_id': user_id,
      'status':status
    };
    try{
      response = await http.post(
          "https://treatment-application-dep.herokuapp.com/api/v1/relative/update_friend_requests" ,
          headers: requestHeaders,
          body:requestBody
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Update request successfull");
return 1;
    }else {
      print("Error in response");
      print(response.body);
      return 0;

      throw new Error();
    }
  }

  Future<bool> UpdateDayExerciseStatus(int currDay) async {
    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();
    var response;
    Map<String, String> requestHeaders = {
      'x-access-token':jwtToken
      //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzN2Y4MTExYS1mN2NlLTQ0MWYtOTQ2Yy1jOWRlMzJkZmRjZTAiLCJpYXQiOjE2MTc2MzUyNDgsImV4cCI6MTYxODI0MDA0OH0.wkOstU78AFAZcGwm5us8e1KuHCV_zkvWF0ojLfJejRY"
    };
    Map<String, String> requestBody = {
      'day': currDay.toString(),
    };
    try{
      print('Sending '+requestHeaders.toString());
      response = await http.post(
          "https://treatment-application-dep.herokuapp.com/api/v1/patient/update_exercises" ,
          headers: requestHeaders,
          body:requestBody
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Update Day successfull");
      return true;
    }else {
      print("Error in response");
      print(response.body);
      return false;
    }
  }

  Future<FriendRequest> GetFriendRequests()async{
    print(jwtToken);

    // if(myFriendRequests != null){
    //   //print("exists");
    //   //print(myFriendRequests.toJson());
    //   return FriendRequest.fromJson(myFriendRequests.toJson());
    // }
    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();


    print("sending get fr req");
    //print(jwtToken);
    var response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      'x-access-token': jwtToken
    };
    try{
      response = await http.get(
          RelativeAPI[1] ,
          headers: requestHeaders
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Got Friend Requests");
      //print(response.body);
      //return FriendRequest.fromJson(jsonDecode(response.body));
      Map<String, dynamic> myObj = json.decode(response.body);
      //print("Obj"+ myObj.toString());
      myFriendRequests = new FriendRequest.fromJson(myObj);

     // print("after got requests");
      //print(myFriendRequests.toJson());
     return myFriendRequests;
    }else {
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    // print(response.body);
    // print(response.statusCode);
    // return FriendRequest.fromJson(myFriendRequests.toJson());

  }

  Future<int> RUpdateExerciseRequest(String patient_id, int day, int exercise_id, String exercise_status) async
  {
    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();
    var response;
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    Map<String, String> requestBody = {
      'patient_id': patient_id,
      'day':day.toString(),
      'exercise_id':exercise_id.toString(),
      'exercise_status':exercise_status
    };
    try{
      response = await http.post(
          "https://treatment-application-dep.herokuapp.com/api/v1/relative/update_exercise_requests" ,
          headers: requestHeaders,
          body:requestBody
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Update request successfull");
      return 1;
    }else {
      print("Error in response");
      print(response.body);
      return 0;

      throw new Error();

    }



  }

  Future<List<RExerciseRequest>> GetRelativeExerciseRequests()async{
    await checkUserType();
    // if(myExerciseRequests != null){
    //   //print("exists");
    //   return myExerciseRequests;
    //   //print(myFriendRequests.toJson());
    //   //return RExerciseRequest.fromJson(myExerciseRequests.toJson());
    // }
    if(userType==-1) throw Error();

    await checkJWTToken();

    Map<String, String> requestBody = {
      "x-access-token" : jwtToken,
    };
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    var response;
    try{
      response = await http.get(
          "https://treatment-application-dep.herokuapp.com/api/v1/relative/getRequests",
          headers: requestHeaders
      );

    }
    catch(e){
      print(e);
    }

    if(response.statusCode == 200){
      print("Got Ex Requests");

      List<RExerciseRequest> myList = (json.decode(response.body) as List)
          .map((data) => RExerciseRequest.fromJson(data))
          .toList();
      print(myList);
      print("Test");
      myList.sort((a,b) => (b.todayDay).compareTo(a.todayDay));

      return myList;
   }
    else{

      print("Error in response");
      print(response.body);
      throw new Error();
    }
    // print(response.body);
    // print(response.statusCode);
    // return response.body.toString();



  }
  Future<List<PatientRequestModel>> GetPatientExerciseRequests()async{
    await checkUserType();
    // if(myExerciseRequests != null){
    //   //print("exists");
    //   return myExerciseRequests;
    //   //print(myFriendRequests.toJson());
    //   //return RExerciseRequest.fromJson(myExerciseRequests.toJson());
    // }
    if(userType==-1) throw Error();
    print(jwtToken);
    await checkJWTToken();
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    var response;
    try{
      response = await http.get(
          "https://treatment-application-dep.herokuapp.com/api/v1/patient/get_request_status",
          headers: requestHeaders
      );

    }
    catch(e){
      print(e);
    }

    if(response.statusCode == 200){
      print("Got Ex Requests");
      print(response.body); // TODO if empty list gives error
      List<PatientRequestModel> myList = (json.decode(response.body) as List)
          .map((data) => PatientRequestModel.fromJson(data))
          .toList();
      print(myList);
      print("Test");
      myList.sort((a,b) => b.todayDay.compareTo(a.todayDay));

      return myList;


    }
    else{
      print("Error in response in patient ex request");
      print(response.body);
      throw new Error();
    }
  }

  Future<List<TreatmentDayData>> GetPatientWeekExerciseDetails()async{
    await checkUserType();
    if(userType==-1) throw Error();

    await checkJWTToken();

    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
      //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzN2Y4MTExYS1mN2NlLTQ0MWYtOTQ2Yy1jOWRlMzJkZmRjZTAiLCJpYXQiOjE2MTc2MzUyNDgsImV4cCI6MTYxODI0MDA0OH0.wkOstU78AFAZcGwm5us8e1KuHCV_zkvWF0ojLfJejRY"
    };

    print(requestHeaders);

    var response;
    try{
      response = await http.get(
          "https://treatment-application-dep.herokuapp.com/api/v1/patient/get_treatment_data",
          headers: requestHeaders
      );

    }
    catch(e){
      print(e);
    }

    print(response.statusCode);

    if(response.statusCode == 200){
      print("Got DATA DAY");

      List<TreatmentDayData> curr = (json.decode(response.body) as List)
          .map((data) => TreatmentDayData.fromJson(data))
          .toList();
      print(curr);
      return curr;
    }
    else{

      print("Error in response");
      print(response.toString());
      throw new Error();
    }
    // print(response.body);
    // print(response.statusCode);
    // return response.body.toString();
  }


  Future<List<Feedbak>> GetPatientFeedbackForm(String day)async {
    await checkUserType();
    if(userType==-1) throw Error();
    print(jwtToken);
    await checkJWTToken();
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    Map<String, String> requestBody = {
      "day": day,

    };
    var response;
    try{
      response = await http.post(
          "https://treatment-application-dep.herokuapp.com/api/v1/questionnaire/get_patient_questionnaire",
          headers: requestHeaders,
          body:requestBody

      );

    }
    catch(e){
      print(e);
    }

    if(response.statusCode == 200){
      print("Got feedback form");
      print(response.body);
      return (json.decode(response.body) as List)
          .map((data) => Feedbak.fromJson(data))
          .toList();


    }
    else{

      print("Error in response in feedback form fetch");
      print(response.body);
      throw new Error();
    }
  }
  Future<int> PUpdateFeedback(String day, String id, String resp,{bool isLast = false}) async
  {
    //day='21';
    print("updating feedback for day: "+day+"id "+id+"resp "+resp+isLast.toString());
    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();
    var response;
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    Map<String, String> requestBody = {

      'day':day,
      'id': id,
      'response':resp
    };
    try{
      response = await http.post(
          "https://treatment-application-dep.herokuapp.com/api/v1/questionnaire/fill_questionnaire" ,
          headers: requestHeaders,
          body:requestBody
      );
      if(isLast){
        await http.get(
            "https://treatment-application-dep.herokuapp.com/api/v1/questionnaire/updateQuestionnaireInfo" ,
            headers: requestHeaders,
        );
      }
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Update feedback successfull  "+resp);
      return 1;
    }else {
      print("Error in response in feedback filling api");
      print(response.body);
      return 0;

      throw new Error();
    }

  }

  Future<RelativesInfo> getPatientRelativeInfo()async {
    await checkUserType();
    if(userType==-1) throw Error();
    print(jwtToken);
    await checkJWTToken();
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    var response;
    try{
      response = await http.get(
          "https://treatment-application-dep.herokuapp.com/api/v1/patient/getPatientRelativeInfo",
          headers: requestHeaders
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Got my relatives");
      print(response.body);
      return RelativesInfo.fromJson(json.decode(response.body)['profile']);


    }
    else{
      print("Error in response in feedback form fetch");
      print(response.body);
      throw new Error();
    }
  }


}
class MyProfileUpdated {
  String userId;
  String firstName;
  String lastName;
  String dob;
  String profilePic;
  String homeAddress;
  String emailId;
  String createdDate;
  String modifiedDate;

  MyProfileUpdated(
      {this.userId,
        this.firstName,
        this.lastName,
        this.dob,
        this.profilePic,
        this.homeAddress,
        this.emailId,
        this.createdDate,
        this.modifiedDate});

  MyProfileUpdated.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] == null ? "" : json['user_id'];
    firstName = json['first_name'] == null ? "" : json['first_name'];
    lastName = json['last_name'] == null ? "" : json['last_name'];
    dob = json['dob'] == null ? "" : json['dob'];
    profilePic = json['profile_pic'] == null ? "" : json['profile_pic'];
    homeAddress = json['home_address'] == null ? "" : json['home_address'];
    emailId = json['email_id'] == null ? "" : json['email_id'];
    createdDate = json['created_date'] == null ? "" : json['created_date'];
    modifiedDate = json['modified_date'] == null ? "" : json['modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['user_id'] = this.userId == null ? "" : this.userId;
    data['first_name'] = this.firstName == null ? "" : this.firstName;
    data['last_name'] = this.lastName == null ? "" : this.lastName;
    data['dob'] = this.dob == null ? "" : this.dob;
    data['profile_pic'] = this.profilePic == null ? "" : this.profilePic;
    data['home_address'] = this.homeAddress == null ? "" : this.homeAddress;
    data['email_id'] = this.emailId == null ? "" : this.emailId;
    data['created_date'] = this.createdDate == null ? "" : this.createdDate;
    data['modified_date'] = this.modifiedDate == null ? "" : this.modifiedDate;
    return data;
  }

  }

class FriendRequest {
  String my_number;
List<FRequestModel> Req_list=[];


  FriendRequest(
      { this.my_number,
   this.Req_list});

  FriendRequest.fromJson(Map<String, dynamic> json) {
   // print("above my number");
    my_number = json['myNumber'] == null ? "" : json['myNumber'];

    for(int i=0;i<json['patients'].length;i++)
    Req_list.add(
        FRequestModel.fromJson(json['patients'][i]));

  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['my_number'] = this.my_number == null ? "" : this.my_number;
    data['patients'] = this.Req_list == null ? "" : this.Req_list.map((i) => i.toJson()).toList();

    return data;
  }
}

class FRequestModel {
  String first_name;
  String last_name;
  String profile_pic;
  String user_id;
  String relative_1;
  String relative_2;
  String relative_1_status;
  String relative_2_status;


  FRequestModel({
    this.first_name,
    this.last_name,
    this.profile_pic,
    this.user_id,
    this.relative_1,
    this.relative_2,
    this.relative_1_status,
    this.relative_2_status});

  FRequestModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'] == null ? "" : json['user_id'];
    first_name = json['first_name'] == null ? "" : json['first_name'];
    last_name = json['last_name'] == null ? "" : json['last_name'];
    profile_pic = json['profile_pic'] == null ? "" : json['profile_pic'];
    relative_1 = json['relative_1'] == null ? "" : json['relative_1'];
    relative_2 = json['relative_2'] == null ? "" : json['relative_2'];
    relative_1_status = json['relative_1_status'] == null ? "" : json['relative_1_status'];
    relative_2_status = json['relative_2_status'] == null ? "" : json['relative_2_status'];
   // print("hello");
    //print(user_id+first_name+relative_1+relative_2_status);
  }
  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['user_id'] = user_id == null ? "" : user_id;
    data['first_name'] = first_name == null ? "" : first_name;
    data['last_name'] = last_name == null ? "" : last_name;
    data['profile_pic'] = profile_pic == null ? "" : profile_pic;
    data['relative_1'] = relative_1 == null ? "" : relative_1;
    data['relative_2'] = relative_2 == null ? "" : relative_2;
    data['relative_1_status']=relative_1_status == null ? "" : relative_1_status;
    data['relative_2_status']=relative_2_status == null ? "" : relative_2_status;
    return data;
}
}

//for receiveing data of relative home page requests
class RExerciseRequest {
  String firstName;
  String lastName;
  String profilePic;
  int todayDay;
  String exerciseName;
  String exerciseVideoUrl;
  String userId;
  int exerciseId;
  int markedByRelative;

  RExerciseRequest(
      {this.firstName,
        this.lastName,
        this.profilePic,
        this.todayDay,
        this.exerciseName,
        this.exerciseVideoUrl,
        this.userId,
        this.exerciseId,
        this.markedByRelative});

  RExerciseRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
    todayDay = json['today_day'];
    exerciseName = json['exercise_name'];
    exerciseVideoUrl = json['exercise_video_url'];
    userId = json['user_id'];
    exerciseId = json['exercise_id'];
    markedByRelative = json['marked_by_relative'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    data['today_day'] = this.todayDay;
    data['exercise_name'] = this.exerciseName;
    data['exercise_video_url'] = this.exerciseVideoUrl;
    data['user_id'] = this.userId;
    data['exercise_id'] = this.exerciseId;
    data['marked_by_relative'] = this.markedByRelative;
    return data;
  }
}


class TreatmentDayData {
  int todayDay;
  String exerciseName;
  int exerciseRep;
  String instructions;
  String exerciseVideoUrl;
  String exerciseImgUrl;
  int duration;
  int markedByPatient;

  TreatmentDayData(
      {this.todayDay,
        this.exerciseName,
        this.exerciseRep,
        this.instructions,
        this.exerciseVideoUrl,
        this.exerciseImgUrl,
        this.duration,
        this.markedByPatient});

  TreatmentDayData.fromJson(Map<String, dynamic> json) {
    todayDay = json['today_day'] == null ? 0 : json['today_day'];
    exerciseName = json['exercise_name']== null ? "" : json['exercise_name'];
    exerciseRep = json['exercise_rep']== null ? 0 : json['exercise_rep'];
    instructions = json['instructions']== null ? "" : json['instructions'];
    exerciseVideoUrl = json['exercise_video_url']== null ? "" : json['exercise_video_url'];
    exerciseImgUrl = json['exercise_img_url']== null ? "" : json['exercise_img_url'];
    duration = json['duration']== null ? 0 : json['duration'];
    markedByPatient = json['marked_by_patient']== null ? 0 : json['marked_by_patient'];
  }
}

class PatientRequestModel {
  //String relativeName;
  int todayDay;
  String exerciseName;
  int markedByRelative;

  PatientRequestModel(
      {//this.relativeName,
        this.todayDay,
        this.exerciseName,
        this.markedByRelative});

  PatientRequestModel.fromJson(Map<String, dynamic> json) {
    //relativeName = json['relative_name'];
    todayDay = json['today_day'];
    exerciseName = json['exercise_name'];
    markedByRelative = json['marked_by_relative'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['relative_name'] = this.relativeName;
    data['today_day'] = this.todayDay;
    data['exercise_name'] = this.exerciseName;
    data['marked_by_relative'] = this.markedByRelative;
    return data;
  }
}

class Feedbak {
  int questionNo;
  String question;
  String question_hi;
  String question_pa;

  Feedbak({this.questionNo, this.question,this.question_hi,this.question_pa});

  Feedbak.fromJson(Map<String, dynamic> json) {
    questionNo = json['question_no'];
    question = json['question'];
    question_hi=json['question_hindi'];
    question_pa=json['question_punjabi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_no'] = this.questionNo;
    data['question'] = this.question;
    data['question_hindi']=this.question_hi;
    data['question_punjabi']=this.question_pa;
    return data;
  }
}


class RelativesInfo {
  String relative1;
  String relative1Status;
  String relative2;
  String relative2Status;

  RelativesInfo(
      {this.relative1,
        this.relative1Status,
        this.relative2,
        this.relative2Status});

  RelativesInfo.fromJson(Map<String, dynamic> json) {
    relative1 = json['relative_1'];
    relative1Status = json['relative_1_status'];
    relative2 = json['relative_2'] == null ? "" : json['relative_2'];
    relative2Status = json['relative_2_status'] == null ? "" : json['relative_2_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relative_1'] = this.relative1;
    data['relative_1_status'] = this.relative1Status;
    data['relative_2'] = this.relative2;
    data['relative_2_status'] = this.relative2Status;
    return data;
  }
}