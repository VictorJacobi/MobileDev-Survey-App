import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100.h),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.clear),
                  Text('Question'),
                ],
              ),
              Text('Put a Progress Bar here     percentage%'),//todo: when pub.dev is back put a progress indicator here
              Text('The Question'),

            ],
          ),
        ),
      ),
    );
  }
}
