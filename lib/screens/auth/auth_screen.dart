// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/screens/auth/api/auth_api.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_textField.dart';
import 'package:flutter/material.dart';

enum AuthEnum {
  signup,
  signin,
}

class Auth extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  AuthEnum _auth = AuthEnum.signup;
  final _signUpFromKey = GlobalKey<FormState>();
  final _signInFromKey = GlobalKey<FormState>();
  final AuthAPI authAPI = AuthAPI();

  bool showPasswordCreate = true;
  bool showPasswordSignIn = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void SignUpUser() {
    authAPI.SignUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void SignInUser() {
    authAPI.SignInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              tileColor: _auth == AuthEnum.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )),
              title: Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: _auth == AuthEnum.signup
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
              leading: Radio(
                value: AuthEnum.signup,
                groupValue: _auth,
                onChanged: (AuthEnum? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == AuthEnum.signup)
              Container(
                padding: EdgeInsets.all(10),
                // color: GlobalVariables.backgroundColor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: GlobalVariables.backgroundColor,
                ),
                child: Form(
                  key: _signUpFromKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        label: 'Name',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: showPasswordCreate,
                        suffixIcon: IconButton(
                          visualDensity: VisualDensity.comfortable,
                          icon: Icon(!showPasswordCreate
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye),
                          onPressed: (){
                            showPasswordCreate = !showPasswordCreate;
                            setState(() {
                              
                            });
                          }
                              
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        title: "SignUp",
                        onPressed: () {
                          if (_signUpFromKey.currentState!.validate()) {
                            SignUpUser();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ListTile(
              title: Text(
                'Sign-In',
                style: TextStyle(
                  fontWeight: _auth == AuthEnum.signin
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
              tileColor: _auth == AuthEnum.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )),
              leading: Radio(
                value: AuthEnum.signin,
                groupValue: _auth,
                onChanged: (AuthEnum? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == AuthEnum.signin)
              Container(
                padding: EdgeInsets.all(10),
                // color: GlobalVariables.backgroundColor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: GlobalVariables.backgroundColor,
                ),
                child: Form(
                  key: _signInFromKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: showPasswordSignIn,
                        suffixIcon: IconButton(
                          visualDensity: VisualDensity.comfortable,
                          icon: Icon(!showPasswordSignIn
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye),
                          onPressed: () {
                            showPasswordSignIn = !showPasswordSignIn;
                            setState(() {
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        title: "SignIn",
                        onPressed: () {
                          if (_signInFromKey.currentState!.validate()) {
                            SignInUser();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
