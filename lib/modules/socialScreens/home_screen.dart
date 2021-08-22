

import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socialapp/layout/socialCubit/cubit.dart';
import 'package:socialapp/layout/socialCubit/cubitStates.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chat_screen/chat_screen.dart';

class Home extends StatelessWidget{
  UserModel users;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).myUsers.length>0,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>myWid(SocialCubit.get(context).myUsers[index],context),
            separatorBuilder:(context,index)=> Container(
              width: double.infinity,
              color: Colors.grey,
              height: 1,
            ),
            itemCount: SocialCubit.get(context).myUsers.length,


          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      },

    );

  }
  Widget myWid(UserModel userModel,context){
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(userModel: userModel,)));
    },

          child: Row(


            children: [
              CircleAvatar(

                radius: 60,


                backgroundImage:
            NetworkImage(userModel.image),
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Text(
                    userModel.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),


            ],
          ),
        ),
      );

  }
}