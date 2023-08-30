import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../api/api_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  bool _eay = true;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: const Text(
                "Welcome back",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: const Text(
                "Enter email & password",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.black45),
              ).animate().slide(curve: Curves.bounceIn).fade(duration: 500.ms),
            ),
            const SizedBox(
              height: 20,
            ),
            Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.red),
                maxLines: null,
                minLines: null,
                expands: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  constraints:
                      BoxConstraints(maxHeight: _emailError == null ? 50 : 75),
                  labelText: "email adrees ",
                  errorText: _emailError,
                  prefixIcon: const Icon(Icons.email),
                  suffixIcon: const Icon(Icons.send),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red.shade200)),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red.shade800),
                  ),
                  // filled: true,
                  // border:OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(5),
                  //   borderSide: BorderSide(color: Colors.red)

                  // ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black45)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: TextField(
                  obscureText: _eay,
                  controller: _passwordTextController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                        maxHeight: _passwordError == null ? 50 : 75),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: const Icon(Icons.lock),
                    errorText: _passwordError,
                    errorMaxLines: 1,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            _eay = !_eay;
                          },
                        );
                      },
                      icon:
                          Icon(_eay ? Icons.visibility_off : Icons.visibility),
                    ),
                    labelText: "password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black45),
                    ),
                    focusColor: Colors.red,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red.shade200)),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red.shade800),
                    ),
                    // labelStyle: TextStyle(color: Colors.redAccent),
                  ),
                ).animate()),
            const SizedBox(
              height: 20,
            ),
            Animate(
              effects: const [ScaleEffect(), FadeEffect()],
              child: ElevatedButton(
                onPressed: () => _performLogin(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _performLogin() async {
    if (_checkData()) {
      await _login();
    }
  }

  bool _checkData() {
    setState(() {
      _emailError = _emailTextController.text.isEmpty ? "inter email" : null;
      _passwordError =
          _passwordTextController.text.isEmpty ? "inter password" : null;
    });
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("inter required data"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        closeIconColor: Colors.white,
        action: SnackBarAction(
          label: "Undo",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
    return false;
  }

  Future<void> _login() async {
    bool result = await ApiController()
        .login(_emailTextController.text, _passwordTextController.text);
    if (result) {
      Navigator.pushReplacementNamed(context, '/nav_screen');
    }
  }
}
