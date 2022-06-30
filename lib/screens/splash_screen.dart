import 'package:flutter/material.dart';
import 'package:survey/screens/instructions_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InstructionScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/surveyLOGO.png'),
      ),
    );
  }
}
