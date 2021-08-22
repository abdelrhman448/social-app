import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/login/login/login_screen.dart';
import 'package:socialapp/shared/component/default_button.dart';
import 'package:socialapp/shared/component/default_form_field.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';


class Register extends StatelessWidget{

 var myKay=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context,state){
        if(state is RegitserSucessfulState){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(

                content: Text('your Register successed'),
                actions: [
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context){
                           return LoginScreen();
                         }
                       ),
                     );
                    },
                  ),
                ],
              );
            }
          );

        }
        if(state is RegitserNotSucessfulState){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                content: Text('This Email Address or Password or phone is invalid'),
                actions: [
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],

              );
            }

          );
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: Icon(
                Icons.arrow_back_ios_outlined
            ),

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: myKay,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Register now to browse our hot offers',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10,),
                    DefaultFormField(
                      prefix: Icon(
                          Icons.person
                      ),
                      label: 'User Name',
                      inputType: TextInputType.text ,
                      controller:RegisterCubit.getMyObj(context).userNameController,
                      validator: (value){
                        if(value.isEmpty){
                          return "please enter user name";
                        }
                        return null;
                      },


                    ),
                    SizedBox(height: 20,),
                    DefaultFormField(
                      prefix: Icon(
                          Icons.email_outlined
                      ),
                      label: 'Email Address',
                      inputType: TextInputType.emailAddress ,
                      controller: RegisterCubit.getMyObj(context).EmailAddressController,
                      validator: (value){
                        if(value.isEmpty){
                          return "please enter Email Address";
                        }
                        return null;
                      },


                    ),
                    SizedBox(height: 20,),
                    DefaultFormField(
                      prefix: Icon(
                          Icons.lock
                      ),
                      label: 'password',
                      inputType: TextInputType.visiblePassword ,
                      controller: RegisterCubit.getMyObj(context).passwordController,
                      validator: (value){
                        if(value.isEmpty){
                          return "please enter password";
                        }
                        return null;
                      },


                    ),
                    SizedBox(height: 20,),
                    DefaultFormField(
                      prefix: Icon(
                          Icons.phone
                      ),
                      label: 'Phone',
                      inputType: TextInputType.phone ,
                      controller: RegisterCubit.getMyObj(context).phoneController,
                      validator: (value){
                        if(value.isEmpty){
                          return "please enter phone number";
                        }
                        return null;
                      },


                    ),
                    SizedBox(height: 20,),
                    if(state  is! RegitserLoadingState)
                      DefaultButton(
                        text: 'Register',
                        function: (){
                          if(myKay.currentState.validate()){
                            RegisterCubit.getMyObj(context).userRegister( RegisterCubit.getMyObj(context).EmailAddressController.text, RegisterCubit.getMyObj(context).passwordController.text, );
                          }
                        },
                      ),
                    if(state  is RegitserLoadingState)
                      Center(child: CircularProgressIndicator()),
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