import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/socialLayoutScreen/social_layout_screen.dart';
import 'package:socialapp/shared/component/observer/observer.dart';
import 'package:socialapp/shared/constant/constants.dart';
import 'layout/socialCubit/cubit.dart';
import 'modules/login/login/cubit/login_cubit.dart';
import 'modules/login/login/login_screen.dart';
import 'modules/register/cubit/register_cubit.dart';






void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer=MyBlocObserver();

 user=FirebaseAuth.instance.currentUser;
 FirebaseMessaging.instance.getToken();
 FirebaseMessaging.instance.subscribeToTopic('travel');

  runApp(MyApp(user: user,)
  );

}

class MyApp extends StatelessWidget {
  User user;
  MyApp({this.user});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

   return MultiBlocProvider(
     providers: [
         BlocProvider(
           create: (context)=>LoginCubit(),
         ),
       BlocProvider(
         create: (context)=>RegisterCubit(),
       ),
       BlocProvider(
         create: (context)=>SocialCubit()..getUsers()..getUserData(),
       ),


     ],
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       home:user!=null ?SocialLayout():LoginScreen(),
     ),
   );
  }
}
