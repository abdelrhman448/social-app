

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/layout/socialCubit/cubit.dart';
import 'package:socialapp/layout/socialLayoutScreen/social_layout_screen.dart';

import 'package:socialapp/modules/register/shop_register.dart';
import 'package:socialapp/modules/socialScreens/home_screen.dart';
import 'package:socialapp/shared/component/default_button.dart';
import 'package:socialapp/shared/component/default_form_field.dart';


import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget
{
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var formIcon = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<LoginCubit,LoginStates>(
     listener: (context,state){
       if(state is LoginSucessfulState){
      SocialCubit.get(context).currentIndex=0;
      SocialCubit.get(context).getUserData();
      SocialCubit.get(context).getUsers();


         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
             builder: (context)=>SocialLayout(),
           ),
             (route)=>false,
         );

       }
       if(state is LoginErrorState){
         showDialog(
           context: context,
           builder: (context){
             return AlertDialog(
               actions: [
                 FlatButton(

                   child: Text('Ok'),
                   onPressed: (){
                     Navigator.pop(context);
                   },

                 ),
               ],
               content: Text('this emial address or password not valid'),
             );
           }
         );
       }
     },
       builder: (context,state){
       return Scaffold(
         appBar: AppBar(),
         body: Form(
           key: formIcon,
           child: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.all(16.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:
                 [
                   Text(
                     'login'.toUpperCase(),
                     style: TextStyle(
                       fontSize: 30,
                       fontWeight: FontWeight.w900,
                       color: Colors.black,
                     ),
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Text(
                     'login now to browse our hot offers'.toUpperCase(),
                     style: TextStyle(
                       fontSize: 15,
                       fontWeight: FontWeight.w900,
                       color: Colors.grey,
                     ),
                   ),
                   SizedBox(
                     height: 40,
                   ),
                   DefaultFormField(

                     controller: emailController,
                     inputType: TextInputType.emailAddress,
                     label: 'Email Address',
                     prefix: Icon(
                       Icons.email
                     ),
                     validator: (String value){
                               if (value.isEmpty) {
                                  return 'string must not be embty';
                                }
                               else
                                return null;
                                  },


                   ),
                   SizedBox(
                     height: 20,
                   ),
                   DefaultFormField(
                     controller: passwordController,
                     inputType: TextInputType.visiblePassword,
                     label: 'password',
                     prefix: Icon(
                       Icons.lock_outline
                     ),
                     validator: (value){
                       if (value.isEmpty) {
                         return 'string must not be embty';
                       }
                       return null;
                     },

                   ),
                   SizedBox(
                     height: 20,
                   ),
                   if(state  is! LoginLoadingState)
                   DefaultButton(
                     function: (){
                       if (formIcon.currentState.validate()) {
                         LoginCubit.myobj(context).loginUser(emailController.text, passwordController.text);



                       }
                     },
                     text: 'login',
                   ),
                   if(state is LoginLoadingState)
                   Center(child: CircularProgressIndicator()),
                   SizedBox(
                     height: 20,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CircleAvatar(
                         backgroundColor: Colors.black,

                         child: GestureDetector(

                           onTap: (){
                             LoginCubit.myobj(context).googleSignIn();

                           },
                           child: Icon(
                             FontAwesomeIcons.google,
                             color: Color(0xFFEA4335),
                             size: 16,
                           ),
                         ),

                       ),
                       SizedBox(width: 15,),
                       CircleAvatar(
                         backgroundColor: Colors.black,

                         child: GestureDetector(

                           onTap: (){

                             LoginCubit.myobj(context).faceBookSignIn();
                           },
                           child: Icon(
                             FontAwesomeIcons.facebookF,
                             color: Color(0xFFEA4335),
                             size: 16,
                           ),
                         ),

                       ),
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                           'dont have an account ?'
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       TextButton(
                           onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=>Register(),
                              ),
                            );
                           },
                           child:Text('Register') ,
                       ),
                     ],
                   ),




                 ],
               ),
             ),
           ),
         ),
       );
       },
     );
  }

}