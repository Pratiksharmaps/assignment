import 'package:assignment/components/Button.dart';
import 'package:assignment/components/DefField.dart';
import 'package:assignment/screens/Forget_password_screeen.dart';
import 'package:assignment/screens/HomeScreen.dart';
import 'package:assignment/screens/SignUp.dart';
import 'package:assignment/screens/task_screen.dart';
import 'package:assignment/utils/progress_dialog.dart';
import 'package:assignment/utils/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});
  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  final _auth = FirebaseAuth.instance;
//------------------------ Email and Password Login Method--------------------------
  void loginUser() async {
    showProgressDialog(context, 'Signing you in, please wait...');
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Snackbars.success(context, 'Login Successfully');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const TaskScreen()));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid Email address';
          break;
        case 'invalid-credential':
          errorMessage = 'Incorrect  Email and password';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;
        case 'user-not-found':
          errorMessage = 'The user does not exist';
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

//------------------------ Method for login with Google----------------------
  void _signINWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      // Sign in with Google
      final GoogleSignInAccount? _googleSignInAccount =
          await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        final GoogleSignInAuthentication _googleSignInAuthentication =
            await _googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleSignInAuthentication.idToken,
          accessToken: _googleSignInAuthentication.accessToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          Snackbars.success(context, 'Registered Successfully');
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const TaskScreen())));
        }
      }
    } catch (ex) {
      Snackbars.error(context, ex.toString());
    }
  }

//---------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  //-------------------Page Heading-------------------------------------
                  Text("Welcome to ",
                      style: TextStyle(
                        fontSize: 21,
                        decorationThickness: 8,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 180, 4, 1.0),
                      )),
                  Text(
                    "SPACE For Early Childhood Education",
                    style: TextStyle(
                      fontSize: 21,
                      decorationThickness: 8,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 180, 4, 1.0),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Please login to continue",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              //------------------------------------ Page Image------------------------------------
              const Image(
                image: AssetImage("assets/icons/loginImg.png"),
                height: 180,
                width: 310,
                fit: BoxFit.contain,
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 19,
                    ),

                    Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            //--------------------------------Email Field--------------------------------------------
                            DefField(
                              controller: _emailController,
                              hint: "Enter your email",
                              obsecure: false,
                              lable: "Email",
                              iconName: Icons.lock,
                              inputtype: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field cannot be empty';
                                } else if (!value.contains(RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            //----------------------------- Password field-------------------------------------------
                            DefField(
                              controller: _passwordController,
                              hint: "Enter your password",
                              obsecure: _showPassword,
                              lable: "Password",
                              iconName: _showPassword == false
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              iconFunction: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              inputtype: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            //-------------------------------------------Forget password button-------------------------------------
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const ResetScreen()))),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 8, 15, 5),
                                alignment: Alignment.topRight,
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    //----------------------- Login button-----------------------
                    Button(
                        buttonText: "Log In",
                        buttonFunction: () {
                          if (_formKey.currentState!.validate()) {
                            loginUser();
                          }
                        })
                  ],
                ),
              ),
              //-------------------------- Register screen Navigation---------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 38,
                  ),
                  const Text(
                    "Don't have an Account ?",
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
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SignUpScreen()))),
                    child: const Text("Register",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 180, 4, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
              //External providers Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Google sign-in Icon
                  IconButton(
                    color: Colors.grey,
                    onPressed: _signINWithGoogle,
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      size: 22,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
