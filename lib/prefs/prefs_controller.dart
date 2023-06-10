import 'package:revew_ui_app/screen/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { id, loggedIn, email, fullName, token, gender }

class SharedPrefController {
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save(Student student) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    await _sharedPreferences.setInt(PrefKeys.id.name, student.id);
    await _sharedPreferences.setString(
        PrefKeys.fullName.name, student.fullName);
    await _sharedPreferences.setString(PrefKeys.email.name, student.email);
    await _sharedPreferences.setString(PrefKeys.gender.name, student.gender);
    await _sharedPreferences.setString(
        PrefKeys.token.name, "Bearer ${student.token}");
  }

  // هاد بجيب بيانات على نوع محدد
  // bool get loggedIn => _sharedPreferences.getBool("isLo") ?? false;

  // هاد اختصار حيث  حسب القيمة يأتي النوع

  T? getValue<T>(PrefKeys key) {
    if (_sharedPreferences.containsKey(key.name)) {
      return _sharedPreferences.get(key.name) as T;
    }
    return null;
  }

  Future<bool> deleteValueFor(String key) async {
    return _sharedPreferences.containsKey(key)
        ? await _sharedPreferences.remove(key)
        : false;
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
