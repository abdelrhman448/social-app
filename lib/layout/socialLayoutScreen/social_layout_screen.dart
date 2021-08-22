import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/socialCubit/cubit.dart';
import 'package:socialapp/layout/socialCubit/cubitStates.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chat_screen/chat_screen.dart';

class SocialLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      print('Message Recieved');
      print(event.data.toString());

    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print ('is opend');


    });
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(

            leadingWidth: 80,
            leading: SocialCubit.get(context).userModel!=null? Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(

                backgroundImage:
                NetworkImage(SocialCubit.get(context).userModel.image),
              ),
            ):CircularProgressIndicator(),
          ),
          body: SocialCubit.get(context).myWid[SocialCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: SocialCubit.get(context).currentIndex,
            onTap: (value){
              SocialCubit.get(context).changeIndex(value);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.supervised_user_circle,
                  ),
                  label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings'
              ),
            ],
          ),
        );
      },

    );
  }
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.


    print("Handling a background message:");
  }
}