import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey/constants.dart';
import 'package:survey/instructions_screen.dart';
import 'package:survey/provider_data.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Provider.of<ProviderData>(context,listen: false).restartSurvey();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InstructionScreen()));
        }, label: Text('Restart'),backgroundColor: kDesignColor,),
      appBar: AppBar(
        title: Text('Result Screen'),
        backgroundColor: kDesignColor,
      ),
      backgroundColor: Color(0xFFF3F1F1),
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
                    child: Text('Q ${index+1}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                ),
              ],
            ),
          );
        },itemCount: Provider.of<ProviderData>(context,listen: true).selectedResults.length,),
      ),
    );
  }
}
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
            SizedBox(width: 100,child: Text('(${i+1})   '+options[i],)),
            options[i]==correctAnswer?Icon(Icons.check,color: Colors.green,):SizedBox.shrink(),
            options[i] ==selectedAnswer&&!isCorrect()? Icon(Icons.clear,color: Colors.red,):SizedBox.shrink(),
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
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width-16,
      child: Padding(
        padding: const EdgeInsets.only(top: 35,bottom: 35,left: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$question'),
            SizedBox(height: 6,),
            // Text('${options}')
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: _showOptionWidget(options!),
           ),
            SizedBox(height: 6,),
          ],
        ),
      ),
    );
  }
}
