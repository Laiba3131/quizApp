import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_task/model/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  final List<QuestionModel> questionsList = [];
  QuizModel model = QuizModel();

  // Future<void> saveQuizDataToFirestore(QuizModel quizModel) async {
  //   try {
  //     final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     final Map<String, dynamic> quizData = quizModel.toJson();
  //     await firestore.collection('quizzes').add(quizData);
  //     Get.snackbar('Success', 'Quiz data saved successfully to Firestore');
  //     debugPrint('Quiz data saved successfully to Firestore');
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to save quiz data to Firestore: $e');
  //     debugPrint('Failed to save quiz data to Firestore: $e');
  //     // Handle error as per your application's requirements
  //   }
  // }

  Future<void> saveQuizDataToFirestore(QuizModel quizModel) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final Map<String, dynamic> quizData = quizModel.toJson();

      // Add the quiz data to a Firestore collection called "quizzes"
      final DocumentReference docRef =
          await firestore.collection('quizzes').add(quizData);

      // Get the auto-generated document ID
      final String docId = docRef.id;

      // Update the QuizModel with the document ID
      quizModel.id = docId;

      // Update the document in Firestore with the ID field
      await docRef.update({'id': docId});

      Get.snackbar('Success',
          'Quiz data saved successfully to Firestore with ID: $docId');
      debugPrint('Quiz data saved successfully to Firestore with ID: $docId');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save quiz data to Firestore: $e');
      debugPrint('Failed to save quiz data to Firestore: $e');
      // Handle error as per your application's requirements
    }
  }

  void update() {
    notifyListeners();
  }
}
