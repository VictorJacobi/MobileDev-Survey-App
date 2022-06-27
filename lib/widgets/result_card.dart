import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({Key? key,this.question,this.options,this.correctAnswer,this.selectedAnswer}) : super(key: key);
  final String? question;
  final String? selectedAnswer;
  final String? correctAnswer;
  final List<String>? options;
  bool isCorrect(){
    if(selectedAnswer==correctAnswer){
      return true;
    }
    else{
      return false;
    }
  }
  List<Widget> _showOptionWidget(List options){
    List<Widget> myWidget = [];
    for(int i=0;i<options.length;i++){
      myWidget.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 100.w,child: Text('(${i+1})  ${options[i]}',)),
              options[i]==correctAnswer?const Icon(Icons.check,color: Colors.green,):const SizedBox.shrink(),
              options[i] ==selectedAnswer&&!isCorrect()?const Icon(Icons.clear,color: Colors.red,):const SizedBox.shrink(),
            ],
          )
      );
    }
    return myWidget;
  }
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
            SizedBox(height: 6.h,),
            // Text('${options}')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _showOptionWidget(options!),
            ),
            SizedBox(height: 6.h,),
          ],
        ),
      ),
    );
  }
}
