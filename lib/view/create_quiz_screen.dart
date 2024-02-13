import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:job_task/common_widgets/custom_button.dart';
import 'package:job_task/common_widgets/text_form_field.dart';
import 'package:job_task/controller/provider/quiz_provider.dart';
import 'package:job_task/model/quiz_model.dart';
import 'package:job_task/view/review_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CreateQuizPage extends StatefulWidget {
  static String route = "/createQuiz";

  CreateQuizPage();

  @override
  _CreateQuizPageState createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late QuizProvider quizProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Quiz'),
        ),
        body: Column(
          children: [
            heading('Your Qualification', () {
              setState(() {
                quizProvider.questionsList.add(QuestionModel());
              });
            }),
            //
            for (int index = 0;
                index < quizProvider.questionsList.length;
                index++) ...[
              questionTextField(index),
              SizedBox(
                height: 2.sp,
              ),
              CustomButton(
                  buttonTitle: 'Next',
                  tap: () {
                    Get.toNamed(
                      ReviewScreen.route,
                    );
                  })
            ],
          ],
        ));
  }

  Future<void> saveQuestionsToFirestore(
      List<Map<String, dynamic>> questions) async {
    try {
      final batch = _firestore.batch();
      final collectionRef = _firestore.collection('quiz_questions');

      for (var question in questions) {
        batch.set(collectionRef.doc(), question);
      }

      await batch.commit();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Questions saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save questions')),
      );
    }
  }

  Widget heading(String text, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
        ),
        TextButton(
            onPressed: onTap,
            child: const Text(
              'ADD MORE',
            )),
      ],
    );
  }

  Widget questionTextField(int index) {
    return Column(
      children: [
        CustomTextFormField(
          hintText: "Question",
          inputAction: TextInputAction.next,
          inputType: TextInputType.name,
          controller: TextEditingController(
              text: quizProvider.questionsList[index].dquestion),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            quizProvider.questionsList[index].dquestion = value;
            return "";
          },
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: CustomTextFormField(
                hintText: "option 1",
                inputAction: TextInputAction.next,
                inputType: TextInputType.name,
                controller: TextEditingController(
                    text: quizProvider.questionsList[index].firstQuestion),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  quizProvider.questionsList[index].firstQuestion = value;
                  return "";
                },
              ),
            ),
            SizedBox(
              width: 2.sp,
            ),
            Expanded(
              flex: 5,
              child: CustomTextFormField(
                hintText: "option 2",
                // focusNode: instituteFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.name,

                controller: TextEditingController(
                    text: quizProvider.questionsList[index].secondQuestion),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  quizProvider.questionsList[index].secondQuestion = value;

                  return "";
                },
              ),
            ),
            if (index >= 1)
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      quizProvider.questionsList.removeAt(index);
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20.sp,
                  ),
                ),
              ),
            Expanded(
              flex: index == 0 ? 2 : 1,
              child: Container(),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: CustomTextFormField(
                hintText: "option 3",
                inputAction: TextInputAction.next,
                inputType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: TextEditingController(
                    text: quizProvider.questionsList[index].thirdQuestion),
                onChanged: (value) {
                  quizProvider.questionsList[index].thirdQuestion = value;
                  return "";
                },
              ),
            ),
            SizedBox(
              height: 2.sp,
            ),
            Expanded(
              flex: 5,
              child: CustomTextFormField(
                hintText: "optiona 4",
                // focusNode: instituteFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.number,

                controller: TextEditingController(
                    text: quizProvider.questionsList[index].fourthQuestion),
                autovalidateMode: AutovalidateMode.onUserInteraction,

                onChanged: (value) {
                  quizProvider.questionsList[index].fourthQuestion = value;
                  return "";
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ],
    );
  }
}
