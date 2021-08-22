import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget{
  TextEditingController controller;
  TextInputType inputType;
  String label;
  Icon prefix;
  FormFieldValidator<String> validator;
  ValueChanged<String> onChanged;
  ValueChanged<String> onSubmitted;

  DefaultFormField({
    @required this.controller,
    @required this.inputType,
    @required this.label,
    @required this.prefix,
   this.validator,
    this.onChanged,
    this.onSubmitted,

});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      keyboardType:inputType ,
      decoration: InputDecoration(

        border: OutlineInputBorder(),

        labelText: label,
        prefixIcon:prefix,

      ),
      controller: controller,
    );
  }

}