import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  QuizModel({
    this.id,
    this.title,
    this.type,
    this.des,
    this.questions,
    this.createdAt,
    this.updatedAt,
  });

  String? title;
  String? id;
  String? type;
  String? des;
  List<QuestionModel>? questions;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['des'] = des;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

class QuestionModel {
  QuestionModel({
    this.dquestion,
    this.firstQuestion,
    this.secondQuestion,
    this.thirdQuestion,
    this.fourthQuestion,
  });

  String? showDeleteIcon;
  String? thirdQuestion;
  String? dquestion;
  String? firstQuestion;
  String? secondQuestion;
  String? fourthQuestion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['thirdQuestion'] = thirdQuestion;
    map['dquestion'] = dquestion;
    map['firstQuestion'] = firstQuestion;
    map['secondQuestion'] = secondQuestion;
    map['fourthQuestion'] = fourthQuestion;
    return map;
  }
}
