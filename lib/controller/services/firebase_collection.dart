import 'package:cloud_firestore/cloud_firestore.dart';

class FBCollections {
  static FirebaseFirestore fb = FirebaseFirestore.instance;

  static CollectionReference users = fb.collection("QuizDetails");
}
