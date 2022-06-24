import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:survey/constants.dart';
import 'package:survey/provider_data.dart';
import 'package:survey/questions.dart';
import 'package:survey/tile_option.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List answers = [];
    List<Question> myQuestion = [
      Question(
          question: 'It takes ____ to keep your mind alert.',
        options: ['Energy','Protein','Carbon dioxide'],
        correctAnswer: 'Energy',
      ),
      Question(
          question: 'Nutrients are substances found in food that help your body grow and develop.',
        options: ['True','False'],
        correctAnswer: 'True',
      ),
      Question(
          question: 'Vitamin D is sometimes called the:  ',
        options: ['Sleepy vitamin','The "dorky" vitamin','The sunshine vitamin'],
        correctAnswer: 'Sleepy vitamin'
      ),
      Question(
          question: 'The parts of the body that work together to change food into a form the body can use.',
        options: ['Digestive system', 'Digestive juices','Esophagus'],
        correctAnswer: 'Digestive system'
      ),
      Question(
          question: 'Food nutrients help your body to grow and to repair itself.  These types of foods are needed every day.',
        options: ['Proteins','Carbohydrates','Fiber'],
        correctAnswer: 'Carbohydrates'
      ),
      Question(
          question: 'Physical health is..',
        options: ['How fit you are and how healthy your body is.','The pH in your body which ties into your emotions.','How focused you are on other people\'s bodies.','None of the Above'],
        correctAnswer: 'ow fit you are and how healthy your body is.'
      ),
      Question(
          question: 'A thick, oily, dark, liquid that forms when tobacco burns is ___________.',
        options: ['Tar','Nicotine','Carbon'],
        correctAnswer: 'Carbon'
      ),
      Question(
          question: 'White blood cells that attack pathogens are called ______________.',
        options: ['Neurocytes','Lumphocytes','Carcinogens'],
        correctAnswer: 'Lumphocytes'
      ),
      Question(
          question: 'God designed your body to change the food that you eat into a form your body can use.  The parts of your body that change or digest the food is called the _____.',
        options: ['Stomach','Digestive system'],
      ),
      Question(
          question: 'Your skin, nails, hair, muscles, internal organs and even your brain contain no protein.',
        options: ['True','False'],
        correctAnswer: 'False,'
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h,horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.clear,size: 30,),
                      SizedBox(width: 20.w,),
                      Text('Question',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700),),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width-41.w,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    barRadius: Radius.circular(10.r),
                    percent: Provider.of<ProviderData>(context,listen: true).progress,
                    progressColor: kDesignColor,
                  ),
                  SizedBox(height: 50.h),
                  Text(myQuestion[Provider.of<ProviderData>(context,listen: true).quizIndex].question!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      itemCount: myQuestion[Provider.of<ProviderData>(context,listen: true).quizIndex].options!.length,
                      itemBuilder: (context,index) {
                        return SizedBox(
                          height: 40.h,
                          child: ListTile(
                            leading: Stack(
                              children: [
                                Checkbox(
                                  value: Provider.of<ProviderData>(context,listen: true).objectives[index].isSelected,
                                  onChanged: (val){
                                    for(var objective in Provider.of<ProviderData>(context,listen: false).objectives){
                                      Provider.of<ProviderData>(context,listen: false).tileRemainState(objective);
                                    }
                                    Provider.of<ProviderData>(context,listen: false).tileSelected(val!, index);
                                  },
                                ),
                                Provider.of<ProviderData>(context,listen: false).selectedAnswer==null?Positioned(child: Text('empty',style: TextStyle(color: Colors.red,fontSize: 7),),bottom: 0,left: 14.w,):SizedBox.shrink(),
                              ],
                            ),
                            title: Text(Provider.of<ProviderData>(context,listen: true).objectives[index].option!),
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: MaterialButton(
                  onPressed: (){
                    if(Provider.of<ProviderData>(context,listen: false).quizIndex==myQuestion.length-1){

                    }else{
                      List<TileOption> option = [];
                      for(var data in myQuestion[Provider.of<ProviderData>(context,listen: false).quizIndex+1].options!){
                        option.add(TileOption(isSelected: false,option: data));
                      }
                      if(Provider.of<ProviderData>(context,listen: false).selectedAnswer!=null){
                        answers.add(Provider.of<ProviderData>(context,listen: false).selectedAnswer);
                        Provider.of<ProviderData>(context,listen: false).nextQuizIndex(option);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An answer has to be selected')));
                      }

                    }
                    },
                  color: kDesignColor,
                  height: 50,
                  minWidth: 119,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(Icons.arrow_forward,size: 50,color: Colors.white,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
