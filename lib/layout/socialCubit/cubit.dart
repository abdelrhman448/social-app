

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'as   firebase_storage;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:socialapp/layout/socialCubit/cubitStates.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/socialScreens/home_screen.dart';
import 'package:socialapp/modules/socialScreens/settings_screen.dart';
import 'package:socialapp/shared/constant/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(initialSocialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel userModel;

  int currentIndex = 0;
  List<Widget>myWid = [Home(), SettingsScreen()];
  XFile imageFile;
  List<UserModel>myUsers=[];



  void getUserData() {
    FirebaseFirestore.instance.
    collection('users').
    doc(user.uid).
    get().then((value) {
        print('my valur${value.data()}');
      userModel = UserModel.fromMap(value.data());

        print('my model${userModel.uid}');
        print('my model${userModel.name}');
        print('my model${userModel.image}');
        print('my model${userModel.phone}');

      emit(GetUserSucessSocialStates());
    }).catchError((onError) {
      print(onError);
      emit(GetUserErrorSocialStates());
    });
  }

  void getUserRealTime() {
    FirebaseFirestore.instance.
    collection('users').
    doc(user.uid).
    snapshots().listen((value) {
      userModel = UserModel.fromMap(value.data());
      print(user.uid);
      print(userModel.uid);
      emit(GetUserSucessSocialStates());
    });
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(navigationChangeIndex());
  }

  void imagePick() {
    ImagePicker _picker = ImagePicker();
    // Pick an image
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      print(value.path);
      imageFile = value;
      uploadProfileImage();
      emit(pickImageState());
    });
  }

  void uploadProfileImage() {
    emit(SocialProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(imageFile.path)
        .pathSegments
        .last}')
        .putFile(File(imageFile.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(value);
      }).catchError((error) {
        emit(SocialProfilePhotoUrlErrorState());
      });
    }).catchError((error) {
      emit(SocialProfilePhotoErrorState());
    });
  }

  void updateUserData(String imageUrl) {
    getUserData();

    userModel.image = imageUrl;

    FirebaseFirestore.instance.
    collection('users').
    doc(user.uid).
    update(userModel.toMap()).then((value) {
      imageFile=null;
      emit(uploadPhotoSucessSocialStates());
    }).catchError((onError) {
      print(onError);
      emit(uploadPhotoErrorSocialStates());
    });
  }

  void getUsers() {

    FirebaseFirestore.instance.collection('users').
    snapshots().listen((value){
      print(value.docs);
      myUsers=[];
      value.docs.forEach((element) {


        userModel=UserModel.fromMap(element.data());
        if(userModel.uid!=user.uid){
          myUsers.add(userModel);
        }
      });
    });






  }



  }

