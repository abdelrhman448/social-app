


class UserModel{
  String uid;
  String name;
  String phone;
  String email;
  String image;


  UserModel(
  {
    this.name,
    this.uid,
    this.email,
    this.phone,
    this.image='https://i.stack.imgur.com/l60Hf.png',

 }
      );

  UserModel.fromMap(Map<String,dynamic>json){
    uid=json['uId'];
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    image=json['image']!=null? json['image']:'https://i.stack.imgur.com/l60Hf.png';

  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> json={};
    json.addAll({
      'uId':uid,
      'name':name,
      'phone':phone,
      'email':email,
      'image':image,



    });
    return json;
  }

 }

//gfghgnnyytjnynjnr