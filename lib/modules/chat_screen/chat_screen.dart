import 'package:conditional_builder/conditional_builder.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chat_screen/cubit/cubit.dart';
import 'package:socialapp/modules/chat_screen/cubit/cubit_states.dart';
import 'package:socialapp/shared/constant/constants.dart';

class ChatScreen extends StatelessWidget{
  UserModel userModel;
  ChatScreen({@required this.userModel});
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (context)=>ChatCubit()..getMessages(userModel: userModel),
     child: BlocConsumer<ChatCubit,ChatStates>(
       listener: (context,state){

       },
       builder: (context,state){
         return  Scaffold(
           appBar: AppBar(
             title: Row(
               children: [
                 CircleAvatar(
                   radius: 20,
                   backgroundImage: NetworkImage(userModel.image),
                 ),
                 SizedBox(width: 16,),
                 Text(userModel.name),

               ],
             ),
           ),
           body: Column(
               children: [
                 Expanded(
                   child: ConditionalBuilder(
                     condition: ChatCubit.myobj(context).messages.length>0,
                     builder:(context)=> ListView.separated(
                       separatorBuilder: (context,index)=>SizedBox(height: 16,),
                       itemCount: ChatCubit.myobj(context).messages.length,
                       itemBuilder: (context,index){
                         MessageModel model=ChatCubit.myobj(context).messages[index];
                         if(model.senderUid==user.uid)
                           return MyMessage(messageModel: model);


                           return UserMessage(messageModel: model);

                       },
                     ),
                     fallback: (context)=>Center(child: CircularProgressIndicator()),

                   ),
                 ),
                 Row(
                     children: [
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextField(
                             controller: ChatCubit.myobj(context).chatText,
                             keyboardType: TextInputType.multiline,
                             maxLines: 5,
                             minLines: 1,
                             decoration: InputDecoration(
                               hintText: 'type aText...',

                               hintStyle: TextStyle(color: Colors.grey),

                               filled: true,
                               fillColor: Colors.grey.shade100,
                               contentPadding: EdgeInsets.all(14),

                               isCollapsed:true ,

                               border:  OutlineInputBorder(

                                   borderRadius: BorderRadius.circular(20),
                                   borderSide: BorderSide(
                                       color: Colors.grey.shade100
                                   )
                               ),
                             ),
                           ),
                         ),
                       ),
                       FloatingActionButton(
                         child: Icon(
                           Icons.send,
                         ),
                         onPressed: (){
                           ChatCubit.myobj(context).sendMessage(userModel: this.userModel);



                         },
                       ),

                     ]),
               ]
           ),


         );
       },

     ),
   );
  }


}
class MyMessage extends StatelessWidget{
  MessageModel messageModel;
  MyMessage({
    @required this.messageModel,
});
  @override
  Widget build(BuildContext context) {
   return Row(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Padding(
         padding: const EdgeInsets.all(16),
         child: Container(

           decoration: BoxDecoration(
             color: Colors.grey.shade300,
             borderRadius: BorderRadius.only(
               bottomLeft: Radius.circular(30),
               topRight: Radius.circular(30),
               bottomRight: Radius.circular(30),

             ),
           ),

           child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
             child: Text(
              messageModel.text ,
               style: TextStyle(
                 fontSize:16,
                 fontWeight: FontWeight.w500,
               ),
             ),

           ),
         ),

       ),
     ],
   );
  }

}

class UserMessage extends StatelessWidget{
  MessageModel messageModel;
  UserMessage({
  @required this.messageModel,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16,right: 16,left: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),

                ),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                child: Text(
                  messageModel.text,
                  style: TextStyle(
                    fontSize:16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),

              ),
            ),

          ),
        ],
      ),
    );
  }

}

