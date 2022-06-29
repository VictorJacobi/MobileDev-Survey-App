import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:survey/constants.dart';
import 'package:survey/screens/finish_screen.dart';
import 'package:survey/screens/result_screen.dart';
import 'package:survey/state_providers/provider_data.dart';
import 'package:survey/models/tile_option.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProviderData neededQuizData = context.watch<ProviderData>();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.clear,
                        size: 30.sp,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        '${neededQuizData.myQuestion[neededQuizData.quizIndex].questionType}',
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w700,),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 41.w,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    barRadius: Radius.circular(10.r),
                    percent: neededQuizData.progress,
                    progressColor: kDesignColor,
                  ),
                  SizedBox(height: 50.h),
                  neededQuizData.myQuestion[
                  neededQuizData.quizIndex].imageDirectory!=null?Image.asset(neededQuizData.myQuestion[
                  neededQuizData.quizIndex].imageDirectory!,):const SizedBox.shrink(),
                  Text(
                    neededQuizData.myQuestion[
                    neededQuizData.quizIndex]
                        .question!,
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                  neededQuizData.myQuestion[
                  neededQuizData.quizIndex].optionType=='obj'?SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                        itemCount: neededQuizData.myQuestion[
                        neededQuizData.quizIndex]
                            .options!
                            .length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 40.h,
                            child: ListTile(
                              leading: Checkbox(
                                fillColor:neededQuizData.selectedAnswer ==
                              null?
                                    MaterialStateProperty.resolveWith(
                                        (states) {
                                  if (states
                                      .contains(MaterialState.disabled)) {
                                    return Colors.red.withOpacity(.32);
                                  }
                                  return Colors.red;
                                }):MaterialStateProperty.resolveWith(
                                        (states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return kDesignColor.withOpacity(.32);
                                      }
                                      return kDesignColor;
                                    }),
                                value: neededQuizData.objectives[index]
                                    .isSelected,
                                onChanged: (val) {
                                  for (var objective
                                      in neededQuizData.objectives) {
                                    neededQuizData.tileRemainState(objective);
                                  }
                                  neededQuizData.tileSelected(val!, index);
                                },
                              ),
                              title: Text(neededQuizData.myQuestion[
                              neededQuizData.quizIndex]
                                  .options![index]),
                            ),
                          );
                        }),
                  ):TextField(
                    autofocus: true,
                    controller: neededQuizData.controller,
                  ),
                  // Text('This is it: ${neededQuizData.controllerText}'),
                  Text('${neededQuizData.selectedResults}\n'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap: (){
                      if (neededQuizData.quizIndex< 1) {
                      } else {
                        neededQuizData.previousQuizIndex();}
                    },child: Text('Previous',style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Messina Sans',
                        color: Colors.black,
                    ))),
                    MaterialButton(
                      onPressed: () {
                        if (neededQuizData.quizIndex ==
                            neededQuizData.myQuestion
                                    .length -
                                1) {
                          if(neededQuizData.controller.text!=''||neededQuizData.selectedAnswer !=
                              null){
                            neededQuizData.endQuiz([
                              TileOption(option: 'Once in 3 months',isSelected: false),
                              TileOption(option: 'Once in 6 months',isSelected: false),
                            ]);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultScreen()));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.white,
                                content: Text('The text field has to be filled',style: TextStyle(color: Colors.black),)));
                          }

                        } else {
                          List<TileOption> option = [];
                          if(neededQuizData.myQuestion[
                          neededQuizData.quizIndex +
                              1]
                              .options==null){
                          if(neededQuizData.controller.text!=''||neededQuizData.selectedAnswer !=
                              null){
                            neededQuizData.nextQuizIndexOption([
                              TileOption(option: 'Once in 3 months',isSelected: false),
                              TileOption(option: 'Once in 6 months',isSelected: false),
                            ],);

                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.white,
                                content: Text('The text field has to be filled',style: TextStyle(color: Colors.black),)));
                          }
                          }else{
                          for (var data in neededQuizData.myQuestion[
                          neededQuizData.quizIndex +
                                      1]
                              .options!) {
                            option.add(TileOption(isSelected: false, option: data));
                          }
                          if (neededQuizData.selectedAnswer !=
                              null||neededQuizData.controller.text!='') {
                            neededQuizData.nextQuizIndexOption(option);
                          }else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Colors.white,
                                content: Text('An answer has to be selected',style: TextStyle(color: Colors.black),)));
                          }
                        }
                        }
                      },
                      color: kDesignColor,
                      height: 50,
                      minWidth: 119,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: neededQuizData.quizIndex !=
                          neededQuizData.myQuestion
                              .length -
                              1?Icon(
                        Icons.arrow_forward,
                        size: 50.sp,
                        color: Colors.white,
                      ):const Text('end',style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
