class LoginResponse {
  String? userId;
  String? fullName;
  String? email;
  String? token;
  String? userType;

  LoginResponse({this.userId, this.fullName, this.email, this.token, this.userType});

  factory LoginResponse.fromJson(Map<String, dynamic> json)=>LoginResponse(
    userId : json['userId'],
    fullName : json['fullName'],
    email : json['email'],
    token : json['token'],
    userType : json['userType'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['token'] = this.token;
    data['userType'] = this.userType;
    return data;
  }
}