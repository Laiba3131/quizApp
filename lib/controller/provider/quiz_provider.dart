import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_task/model/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  PageController singupPageController = PageController();
  int singupPage = 0;

  void updateCurrentStep() {
    singupPage = 0;
    notifyListeners();
  }

  QuizModel quizModel = QuizModel();

  final List<QuizModel> quizList = [];
  final CategoryModel category = CategoryModel();

  void update() {
    notifyListeners();
  }
}
