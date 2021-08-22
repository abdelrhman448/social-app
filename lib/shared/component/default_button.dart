import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget{
  double width;
  Function function;
  String text;
  DefaultButton({
    this.width=double.infinity,
   @required this.function,
  @required this.text,
});
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: 40,
      color: Colors.blue,
      child: MaterialButton(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: function,
      ),
    );
  }

}