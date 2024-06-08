import 'package:assignment/components/Button.dart';
import 'package:assignment/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const  Text("Homepage"),
          backgroundColor: Color.fromRGBO(255, 180, 4, 1.0),
          centerTitle: true,
          leading: IconButton(
            color: Colors.black,
            splashColor: Colors.grey[600],
            iconSize: 25,
            onPressed: ()async {
              await FirebaseAuth.instance.signOut();
               Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const signIn())));
            },
            icon: Icon(Icons.logout),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                buttonText: "Logout",
                buttonFunction: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const signIn())));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
