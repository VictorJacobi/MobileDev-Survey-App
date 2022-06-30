import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({Key? key,this.question,this.selectedAnswer,}) : super(key: key);
  final String? question;
  final String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      width: MediaQuery.of(context).size.width-16.w,
      child: Padding(
        padding: EdgeInsets.only(top: 35.h,bottom: 35.h,left: 5.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$question'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h ),
              child: Text('response: $selectedAnswer'),
            ),
          ],
        ),
      ),
    );
  }
}
