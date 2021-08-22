import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chat_screen/cubit/cubit_states.dart';
import 'package:socialapp/shared/constant/constants.dart';

class ChatCubit extends Cubit<ChatStates> {
  TextEditingController chatText = TextEditingController();
  List<MessageModel> messages = [];

  ChatCubit() : super(initialChatState());

  static ChatCubit myobj(context) => BlocProvider.of(context);

  void sendMessage({
    @required UserModel userModel,
  }) {
    emit(loadingChatState());

    MessageModel messageModel = MessageModel(
      senderUid: user.uid,
      recieverUid: userModel.uid,
      text: chatText.text,
      time: DateTime.now().toString(),
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      saveMessage(
          userModel: userModel,
          messageModel: messageModel,
          messageId: value.id);
      chatText.clear();

      emit(successChatState());
    }).catchError((onError) {
      emit(errorChatState());
    });
  }

  void saveMessage({
    @required UserModel userModel,
    @required MessageModel messageModel,
    @required String messageId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(user.uid)
        .collection('messages')
        .doc(messageId)
        .set(messageModel.toMap())
        .then((value) {
      emit(successChatState());
    }).catchError((onError) {
      emit(errorChatState());
    });
  }

  void getMessages({@required UserModel userModel}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        print(element.data());

        messages.add(MessageModel.fromMap(element.data()));
        print((MessageModel.fromMap(element.data())).text);
      });
      emit(GetsuccessChatState());
    });
  }
}
