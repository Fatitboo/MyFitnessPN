import 'package:flutter/cupertino.dart';

import 'error_type.dart';

class Validator{
  static Map<String, Val> ValidateForm(Map<String, Map<String, String>> requires, Map<String, TextEditingController> vlsForm) {
    Map<String, Val> results = {};
    requires.forEach((item, requiresOfItem) {
      Val val = Val(false, "");
      outer_loop:
      for(int i = 0; i < requiresOfItem.length; i++){
        String key = requiresOfItem.keys.elementAt(i);
        String value = requiresOfItem.values.elementAt(i);
        switch(key){
          case ERROR_TYPE.require:
            if(vlsForm[item]!.text.toString().trim().isEmpty){
              val = Val(true, value);
              break outer_loop;
            }
            break;
          case ERROR_TYPE.number:
            if(!isNumeric(vlsForm[item]!.text.toString().trim())){
              val = Val(true, value);
              break outer_loop;
            }
            break;
          case ERROR_TYPE.optionalAndNumber:
            if(vlsForm[item]!.text.toString().trim().isEmpty){
              val = Val(false, "");
              break outer_loop;
            }
            if(!isNumeric(vlsForm[item]!.text.toString().trim())){
              val = Val(true, value);
              break outer_loop;
            }
            break;
        }
      }
      results[item] = val;
    });
    return results;
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}

class Val {
  late bool isError;
  late String message;
  Val(bool a, String b){
    isError = a;
    message = b;
  }
}


