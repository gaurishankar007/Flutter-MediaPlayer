import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:music_app/api/http/login_http.dart';
import 'package:music_app/api/log_status.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String username = "", password = "";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) {
                      username = value!;
                    },
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: "Username or Email is required!"),
                    ]),
                    decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Enter your username or email.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: Key("PasswordLogin"),
                    onSaved: (value) {
                      password = value!.trim();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Password is required!"),
                    ]),
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    key: Key("ButtonLogin"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final resData =
                            await LoginHttp().login(username, password);
                        if (resData["statusCode"] == 202) {
                          LogStatus().setToken(resData["body"]["token"]);

                          Navigator.pushNamed(context, "/home");
                        } else {
                          MotionToast.error(
                            position: MOTION_TOAST_POSITION.top,
                            animationType: ANIMATION.fromTop,
                            toastDuration: Duration(seconds: 2),
                            description: Text(resData["body"]["resM"]),
                          ).show(context);
                        }
                      }
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent[700],
                      elevation: 10,
                      shadowColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
