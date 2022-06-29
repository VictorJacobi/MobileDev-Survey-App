import 'package:flutter/material.dart';
import 'package:survey/models/questions.dart';
import 'package:survey/models/results.dart';
import 'package:survey/models/tile_option.dart';

class ProviderData extends ChangeNotifier{
  List<Question> myQuestion = [
    Question(
      question: 'How often do you get a health checkup?',
      options: ['Once in 3 months','Once in 6 months','Once a year','Only when needed','Never get it done','Other'],
      imageDirectory: 'images/quizImage1.png',
      questionType: 'Introductory Questions',
      optionType: 'obj',
    ),
    Question(
      question: 'What do you say about your overall health?',
      options: ['Having Good Physical Health','Moderately physically impaired','Severely physically impaired','Totally physically impaired'],
      imageDirectory: 'images/quizImage2.png',
      questionType: 'Introductory Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'Do you have any chronic diseases?',
        options: ['Yes','No',],
      imageDirectory: 'images/quizImage3.png',
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'Do you have any hereditary conditions/diseases?',
        options: ['Yes', 'No'],
      imageDirectory: 'images/quizImage4.png',
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'Are you habitual to drugs and alcohol?',
        options: ['Yes to both','Only to drugs','Only to alcohol','I am not habituated to either'],
      imageDirectory: 'images/quizImage5.png',
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'Over the past 2 weeks, how often have you felt nervous, anxious, or on edge?',
        options: ['Not all','Several days','More days than not','Nearly every day'],
      imageDirectory: 'images/quizImage6.png',
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'Over the past 2 weeks, how often have you felt down, depressed, or hopeless?',
        options: ['Not all','Several days','More days than not','Nearly every day'],
      imageDirectory: 'images/quizImage7.png',
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'Over the past 2 weeks, how often have you felt little interest or pleasure in doing things?',
        options: ['Not all','Several days','More days than not','Nearly every day'],
      imageDirectory: 'images/quizImage8.png',
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
      question: 'How would you describe the condition of your mouth and teeth, including false teeth or dentures?',
      options: ['Excellent','Good','Average','Poor'],
      imageDirectory: null,
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'How often do you have trouble taking medicines the way you have been told to take them?',
        options: ['I do not have to take medicine','I always take them as prescribed','Sometimes I take them as prescribed','I seldom take them as prescribed'],
      imageDirectory: null,
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'On how many of the last 7 days did you engage in moderate to strenuous exercise (like a brisk walk)?',
        options: ['0 Day','1 Day','2 Days','3 Days','4 Days','5 Days','6 Days','7 Days'],
      imageDirectory: null,
      questionType: 'Health Assessment Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'How would you rate the diagnosis process that you experienced?',
        options: ['Excellent','Above average','Average','Below average','Very poor'],
      imageDirectory: null,
      questionType: 'Hospital Related Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'Overall, how do you rate us as compared to other local hospitals in your area?',
        options: ['Excellent','Above average','Average','Below average','Very poor'],
      imageDirectory: null,
      questionType: 'Hospital Related Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'How would you rate our ambulance service?',
        options: ['Excellent','Good','Average','Poor'],
      imageDirectory: null,
      questionType: 'Providers Related Questions',
      optionType: 'obj',
    ),
    Question(
      question: 'Did the pharmacy staff collect the right deductible from you for your medicines?',
      options: null,
      imageDirectory: null,
      questionType: 'Providers Related Questions',
      optionType: 'fields',
    ),
    Question(
        question: 'How easy was it to schedule an appointment at our facility?',
        options: null,
      imageDirectory: null,
      questionType: 'General Questions',
      optionType: 'fields',
    ),
    Question(
        question: 'How long did you wait beyond your appointment time to be seen by a provider?',
        options: null,
      imageDirectory: null,
      questionType: 'General Questions',
      optionType: 'fields',
    ),
    Question(
        question: 'How well do you feel the provider listened to your health concerns?',
        options: null,
      imageDirectory: null,
      questionType: 'General Questions',
      optionType: 'fields',
    ),
    Question(
        question: 'Please rate how thorough you feel the provider’s instructions for care were',
        options: ['Excellent','Above average','Average','Below average','Very poor'],
      imageDirectory: null,
      questionType: 'General Questions',
      optionType: 'obj',
    ),
    Question(
        question: 'How satisfied are you with the cleanliness of our facility?',
        options: null,
      imageDirectory: null,
      questionType: 'General Questions',
      optionType: 'fields',
    ),
  ];
  int index = 0;//The index helps to keep track the state of the page view in the instruction screen
  int quizIndex = 0;//The index helps to keep track the state of the question in the question screen
  bool previousSelected = false;//This helps to keep track if the previous text button in the question screen is selected(true) or not(false)
  String? selectedAnswer;//This is the selected option of each question in the question screen
  List<String> selectedAnswers = [];
  // List answersPicked = [];
  // int tileSElectedIndex = -1;
  List<ResultData> selectedResults = [];
  String t = '';
  String controllerText = '';
  final TextEditingController controller = TextEditingController();
  List<TileOption> objectives = [
    TileOption(option: 'Once in 3 months',isSelected: false),
    TileOption(option: 'Once in 6 months',isSelected: false),
    TileOption(option: 'Once a year',isSelected: false),
    TileOption(option: 'Only when needed',isSelected: false),
    TileOption(option: 'Never get it done',isSelected: false),
    TileOption(option: 'Other',isSelected: false),
  ];
  double progress = 0.05;
  void changeIndex(int index){//This changes the page view in the instruction screen
    this.index = index;
    notifyListeners();
  }
  void nextQuizIndexOption(List<TileOption> objectives){//Displays to the next quiz in the question screen
    myQuestion[quizIndex].questionType=='obj'?selectedAnswers.insert(quizIndex,selectedAnswer!):selectedAnswers.insert(quizIndex,controller.text);
    selectedAnswer = null;
    t = 'next is executed';
    final ResultData result = ResultData(question:myQuestion[quizIndex],selectedAnswers: controller.text);
    if(controller.text.isNotEmpty){
      selectedResults.insert(quizIndex, result);
      controllerText = controller.text;
      controller.clear();
    }
    previousSelected = false;

    quizIndex+=1;
    progress+=0.049;
    this.objectives = objectives;
    notifyListeners();
  }
  void endQuiz(List<TileOption> objectives){
    myQuestion[quizIndex].questionType=='obj'?selectedAnswers.insert(quizIndex,selectedAnswer!):selectedAnswers.insert(quizIndex,controller.text);
    selectedAnswer = null;
    t = 'It\'s ended';
    final ResultData result = ResultData(question:myQuestion[quizIndex],selectedAnswers: controller.text);
    if(controller.text.isNotEmpty){
      selectedResults.insert(quizIndex, result);
      controllerText = controller.text;
      controller.clear();
    }
    previousSelected = false;
    this.objectives = objectives;
    notifyListeners();
  }
  void removeLastSelectedResult(){
    selectedResults.removeLast();
    notifyListeners();
  }
  void previousQuizIndex(){//Displays to the previous quiz in the question screen
    selectedAnswer = null;
    controller.text = controllerText;
    quizIndex-=1;

    progress-=0.049;
    // answersPicked.removeLast();
    selectedResults.removeLast();
    controller.clear();
    List<TileOption> option = [];
    if(myQuestion[quizIndex].options!=null){
    for (var data in myQuestion[quizIndex].options!) {
      if(data == selectedAnswers[quizIndex]){
        option.add(TileOption(isSelected: true, option: data));
      }else{
        option.add(TileOption(isSelected: false, option: data));
      }
    }
    }else{

    }
    objectives = option;
    previousSelected = true;
    notifyListeners();
  }
  void tileSelected(bool isSelected,int index){
    /*
    This performs the operation that allows that once the check box is ticked it helps add the result of the selected option.
     It also helps to check the box of the selected val, and make the unselected remain at their state with the help of the tileRemainState() function below
    */
    objectives[index].isSelected = isSelected;
    if(isSelected){
      selectedAnswer = objectives[index].option;
      final ResultData result = ResultData(question:myQuestion[quizIndex],selectedAnswers: selectedAnswer);
      // answersPicked.insert(quizIndex, selectedAnswer);
      selectedResults.insert(quizIndex,result);
      for(int i=quizIndex;i<selectedResults.length;i++){
        if(selectedResults.length>quizIndex+1){
          // answersPicked.removeAt(i+1);
          selectedResults.removeAt(i+1);
        }else{

        }
      }
    }else{
      selectedAnswer = null;
    }
    notifyListeners();
  }
  void tileRemainState(TileOption objective){
    //It helps to make the unselected remain at their state with the help of the tileRemain function below
    objective.isSelected = false;
  }
  void restartSurvey(){
    //This function restarts the survey.
    quizIndex = 0;
    objectives = [
      TileOption(option: 'Once in 3 months',isSelected: false),
      TileOption(option: 'Once in 6 months',isSelected: false),
      TileOption(option: 'Once a year',isSelected: false),
      TileOption(option: 'Only when needed',isSelected: false),
      TileOption(option: 'Never get it done',isSelected: false),
      TileOption(option: 'Other',isSelected: false),
    ];
    // answersPicked.clear();
    selectedResults.clear();
    progress = 0.05;
    index = 0;
    selectedAnswer = null;
    notifyListeners();
  }
}