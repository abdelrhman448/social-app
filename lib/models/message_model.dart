class MessageModel{
  String senderUid;
  String recieverUid;
  String text;
  String time;



  MessageModel(
      {
        this.senderUid,
        this.recieverUid,
        this.text,
        this.time,


      }
      );

  MessageModel.fromMap(Map<String,dynamic>json){
    senderUid=json['senderUid'];
    recieverUid=json['recieverUid'];
    text=json['text'];
    time=json['time'];


  }
  Map<String,dynamic> toMap() => {
    'senderUid':senderUid,
    'recieverUid':recieverUid,
    'text':text,
    'time':time,
  };

}