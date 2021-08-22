



import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapp/layout/socialCubit/cubit.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/shared/constant/constants.dart';

import 'login_states.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit myobj(context)=>BlocProvider.of(context);
  UserModel userModel;

void loginUser(@required String email,@required String password){
  emit(LoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
  then((value) {
   user=FirebaseAuth.instance.currentUser;
    print(user);
    emit(LoginSucessfulState());
  }).catchError((onError){
    print(onError);
    emit(LoginErrorState());
  });
}

void googleSignIn()async{
 googleUser = await GoogleSignIn().signIn();


   GoogleSignInAuthentication googleAuth = await googleUser.authentication;


 OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
FirebaseAuth.instance.signInWithCredential(credential)
    .then((value) {
      emit(LoginSucessfulState());
}).catchError((onError){
  print(onError);
  emit(LoginErrorState());
});
}

  void faceBookSignIn(){
    FacebookAuth.instance.logOut().then((value)async {
      LoginResult result = await FacebookAuth.instance.login();

      // Create a credential from the access token
      OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);

      // Once signed in, return the UserCredential
      FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).
      then((value) {

        emit(LoginSucessfulState());
      }).catchError((onError){
        print(onError);
        emit(LoginErrorState());
      });
    });

  }





  }
