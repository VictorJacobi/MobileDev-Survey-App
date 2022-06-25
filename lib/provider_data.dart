import 'package:flutter/material.dart';
import 'package:survey/tile_option.dart';

class ProviderData extends ChangeNotifier{
  int index = 0;
  int quizIndex = 0;
  bool previousSelected = false;
  String? selectedAnswer;
  // int tileSElectedIndex = -1;
  List<TileOption> selectedResults = [];
  List<TileOption> objectives = [TileOption(option: 'Energy',isSelected: false),TileOption(option: 'Protein',isSelected: false),TileOption(option: 'Carbon dioxide',isSelected: false)];
  double progress = 0.1;
  void changeIndex(int index){
    this.index = index;
    notifyListeners();
  }
  void nextQuizIndex(List<TileOption> objectives){
    selectedAnswer = null;
    // selectedResults.add(objectives[quizIndex]);
    quizIndex+=1;
    progress+=0.1;
    this.objectives = objectives;
    notifyListeners();
  }
  void previousQuizIndex(List<TileOption> objectives){
    this.objectives = objectives;
    quizIndex-=1;
    progress-=0.1;
    notifyListeners();
  }
  // void markSelectedResult(dynamic objective){
  //   tileSElectedIndex = objectives.indexOf(objective);
  // }
  void tileSelected(bool isSelected,int index){
    objectives[index].isSelected = isSelected;
    if(isSelected){
      selectedAnswer = objectives[index].option;
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

}