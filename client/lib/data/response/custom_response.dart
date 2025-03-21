import 'package:do_an_2/model/login_response.dart';

class CustomResponse{
  String? message;
  LoginResponse? user;


  CustomResponse({this.message, this.user});

  factory CustomResponse.fromJson(Map<String, dynamic> json) => CustomResponse(
    message: json['message'],
    user: json['user'] != null ? new LoginResponse.fromJson(json['user']) : null
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

