import 'package:Aroma/model/user.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:Aroma/widgets/userTextFormField.dart';
import 'package:flutter/material.dart';

class EditUserDialog extends StatelessWidget {
  final User user;
  const EditUserDialog({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController = new TextEditingController();
    TextEditingController firstNameController = new TextEditingController();
    TextEditingController streetController = new TextEditingController();
    TextEditingController postCodeController = new TextEditingController();
    TextEditingController cityController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController phoneController = new TextEditingController();

    firstNameController.text = user.firstName;
    nameController.text = user.name;
    streetController.text = user.street;
    postCodeController.text = user.postCode;
    cityController.text = user.city;
    emailController.text = user.email;
    phoneController.text = user.phone;

    return AlertDialog(
      title: Text('Persönliche Daten'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text('Abbrechen'),
            onPressed: () {
              // Hier passiert etwas
              Navigator.of(context).pop();
            }),
        TextButton(
          child: Text('Speichern'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              String firstName = firstNameController.text;
              String name = nameController.text;
              String street = streetController.text;
              String postCode = postCodeController.text;
              String city = cityController.text;
              String email = emailController.text;
              String phone = phoneController.text;

              User.editUserItem(
                user,
                firstName,
                name,
                street,
                postCode,
                city,
                email,
                phone,
              );

              //User.makeRegistration(name, firstName, street, postCode, city,
              //  email, phone, password)
              //.then((value) {
              //userNotifier.setPrefs(email);
              Navigator.of(context).pop();
              //});
            }
          },
        ),
      ],
    );
  }
}
