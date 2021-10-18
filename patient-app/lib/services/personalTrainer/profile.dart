import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class TrainerProfileService{

  static final TrainerProfileService _singleton = TrainerProfileService._internal();
  factory TrainerProfileService() {
    return _singleton;
  }
  TrainerProfileService._internal();

  bool resetData = true;



  List<String> profileImages = [];
  List<String> socialMedia = [];


  static String baseUrl = "deleted";
  static UserTypeService userService = UserTypeService();
  TrainerProfile trainerProfile;

  void setNull(){
    trainerProfile = null;
  }

  Future<TrainerProfile> getProfile() async {
    if(trainerProfile!=null) return trainerProfile;
    String authToken = await userService.getAuthIdToken();
    String UID = await userService.getUID();


    print(authToken);
    print(UID);
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      'Authorization': authToken
    };
    final response = await http.get(
        baseUrl+"/api/trainers/"+UID,
        headers: requestHeaders
    );

    print(response.body);
    print("test\n\n\n");
    try{
      trainerProfile = new TrainerProfile.fromJson(json.decode(response.body));
      if(trainerProfile.images.length > 10 ){
        profileImages =  trainerProfile.images.split("+#+#+");
      }
      if(trainerProfile.socialMedia.length > 10){
        socialMedia = trainerProfile.socialMedia.split("+#+#+");
      }
    }
    catch(e){
      print(e);
    }
    return trainerProfile;

  }


  Future<bool> patchProfile(TrainerProfile tp) async {

    String authToken = await userService.getAuthIdToken();
    String UID = await userService.getUID();


    print(authToken);
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      'Authorization': authToken
    };
    final response = await http.patch(
        baseUrl+"/api/trainers/"+UID,
        headers: requestHeaders,
        body: jsonEncode(tp.toJson())
    ).catchError((e){
      print(e);
      return false;
    });

    print(response.body.toString());


    trainerProfile = tp ;


    if(tp.images.length > 10 ){
      profileImages =  tp.images.split("+#+#+");
    }
    else{
      profileImages.clear();
    }

    if(trainerProfile.socialMedia.length > 10){
      socialMedia = trainerProfile.socialMedia.split("+#+#+");
    }
    else{
      socialMedia.clear();
    }
    return true;
  }

}


class TrainerProfile {
  String name;
  String yearsOfExperience;
  String preferences;
  String expertise;
  String bio;
  String education;
  String certifications;
  String languages;
  String medicalConditionExperience;
  String trainingLocation;
  String trainingLocationGeo;
  String timings;
  String phone;
  String email;
  String images;
  String dOB;
  String gender;
  String identityProof;
  String addressProof;
  String socialMedia;
  String masters;
  String cprAedFa;
  String longitude;
  String latitude;

  TrainerProfile(
      {this.name,
        this.yearsOfExperience,
        this.preferences,
        this.expertise,
        this.bio,
        this.education,
        this.certifications,
        this.languages,
        this.medicalConditionExperience,
        this.trainingLocation,
        this.trainingLocationGeo,
        this.timings,
        this.phone,
        this.email,
        this.images,
        this.dOB,
        this.gender,
        this.identityProof,
        this.addressProof,
        this.socialMedia,
        this.masters,
        this.cprAedFa,
        this.longitude,
        this.latitude
      });

  TrainerProfile.fromJson(Map<String, dynamic> json) {
    name = json['Name'] ?? "";
    yearsOfExperience = json['Years of Experience']?? "";
    preferences = json['Preferences']?? "";
    expertise = json['Expertise']?? "";
    bio = json['Bio']?? "";
    education = json['Education']?? "";
    certifications = json['Certifications']?? "";
    languages = json['Languages']?? "";
    medicalConditionExperience = json['Medical Condition Experience']?? "";
    trainingLocation = json['Training Location']?? "";
    trainingLocationGeo = json['Training Location Geo']?? "";
    timings = json['Timings']?? "";
    phone = json['Phone']?? "";
    email = json['Email']?? "";
    images = json['Images'] ?? "";   //.cast<String>()
    dOB = json['DOB']?? "";
    gender = json['Gender']?? "";
    identityProof = json['Identity Proof']?? "";
    addressProof = json['Address Proof']?? "";
    socialMedia = json['socialMedia'] ?? "";
    masters = json["masters"] ?? "";
    cprAedFa = json["cprAedFa"] ?? "";
    longitude = json["longitude"] ?? "";
    latitude = json["latitude"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Years of Experience'] = this.yearsOfExperience;
    data['Preferences'] = this.preferences;
    data['Expertise'] = this.expertise;
    data['Bio'] = this.bio;
    data['Education'] = this.education;
    data['Certifications'] = this.certifications;
    data['Languages'] = this.languages;
    data['Medical Condition Experience'] = this.medicalConditionExperience;
    data['Training Location'] = this.trainingLocation;
    data['Training Location Geo'] = this.trainingLocationGeo;
    data['Timings'] = this.timings;
    data['Phone'] = this.phone;
    data['Email'] = this.email;
    data['Images'] = this.images;
    data['DOB'] = this.dOB;
    data['Gender'] = this.gender;
    data['Identity Proof'] = this.identityProof;
    data['Address Proof'] = this.addressProof;
    data['socialMedia'] = this.socialMedia;
    data["cprAedFa"] = this.cprAedFa;
    data["masters"] = this.masters;
    data["longitude"] = this.longitude;
    data["latitude"] = this.latitude;
    return data;
  }
}