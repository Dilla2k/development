import 'package:awesome_dialog/awesome_dialog.dart';
import '../Items/background_image.dart';
import '../Model/user.dart';
import '../Utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/common.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;
  bool check = false;

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              child: loginBody(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  loginBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            loginFields(context),
          ],
        ),
      );

  loginFields(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 30.0,
            ),
            child: TextField(
              maxLines: 1,
              controller: userController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Geben Sie ihren Benutzernamen ein",
                labelText: "Benutzername",
              ),
            ),
          ),
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 30.0,
            ),
            child: TextField(
              maxLines: 1,
              obscureText: _isObscure,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Geben Sie ihr Passwort ein",
                labelText: "Passwort",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
              onSubmitted: (value) => _onIconTap(),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 30.0,
            ),
            width: 250,
            child: AnimatedButton(
              text: "Login",
              color: primaryColor.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              pressEvent: () {
                _onIconTap();
              },
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
        ],
      );

  Future<bool> _checkuserAndPin(String userName, String password) async {
    try {
      return await User.checkUserAcc(userName, password);
    } catch (e) {
      return false;
    }
  }

  _onIconTap() async {
    try {
      check =
          await _checkuserAndPin(userController.text, passwordController.text);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('SSO', userController.text);
    } catch (e) {
      check = false;
    }
    if (check) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      Fluttertoast.showToast(
          msg: "Falsche Anmeldedaten",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          webBgColor: "#003874",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
