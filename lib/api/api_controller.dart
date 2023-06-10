import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:revew_ui_app/api/api_setting.dart';
import 'package:revew_ui_app/prefs/prefs_controller.dart';
import 'package:revew_ui_app/screen/model/student.dart';
import 'package:revew_ui_app/screen/model/users.dart';

class ApiController {
  Future<List<Users>> getUsers() async {
    Uri uri = Uri.parse(ApiSetting.users);
    var response = await http
        .get(uri, headers: {HttpHeaders.acceptHeader: "apliction/json"});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var dataJsonArray = jsonResponse['data'] as List;
      return dataJsonArray
          .map((json) => Users.fromJson(json))
          .toList();
    }

    return [];
  }

  Future<bool> login(String email, String password) async {
    Uri uri = Uri.parse(ApiSetting.login);
    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Student student = Student.fromJson(jsonResponse['object']);
      await SharedPrefController().save(student);

      return true;
    }
    return false;
  }

  Future<bool> logout() async {
    Uri uri = Uri.parse(ApiSetting.logout);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          SharedPrefController().getValue<String>(PrefKeys.token)!,
    });
    print(response.statusCode);
    if(response.statusCode == 200 ||  response.statusCode == 401){
      print(response.statusCode);
      SharedPrefController().clear();
      return true;
    }
    print(response.statusCode);
    return false;
  }
}
