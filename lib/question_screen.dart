import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:survey/constants.dart';
import 'package:survey/finish_screen.dart';
import 'package:survey/provider_data.dart';
import 'package:survey/result_screen.dart';
import 'package:survey/tile_option.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        size: 30,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Question',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w700),
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
                    percent: Provider.of<ProviderData>(context, listen: true)
                        .progress,
                    progressColor: kDesignColor,
                  ),
                  SizedBox(height: 50.h),
                  Provider.of<ProviderData>(context, listen: false)
                      .myQuestion[
                  Provider.of<ProviderData>(context, listen: true)
                      .quizIndex].imageDirectory!=null?Image.asset(Provider.of<ProviderData>(context, listen: false)
                      .myQuestion[
                  Provider.of<ProviderData>(context, listen: true)
                      .quizIndex].imageDirectory!,):SizedBox.shrink(),
                  Text(
                    Provider.of<ProviderData>(context, listen: false)
                        .myQuestion[
                            Provider.of<ProviderData>(context, listen: true)
                                .quizIndex]
                        .question!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                        itemCount: Provider.of<ProviderData>(context,
                                listen: false)
                            .myQuestion[
                                Provider.of<ProviderData>(context, listen: true)
                                    .quizIndex]
                            .options!
                            .length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 40.h,
                            child: ListTile(
                              leading: Checkbox(
                                fillColor:Provider.of<ProviderData>(context,
                              listen: false)
                              .selectedAnswer ==
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
                                value: Provider.of<ProviderData>(context,
                                        listen: true)
                                    .objectives[index]
                                    .isSelected,
                                onChanged: (val) {
                                  for (var objective
                                      in Provider.of<ProviderData>(context,
                                              listen: false)
                                          .objectives) {
                                    Provider.of<ProviderData>(context,
                                            listen: false)
                                        .tileRemainState(objective);
                                  }
                                  Provider.of<ProviderData>(context,
                                          listen: false)
                                      .tileSelected(val!, index);
                                },
                              ),
                              title: Text(Provider.of<ProviderData>(context,
                                  listen: false)
                                  .myQuestion[
                              Provider.of<ProviderData>(context, listen: true)
                                  .quizIndex]
                                  .options![index]),
                            ),
                          );
                        }),
                  ),
                  // Text(
                  //     // '${Provider.of<ProviderData>(context, listen: true).selectedAnswer}\n'
                  //     // // '${Provider.of<ProviderData>(context, listen: true).objectives}\n'
                  //     '${Provider.of<ProviderData>(context, listen: true).selectedResults}\n'
                  //     // '${Provider.of<ProviderData>(context, listen: true).quizIndex}\n'
                  //     // // '${Provider.of<ProviderData>(context,
                  //     // //     listen: false)
                  //     // //     .myQuestion[
                  //     // // Provider.of<ProviderData>(context, listen: true)
                  //     // //     .quizIndex]
                  //     // //     .options}\n'
                  //     // '${Provider.of<ProviderData>(context, listen: false).answersPicked}\n'
                  // )
                  // Provider.of<ProviderData>(context,listen: true).selectedResults.isNotEmpty?Text('${Provider.of<ProviderData>(context,listen: true).selectedResults[Provider.of<ProviderData>(context,listen: true).quizIndex-1].toString()}'):SizedBox.shrink(),
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
                      if (Provider.of<ProviderData>(context, listen: false)
                          .quizIndex< 1) {
                      } else {
                        List<TileOption> option = [];
                        for (var data in Provider.of<ProviderData>(context,
                            listen: false)
                            .myQuestion[
                        Provider.of<ProviderData>(context, listen: false)
                            .quizIndex -
                            1]
                            .options!) {
                          option.add(TileOption(isSelected: false, option: data));
                        }
                      Provider.of<ProviderData>(context, listen: false).previousQuizIndex(option);}
                    },child: Text('Previous',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Messina Sans',
                        color: Colors.black,
                    ))),
                    MaterialButton(
                      onPressed: () {
                        if (Provider.of<ProviderData>(context, listen: false)
                                .quizIndex ==
                            Provider.of<ProviderData>(context, listen: false)
                                    .myQuestion
                                    .length -
                                1) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FinishScreen(results: Provider.of<ProviderData>(context, listen: true).selectedResults,)));
                        } else {
                          List<TileOption> option = [];
                          for (var data in Provider.of<ProviderData>(context,
                                  listen: false)
                              .myQuestion[
                                  Provider.of<ProviderData>(context, listen: false)
                                          .quizIndex +
                                      1]
                              .options!) {
                            option.add(TileOption(isSelected: false, option: data));
                          }
                          if (Provider.of<ProviderData>(context, listen: false)
                                  .selectedAnswer !=
                              null) {
                            // Provider.of<ProviderData>(context,listen: false).answers.add(Provider.of<ProviderData>(context,listen: false).selectedAnswer);
                            Provider.of<ProviderData>(context, listen: false)
                                .nextQuizIndex(option);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.white,
                                content: Text('An answer has to be selected',style: TextStyle(color: Colors.black),)));
                          }
                        }
                      },
                      color: kDesignColor,
                      height: 50,
                      minWidth: 119,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Provider.of<ProviderData>(context, listen: false)
                          .quizIndex !=
                          Provider.of<ProviderData>(context, listen: false)
                              .myQuestion
                              .length -
                              1?Icon(
                        Icons.arrow_forward,
                        size: 50,
                        color: Colors.white,
                      ):Text('Finish',style: TextStyle(color: Colors.white),),
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
