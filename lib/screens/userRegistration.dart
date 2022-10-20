import 'package:Aroma/model/user.dart';
import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/screens/thankYouRegister.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:Aroma/widgets/userTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserRegistration extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController postCodeController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: [green_dark, green_light],
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Registrierung",
                                  style: GoogleFonts.raleway(
                                      color: white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.person,
                              color: Colors.white70,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    UserTextFormField(
                      controller: firstNameController,
                      description: "Vorname*",
                      validationFailureText: "Bitte Vornamen eingeben",
                      autofill: AutofillHints.name,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    UserTextFormField(
                      controller: nameController,
                      description: "Nachname*",
                      validationFailureText: "Bitte Nachnamen eingeben",
                      autofill: AutofillHints.familyName,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    UserTextFormField(
                      controller: streetController,
                      description: "Straße, Nr.*",
                      validationFailureText: "Bitte Straße eingeben",
                      autofill: AutofillHints.streetAddressLevel1,
                      inputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PLZ*",
                          style: fontFoodItemPrice,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: grey)),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            autofillHints: [AutofillHints.postalCode],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: grey, width: 0.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: green_light),
                              ),
                            ),
                            cursorColor: green_light,
                            controller: postCodeController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Bitte PLZ eingeben';
                              }
                              if (!Utils.isValidPostCode(value)) {
                                return 'PLZ außerhalb des Lieferbereichs';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    UserTextFormField(
                      controller: cityController,
                      description: "Ort*",
                      validationFailureText: "Bitte Ort eingeben",
                      autofill: AutofillHints.addressCity,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    UserTextFormField(
                      controller: emailController,
                      description: "Email*",
                      validationFailureText: "Bitte Email eingeben",
                      autofill: AutofillHints.email,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    UserTextFormField(
                      controller: phoneController,
                      description: "Telefon (Für eventuelle Rückfragen)",
                      validationFailureText: "Bitte Telefon eingeben",
                      autofill: AutofillHints.telephoneNumber,
                      inputType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    UserTextFormField(
                      controller: passwordController,
                      description: "Passwort*",
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
                            "Jetzt Registrieren!",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          String firstName = firstNameController.text;
                          String name = nameController.text;
                          String street = streetController.text;
                          String postCode = postCodeController.text;
                          String city = cityController.text;
                          String email = emailController.text;
                          String phone = phoneController.text;
                          String password = passwordController.text;

                          User.makeRegistration(name, firstName, street,
                                  postCode, city, email, phone, password)
                              .then((value) {
                            userNotifier.setPrefs(email);

                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ThankYouRegister()),
                              ModalRoute.withName('/'),
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
