class QuizModel {
  QuizModel({
    this.dquestion,
    this.firstQuestion,
    this.secondQuestion,
    this.thirdQuestion,
    this.fourthQuestion,
  });

  QuizModel.fromJson(dynamic json) {
    dquestion = json['dquestion'];
    firstQuestion = json['firstQuestion'];
    secondQuestion = json['secondQuestion'];
    thirdQuestion = json['thirdQuestion'];
    fourthQuestion = json['fourthQuestion'];
  }
  bool? showDeleteIcon;
  String? thirdQuestion;
  String? dquestion;
  String? firstQuestion;
  String? secondQuestion;
  bool? fourthQuestion;
  QuizModel copyWith({
    String? year,
    String? firstQuestion,
    String? secondQuestion,
  }) =>
      QuizModel(
        thirdQuestion: year ?? thirdQuestion,
        dquestion: year ?? dquestion,
        firstQuestion: firstQuestion ?? this.firstQuestion,
        secondQuestion: secondQuestion ?? this.secondQuestion,
      );
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

class CategoryModel {
  CategoryModel({
    this.title,
    this.type,
    this.des,
  });
  String gettitle() {
    return title!;
  }

  CategoryModel.fromJson(dynamic json) {
    title = json['title'];
    type = json['type'];
    des = json['des'];
    ;
  }
  String? title;
  String? type;
  String? des;

  CategoryModel copyWith({
    String? title,
    String? type,
    String? des,
  }) =>
      CategoryModel(
        title: title ?? this.title,
        type: type ?? this.type,
        des: des ?? this.des,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['type'] = type;
    map['des'] = des;
    return map;
  }

  void copyFrom(CategoryModel other) {
    title = other.title;
    type = other.type;
    des = other.des;
  }
}
