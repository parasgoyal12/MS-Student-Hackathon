import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:treatment_checkup_app/services/personalTrainer/profile.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ProfileEdit extends StatesRebuilder{

  static UserTypeService userService = UserTypeService();
  List<String> profileImages = [];
  List<String> socialMediaLinks = [];

  TrainerProfile profile ;

  TrainerProfileService tps = TrainerProfileService();


  bool isLoading = false ;

  ProfileEdit(TrainerProfile tp){
    profile = tp;
      if(profile.images.length > 10 ){
         profileImages =  profile.images.split("+#+#+");
    }
    if(profile.socialMedia.length > 10){
      socialMediaLinks = profile.socialMedia.split("+#+#+");
    }

    print(profileImages.length);

  }


  Future<bool> saveProfile() async {

    setIsLoading(true);

    if(profileImages.length==0) profile.images = "";
    else{
      profile.images  =  profileImages.join("+#+#+");
    }


    bool result = await tps.patchProfile(profile);


    setIsLoading(false);

    if(result = true){
      return result;
    }

    return false;

  }


  Future<void> addUploadImage() async {

    setIsLoading(true);

    String authToken = await userService.getAuthIdToken();
    String UID = await userService.getUID();

    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference reference = FirebaseStorage.instance.ref().child(UID+"/ProfileImages/Trainer/${basename(image.path)}");
    StorageUploadTask uploadTask = reference.putFile(image);
    await uploadTask.onComplete;
    await reference.getDownloadURL().then((fileUrl){
      profileImages.add(fileUrl);
      print(fileUrl);
      rebuildStates();
    });

    setIsLoading(false);

    print("eof");

  }


  Future<void> addUploadIdentityProof() async {

    setIsLoading(true);

    String authToken = await userService.getAuthIdToken();
    String UID = await userService.getUID();

    File file = await FilePicker.getFile();
    StorageReference reference = FirebaseStorage.instance.ref().child(UID+"/IdentityProof/Trainer/${basename(file.path)}");
    StorageUploadTask uploadTask = reference.putFile(file);
    await uploadTask.onComplete;
    await reference.getDownloadURL().then((fileUrl){
      profile.identityProof = basename(file.path).toString() + "+#+#+" + fileUrl;
      print(fileUrl);
    });

    setIsLoading(false);

    print("eof");

  }
  Future<void> addUploadAddressProof() async {

    setIsLoading(true);

    String authToken = await userService.getAuthIdToken();
    String UID = await userService.getUID();

    File file = await FilePicker.getFile();
    StorageReference reference = FirebaseStorage.instance.ref().child(UID+"/AddressProof/Trainer/${basename(file.path)}");
    StorageUploadTask uploadTask = reference.putFile(file);
    await uploadTask.onComplete;
    await reference.getDownloadURL().then((fileUrl){
      profile.addressProof = basename(file.path).toString() + "+#+#+" + fileUrl;
      print(fileUrl);
    });

    setIsLoading(false);

    print("eof");

  }
  Future<void> addUploadMastersDocument() async {

    setIsLoading(true);

    String authToken = await userService.getAuthIdToken();
    String UID = await userService.getUID();

    File file = await FilePicker.getFile();
    StorageReference reference = FirebaseStorage.instance.ref().child(UID+"/MastersCertifion/Trainer/${basename(file.path)}");
    StorageUploadTask uploadTask = reference.putFile(file);
    await uploadTask.onComplete;
    await reference.getDownloadURL().then((fileUrl){
      profile.addressProof = basename(file.path).toString() + "+#+#+" + fileUrl;
      print(fileUrl);
    });

    setIsLoading(false);

    print("eof");

  }
  Future<void> addUploadCprAedFaDocument() async {

    setIsLoading(true);

    String authToken = await userService.getAuthIdToken();
    String UID = await userService.getUID();

    File file = await FilePicker.getFile();
    StorageReference reference = FirebaseStorage.instance.ref().child(UID+"/CprAedFaCertifion/Trainer/${basename(file.path)}");
    StorageUploadTask uploadTask = reference.putFile(file);
    await uploadTask.onComplete;
    await reference.getDownloadURL().then((fileUrl){
      profile.addressProof = basename(file.path).toString() + "+#+#+" + fileUrl;
      print(fileUrl);
    });

    setIsLoading(false);

    print("eof");

  }

  void handleSelectLocation(LocationResult lr){
    profile.trainingLocationGeo = lr.latLng.latitude.toString() + " " + lr.latLng.longitude.toString();
    profile.latitude = lr.latLng.latitude.toString();
    profile.longitude = lr.latLng.longitude.toString();
    if(profile.trainingLocation.length==0 && lr.address!=null){
      profile.trainingLocation = lr.address;
    }
    setIsLoading(false);
    rebuildStates();
  }
  void setIsLoading(bool val){
    isLoading = val;
    rebuildStates();
  }

}