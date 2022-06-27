import 'package:flutter/material.dart';
import 'package:survey/state_providers/provider_data.dart';
import 'package:survey/screens/instructions_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import'package:provider/provider.dart';
import 'package:survey/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=>ProviderData())],
      child: ScreenUtilInit(builder: (context,Widget? myWidget)=>MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
        designSize: const Size(360, 804),
      ),
    );
  }
}

