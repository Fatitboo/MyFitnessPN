import 'dart:convert';

class LoginResponse {
  String? userId;
  String? fullName;
  String? email;
  String? token;
  String? userType;
  DateTime? dob;

  LoginResponse({this.userId, this.fullName, this.email, this.token, this.userType, this.dob});

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    if (json.isNotEmpty){
      List<dynamic> li;
      DateTime dateTime = DateTime.now();
      print(json['dob']);
      if(json['dob'] is String){
        dateTime =DateTime.parse(json['dob'].replaceFirst(' ', 'T'));
      }else{
        li = json['dob'] ??[2024, 05, 14];
        dateTime = DateTime(li.elementAt(0),li.elementAt(1),li.elementAt(2));
      }


      return LoginResponse(
        userId : json['userId'],
        fullName : json['fullName'],
        email : json['email'],
        token : json['token'],
        userType : json['userType'],
        dob: dateTime
      );
    }
    else{
      return LoginResponse(
        userId : '',
        fullName : '',
        email : '',
        token : '',
        userType : '',
        dob: DateTime(2024)
      );
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['token'] = this.token;
    data['userType'] = this.userType;
    data['dob'] = this.dob.toString();
    return data;
  }
}