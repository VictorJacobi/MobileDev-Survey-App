import 'package:survey/questions.dart';

class ResultData{
  Question? question;
  String? selectedAnswers;
  ResultData({this.question,this.selectedAnswers});
  @override
  String toString(){
    return"""
    The selected answer is: $selectedAnswers
    the question is: ${question?.question}
    The options are: ${question?.options}
    And the correct answer is: ${question?.correctAnswer}
    ${isCorrect()==false?'You got it wrong 🙃☹':'you got it absolutely right 😉🥰'}
    """;
  }
  bool isCorrect(){
    if(selectedAnswers==question?.correctAnswer){
      return true;
    }
    else{
      return false;
    }
  }
}