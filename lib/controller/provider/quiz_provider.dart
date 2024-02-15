import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_task/model/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  final List<QuestionModel> questionsList = [];
  QuizModel model = QuizModel();

  Future<void> saveQuizDataToFirestore(QuizModel quizModel) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final Map<String, dynamic> quizData = quizModel.toJson();
      final DocumentReference docRef =
          await firestore.collection('quizzes').add(quizData);
      final String docId = docRef.id;
      quizModel.id = docId;
      await docRef.update({'id': docId});

      Get.snackbar('Success',
          'Quiz data saved successfully to Firestore with ID: $docId',
          backgroundColor: Colors.green[100]);
      debugPrint('Quiz data saved successfully to Firestore');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save quiz data to Firestore');
      debugPrint('Failed to save quiz data to Firestore: $e');
    }
  }

  void update() {
    notifyListeners();
  }
}
