import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/register/cubit/register_state.dart';


 class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit getMyObj(context)=>BlocProvider.of(context);

  TextEditingController userNameController=TextEditingController();
  TextEditingController EmailAddressController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  UserModel userModel;

  void userRegister(@required String email,@required String password){
     emit(RegitserLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
       .then((value) {

      setUserData(uid: value.user.uid);


       
        emit(RegitserSucessfulState());
   }).catchError((onError){
    print(onError);
    emit(RegitserErrorState());
   });

  }

void setUserData({@required String uid}){
    userModel=UserModel(
      email: EmailAddressController.text,
      name: userNameController.text,
      phone: phoneController.text,
      uid: uid,

    );
   FirebaseFirestore.instance.
  collection('users').
  doc(uid).
  set(userModel.toMap()).then((value) {
   emit(SetUserDataSucessfulState());
   }).catchError((onError){
   emit(SetUserDataErrorState());
   });
}

}