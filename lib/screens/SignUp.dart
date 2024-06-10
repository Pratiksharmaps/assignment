
import 'package:assignment/components/Button.dart';
import 'package:assignment/components/DefField.dart';
import 'package:assignment/components/colors.dart';
import 'package:assignment/screens/signin.dart';
import 'package:assignment/screens/task_screen.dart';
import 'package:assignment/utils/progress_dialog.dart';
import 'package:assignment/utils/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _NameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _showPassword = true;
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _registerUrl() async {
    showProgressDialog(context, 'Creating account, please wait...');
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential.user != null) {
        hideProgressDialog(context);
        Snackbars.success(context, 'Registered Successfully');
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const  TaskScreen())));
      } else {
        hideProgressDialog(context);
        Snackbars.success(context, 'Registeration failed');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email is already registered';
          break;
        case 'weak-password':
          errorMessage = 'Entered password is too weak';
          break;
        default:
          errorMessage = 'An unknown error occurred';
          break;
      }
      hideProgressDialog(context);
      Snackbars.error(context, errorMessage);
    } catch (e) {
      hideProgressDialog(context);
      Snackbars.error(context, 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Column(
                  children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Create Account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Please Enter your Information",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage("assets/icons/signup.png"),
                    height: 150,
                    width: 280,
                    fit: BoxFit.contain,
                  ),
                ]),
                Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(children: [
                      DefField(
                                              controller: _NameController,
                                              hint: "Enter your Name",
                                              obsecure: false,
                                              lable: " Name",
                                              inputtype: TextInputType.name,
                                              validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter First name';
                      } else if (!value
                          .contains(RegExp(r'^[a-zA-Z\- ]+$'))) {
                        return 'Invalid First name';
                      }
                      return null;
                                              },
                                            ),
                      const SizedBox(
                        height: 12,
                      ),
                      // -----------------------Email Field------------------------------------------
                      DefField(
                        controller: _emailController,
                        hint: "Enter your email",
                        obsecure: false,
                        lable: "Email",
                        inputtype: TextInputType.emailAddress,
                        iconName: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field cannot be empty';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          } else if (!value.contains(
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // -------------------Password field---------------------------
                      DefField(
                        controller: _passwordController,
                        hint: "Enter your password",
                        obsecure: _showPassword,
                        lable: "Password",
                        inputtype: TextInputType.visiblePassword,
                        iconName: _showPassword == false
                            ? Icons.visibility
                            : Icons.visibility_off,
                        iconFunction: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          } else if (!value.contains(RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$'))) {
                            return 'Requires atleast 8 characters,\nAtleast one uppercase letter [A-z],\nAtleast one lowercase letter [a-z],\nAtleast one number [0-9].';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // --------------------confirm password------------------------------------------
                      DefField(
                        controller: _confirmpasswordController,
                        lable: 'Confirm Password',
                        hint: 're-enter password',
                        obsecure: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please re-enter  password';
                          } else if (value != _passwordController.text) {
                            return 'Confirm password does not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      
                    ])),
                const SizedBox(
                  height: 15,
                ),
                // --------------------------------------Submit-BUTTON-----------------------------------------
                Button(
                    buttonText: "Sign up",
                    buttonFunction: () {
                      if (_formKey.currentState!.validate()) {
                        _registerUrl();
                        _formKey.currentState!.reset();
                      }
                    }),
                // -------------------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 38,
                    ),
                    const Text(
                      "Already registerd?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 133, 133, 133),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const signIn()))),
                      child: const Text("Login",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
