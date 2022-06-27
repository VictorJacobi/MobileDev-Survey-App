import 'package:flutter/material.dart';
import 'package:survey/models/questions.dart';
import 'package:survey/models/results.dart';
import 'package:survey/models/tile_option.dart';

class ProviderData extends ChangeNotifier{
  List<Question> myQuestion = [
    Question(
      question: 'It takes ____ to keep your mind alert.',
      options: ['Energy','Protein','Carbon dioxide'],
      correctAnswer: 'Energy',
      imageDirectory: 'images/quizImage1.png',
    ),
    Question(
      question: 'Nutrients are substances found in food that help your body grow and develop.',
      options: ['True','False'],
      correctAnswer: 'True',
      imageDirectory: 'images/quizImage2.png',
    ),
    Question(
        question: 'Vitamin D is sometimes called the:  ',
        options: ['Sleepy vitamin','The "dorky" vitamin','The sunshine vitamin'],
        correctAnswer: 'The sunshine vitamin',
      imageDirectory: 'images/quizImage3.png',
    ),
    Question(
        question: 'The parts of the body that work together to change food into a form the body can use.',
        options: ['Digestive system', 'Digestive juices','Esophagus'],
        correctAnswer: 'Digestive system',
      imageDirectory: 'images/quizImage4.png',
    ),
    Question(
        question: 'Food nutrients help your body to grow and to repair itself.  These types of foods are needed every day.',
        options: ['Proteins','Carbohydrates','Fiber'],
        correctAnswer: 'Proteins',
      imageDirectory: 'images/quizImage5.png',
    ),
    Question(
        question: 'Physical health is..',
        options: ['How fit you are and how healthy your body is.','The pH in your body which ties into your emotions.','How focused you are on other people\'s bodies.','None of the Above'],
        correctAnswer: 'How fit you are and how healthy your body is.',
      imageDirectory: 'images/quizImage6.png',
    ),
    Question(
        question: 'A thick, oily, dark, liquid that forms when tobacco burns is ___________.',
        options: ['Tar','Nicotine','Carbon'],
        correctAnswer: 'Tar',
      imageDirectory: 'images/quizImage7.png',
    ),
    Question(
        question: 'White blood cells that attack pathogens are called ______________.',
        options: ['Neurocytes','Lumphocytes','Carcinogens'],
        correctAnswer: 'Lumphocytes',
      imageDirectory: 'images/quizImage8.png',
    ),
    Question(
      question: 'God designed your body to change the food that you eat into a form your body can use.  The parts of your body that change or digest the food is called the _____.',
      options: ['Stomach','Digestive system'],
        correctAnswer: 'Digestive system',
      imageDirectory: null,
    ),
    Question(
        question: 'Your skin, nails, hair, muscles, internal organs and even your brain contain no protein.',
        options: ['True','False'],
        correctAnswer: 'False',
      imageDirectory: null,
    ),
    Question(
        question: 'How many chambers are in the heart?',
        options: ['2','3','4'],
        correctAnswer: '4',
      imageDirectory: null,
    ),
    Question(
        question: 'Nutrients from the soil that are found in foods.',
        options: ['Minerals','vitamins','Vegetables'],
        correctAnswer: 'Minerals',
      imageDirectory: null,
    ),
    Question(
        question: 'Liquids in the mouth and stomach help break down foods into materials the body can use.',
        options: ['Tall Cinnamon Dolce Latte, extra pump of cinnamon at 135','A tall glass of cold water','Digestive juices'],
        correctAnswer: 'Digestive juices',
      imageDirectory: null,
    ),
    Question(
        question: 'Your immune system produces chemicals called ___________ specifically to fight a particular invading substance.',
        options: ['Antibodies','T-Cells','Blood cells'],
        correctAnswer: 'Antibodies',
      imageDirectory: null,
    ),
    Question(
        question: 'How many servings from the fruit group should you eat daily?',
        options: ['0-1 serving','2-4 servings','4-6 servings','6-8 servings'],
        correctAnswer: '2-4 servings',
      imageDirectory: null,
    ),
    Question(
        question: 'Food which contains sugar and starch.  Most of your energy comes from this kind of food.  Foods with natural sugar or starch in them are the best source of this kind of food.',
        options: ['Cookies','Starches','Carbohydrates'],
        correctAnswer: 'Carbohydrates',
      imageDirectory: null,
    ),
    Question(
        question: '_______ is the ability to do work.',
        options: ['Energy','Digestive system','Digestive juices'],
        correctAnswer: 'Energy',
      imageDirectory: null,
    ),
    Question(
        question: 'Substances found in food that help your body grow and develop.',
        options: ['Protein','Nutrients','Fiber'],
        correctAnswer: 'Nutrients',
      imageDirectory: null,
    ),
    Question(
        question: 'Many children with asthma experience more severe reactions when they breathe ___________________',
        options: ['Secondhand smoke','Carbon dioxide','Oxygen'],
        correctAnswer: 'Secondhand smoke',
      imageDirectory: null,
    ),
    Question(
        question: 'Which of the following organ(s) form a part of the human digestive system? ',
        options: ['Esophagus','Anus','Lungs','Heart'],
        correctAnswer: 'Esophagus',
      imageDirectory: null,
    ),
  ];
  int index = 0;
  int quizIndex = 0;
  bool previousSelected = false;
  String? selectedAnswer;
  List answersPicked = [];
  // int tileSElectedIndex = -1;
  List<ResultData> selectedResults = [];
  List<TileOption> objectives = [TileOption(option: 'Energy',isSelected: false),TileOption(option: 'Protein',isSelected: false),TileOption(option: 'Carbon dioxide',isSelected: false)];
  double progress = 0.05;
  void changeIndex(int index){
    this.index = index;
    notifyListeners();
  }
  void nextQuizIndex(List<TileOption> objectives){
    selectedAnswer = null;
    previousSelected = false;

    quizIndex+=1;
    progress+=0.049;
    this.objectives = objectives;
    notifyListeners();
  }
  void previousQuizIndex(List<TileOption> objectives){
    // this.objectives = objectives;
    selectedAnswer = null;
    quizIndex-=1;
    progress-=0.049;
    answersPicked.removeLast();
    selectedResults.removeLast();
    this.objectives = objectives;
    previousSelected = true;
    notifyListeners();
  }
  // void markSelectedResult(dynamic objective){
  //   tileSElectedIndex = objectives.indexOf(objective);
  // }
  void tileSelected(bool isSelected,int index){
    objectives[index].isSelected = isSelected;
    if(isSelected){
      selectedAnswer = objectives[index].option;
      final ResultData result = ResultData(question:myQuestion[quizIndex],selectedAnswers: selectedAnswer);
      answersPicked.insert(quizIndex, selectedAnswer);
      selectedResults.insert(quizIndex,result);
      for(int i=quizIndex;i<answersPicked.length;i++){
        if(answersPicked.length>quizIndex+1){
          answersPicked.removeAt(i+1);
          selectedResults.removeAt(i+1);
        }else{

        }
      }
    }else{
      selectedAnswer = null;
    }
    notifyListeners();
  }
  void setSelectedAnswerNull(){
    selectedAnswer = null;
  }
  void tileRemainState(TileOption objective){
    objective.isSelected = false;
  }
  void restartSurvey(){
    quizIndex = 0;
    objectives = [TileOption(option: 'Energy',isSelected: false),TileOption(option: 'Protein',isSelected: false),TileOption(option: 'Carbon dioxide',isSelected: false)];
    answersPicked.clear();
    selectedResults.clear();
    progress = 0.05;
    index = 0;
    selectedAnswer = null;
    notifyListeners();
  }
}