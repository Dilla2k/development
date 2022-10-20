import 'package:Aroma/model/user.dart';
import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/screens/user.dart';
import 'package:Aroma/screens/userRegistration.dart';
import 'package:Aroma/utils/animations.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:Aroma/widgets/userTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      backgroundColor: white,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AromaAppBar(
          sFkey: _scaffoldKey,
          hasHeader: false,
        ),
      ),
      endDrawer: Menu(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/aroma-logo.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  UserTextFormField(
                    controller: emailController,
                    description: "Email-Adresse",
                    validationFailureText: "Bitte Email eingeben",
                    autofill: AutofillHints.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  UserTextFormField(
                    controller: passwordController,
                    description: "Passwort",
                    validationFailureText: "Bitte Passwort eingeben",
                    autofill: AutofillHints.password,
                    inputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: [green_dark, green_light],
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft),
                        image: DecorationImage(
                          image: AssetImage('assets/gemuese.png'),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.03),
                              BlendMode.dstATop),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Anmelden!",
                          style: GoogleFonts.raleway(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        String email = emailController.text;

                        String password = passwordController.text;
                        User.login(email, password).then((value) {
                          if (value) {
                            userNotifier.setPrefs(email);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UserScreen()),
                              ModalRoute.withName('/'),
                            );
                          } else {
                            final snackBar = SnackBar(
                                content: Text('Falsche Zugangangsdaten'));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 20,
                      child: Center(
                        child: Text(
                          "Noch nicht angemeldet? Hier registrieren!",
                          style: GoogleFonts.raleway(
                              color: grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(createRouteScale(UserRegistration()));
                    },
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
