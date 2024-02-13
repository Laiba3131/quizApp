import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveQuizData({
    String? quizTitle,
    String? quizCategory,
    String? quizDescription,
    String? quizImage,
    required List<Map<String, dynamic>> questions,
  }) async {
    try {
      // Save quiz details
      DocumentReference quizRef = await _firestore.collection('quizzes').add({
        'title': quizTitle,
        'category': quizCategory,
        'description': quizDescription,
        'image': quizImage,
      });

      // Save questions for the quiz
      CollectionReference questionsRef = quizRef.collection('questions');
      for (var question in questions) {
        await questionsRef.add(question);
      }

      print('Quiz data saved successfully');
    } catch (e) {
      print('Failed to save quiz data: $e');
      throw e;
    }
  }
}
