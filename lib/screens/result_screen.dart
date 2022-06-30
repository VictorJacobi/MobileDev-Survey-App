import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:survey/constants.dart';
import 'package:survey/screens/finish_screen.dart';
import 'package:survey/widgets/result_card.dart';
import 'package:survey/state_providers/provider_data.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen'),
        backgroundColor: kDesignColor,
        leading: InkWell(onTap: (){
          Provider.of<ProviderData>(context,listen: false).removeLastSelectedResult();
          Navigator.pop(context);
        },child: const Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      backgroundColor: const Color(0xFFF3F1F1),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        ResultCard(
                          question: Provider.of<ProviderData>(context,listen: true).selectedResults[index].question?.question,
                          selectedAnswer: Provider.of<ProviderData>(context,listen: true).selectedResults[index].selectedAnswers,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                TextButton(onPressed: (){
                  Provider.of<ProviderData>(context,listen: false).removeLastSelectedResult();
                  Navigator.pop(context);
                }, child: const Text('Edit',style: TextStyle(color: Colors.black,fontSize: 16),),),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const FinishScreen()));
                },color: kDesignColor,minWidth: 119.w,height: 50.h,child: const Text('submit',style: TextStyle(color: Colors.white),),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
