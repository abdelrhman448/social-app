


import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapp/layout/socialCubit/cubit.dart';
import 'package:socialapp/layout/socialCubit/cubitStates.dart';
import 'package:socialapp/modules/login/login/login_screen.dart';
import 'package:socialapp/shared/constant/constants.dart';

class SettingsScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(

          body: ConditionalBuilder(
            condition: SocialCubit.get(context).userModel!=null,
            builder: (context)=>Column(

              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image(

                       image:SocialCubit.get(context).imageFile!=null?FileImage(File(SocialCubit.get(context).imageFile.path)):
                           NetworkImage(SocialCubit.get(context).userModel.image),

                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,


                      ),
                      onPressed: (){
                       SocialCubit.get(context).imagePick();
                      },
                    ),
                  ],
                ),

                Text('NAME : ${SocialCubit.get(context).userModel.name} \n'
                    'email : ${SocialCubit.get(context).userModel.email}\n'
                    'phone : ${SocialCubit.get(context).userModel.phone}\n'
                ),
                SizedBox(height: 20,),
                Center(child: TextButton(

                  child: Text('LogOut',),
                  onPressed: (){

                    FirebaseAuth.instance.signOut().then((value) {


                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>LoginScreen(),
                        ),
                            (route)=>false,
                      );
                    });

                    GoogleSignIn().signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>LoginScreen(),
                        ),

                            (route)=>false,
                      );

                    });
                  },
                )),
              ],
            ),
            fallback: (context)=> Center(child: TextButton(

              child: Text('LogOut',),
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value) {

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>LoginScreen(),
                    ),
                        (route)=>false,
                  );
                });

                GoogleSignIn().signOut().then((value) => {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>LoginScreen(),
                    ),

                        (route)=>false,
                  ),

                });
              },
            )),
          ),
        );
      },

    );
  }

}