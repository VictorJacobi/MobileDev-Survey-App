import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:survey/constants.dart';
import 'package:survey/widgets/result_card.dart';
import 'package:survey/screens/instructions_screen.dart';
import 'package:survey/state_providers/provider_data.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Provider.of<ProviderData>(context,listen: false).restartSurvey();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InstructionScreen()));
        }, label: const Text('Restart'),backgroundColor: kDesignColor,),
      appBar: AppBar(
        title: const Text('Result Screen'),
        backgroundColor: kDesignColor,
      ),
      backgroundColor: const Color(0xFFF3F1F1),
      body: SafeArea(
        child: ListView.builder(itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ResultCard(
                  question: Provider.of<ProviderData>(context,listen: true).selectedResults[index].question?.question,
                  options: Provider.of<ProviderData>(context,listen: true).selectedResults[index].question?.options,
                  selectedAnswer: Provider.of<ProviderData>(context,listen: true).selectedResults[index].selectedAnswers,
                  correctAnswer: Provider.of<ProviderData>(context,listen: true).selectedResults[index].question?.correctAnswer,
                ),
                Positioned(
                  left: 5,
                    top: 5,
                    child: Text('Q ${index+1}',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                ),
              ],
            ),
          );
        },itemCount: Provider.of<ProviderData>(context,listen: true).selectedResults.length,),
      ),
    );
  }
}
