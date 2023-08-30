class Student {
  late int id;
  late String fullName;
  late String email;
  late String gender;
  String? verificationCode;
  String? fcmToken;
  late String token;
  late String refreshToken;
  late bool? isActive;

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    gender = json['gender'];
    verificationCode = json['verification_code'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    refreshToken = json['refresh_token'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['gender'] = gender;
    data['verification_code'] = verificationCode;
    data['fcm_token'] = fcmToken;
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    data['is_active'] = isActive;
    return data;
  }
}
