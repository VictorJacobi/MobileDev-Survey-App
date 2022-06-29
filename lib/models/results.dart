import 'package:survey/models/questions.dart';

class ResultData{
  Question? question;
  String? selectedAnswers;
  ResultData({this.question,this.selectedAnswers});
  @override
  String toString(){
    return"""
    The selected answer is: $selectedAnswers
    """;

    // the question is: ${question?.question}
    //
    //     The options are: ${question?.options}
  }
}