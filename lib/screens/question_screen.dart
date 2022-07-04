import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:survey/constants.dart';
import 'package:survey/screens/result_screen.dart';
import 'package:survey/state_providers/provider_data.dart';
import 'package:survey/models/tile_option.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProviderData neededQuizData = context.watch<ProviderData>();
    void _endQuiz(){
      neededQuizData.endQuiz([
        TileOption(option: 'Once in 3 months',isSelected: false),
        TileOption(option: 'Once in 6 months',isSelected: false),
      ]);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ResultScreen()));
    }
    void _displayErrorMessage({BuildContext? context,String? error}){
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
          backgroundColor: Colors.white,
          content: Text(error!,style: const TextStyle(color: Colors.black),)));
    }
    void _nextQuizData(BuildContext context){
      List<TileOption> option = [];
      if(neededQuizData.myQuestion[
      neededQuizData.quizIndex +
          1]
          .options==null){//check to see if the next quiz has an option(here it doesn't)
        if(neededQuizData.controller.text!=''||neededQuizData.selectedAnswer !=
            null){//check to see if the text field or the selected answer is empty
          neededQuizData.nextQuizIndexOption([
            TileOption(option: 'Once in 3 months',isSelected: false),
            TileOption(option: 'Once in 6 months',isSelected: false),
          ],);

        }else{//This condition is valid if the text field is empty.
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.white,
              content: Text('The text field has to be filled',style: TextStyle(color: Colors.black),)));
        }
      }else{//Here the question type is an obj(That is, it has an option).
        for (var data in neededQuizData.myQuestion[
        neededQuizData.quizIndex +
            1]
            .options!) {//Looping through the options here to return a list of Tile Option data type created specifically for the options
          option.add(TileOption(isSelected: false, option: data));
        }
        if (neededQuizData.selectedAnswer !=
            null||neededQuizData.controller.text!='') {// checking to see if the text field or the selected answer is empty
          neededQuizData.nextQuizIndexOption(option);
        }else {//The selected option is empty
          _displayErrorMessage(context: context,error: 'An answer has to be selected');
        }
      }
    }
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
                      InkWell(
                        onTap:(){
                          neededQuizData.restartSurvey();
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.clear,
                          size: 30.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          '${neededQuizData.myQuestion[neededQuizData.quizIndex].questionType}',
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w700,),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h,bottom: 50.h),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 41.w,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      barRadius: Radius.circular(10.r),
                      percent: neededQuizData.progress,
                      progressColor: kDesignColor,
                    ),
                  ),
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
                  // Text('${neededQuizData.selectedAnswers}\n'
                  //     '${neededQuizData.selectedAnswer}\n'
                  //     '${neededQuizData.quizIndex}\n'
                  //     '${neededQuizData.myQuestion[neededQuizData.quizIndex].optionType}'),
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
                           _endQuiz();
                          }else{
                            _displayErrorMessage(context: context,error: 'The text field has to be filled');
                          }

                        } else {
                          _nextQuizData(context);
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
