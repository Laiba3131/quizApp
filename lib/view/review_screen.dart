import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_task/controller/provider/quiz_provider.dart';
import 'package:job_task/model/quiz_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../common_widgets/custom_button.dart';

class ReviewScreen extends StatefulWidget {
  static String route = "/reviewScreenQuizPage";

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<QuizModel> questions = [];

  @override
  Widget build(BuildContext context) {
    QuizProvider quozInstance =
        Provider.of<QuizProvider>(context, listen: false);
    return Consumer<QuizProvider>(builder: (context, vm, _) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Create Quiz'),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(5.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display Quiz Category Screen data
                Text('${quozInstance.model.title}'),
                Text('${quozInstance.model.type}'),
                ListView.builder(
                    itemBuilder: (context, index) {
                      return customContainer(
                          "${quozInstance.questionsList[index].dquestion}",
                          "${quozInstance.questionsList[index].firstQuestion}",
                          "${quozInstance.questionsList[index].secondQuestion}",
                          "${quozInstance.questionsList[index].thirdQuestion}",
                          "${quozInstance.questionsList[index].fourthQuestion}");
                    },
                    itemCount: quozInstance.questionsList.length),

                CustomButton(
                    buttonTitle: 'Generate CV',
                    tap: () async {
                      // if (_formKey.currentState!.validate())
                      {
                        await buttonFn(vm, context);
                        debugPrint('clicked');
                      }
                    }),

                // ElevatedButton(
                //   onPressed: () async {
                //     try {
                //       await FirestoreService().saveQuizData(
                //         quizTitle: basicVar.model.title!,
                //         quizCategory: basicVar.model.type!,
                //         quizDescription: basicVar.model.des!,
                //         questions: questions
                //             .map((question) => question.toJson())
                //             .toList(),
                //       );
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('Quiz data saved successfully')),
                //       );
                //     } catch (e) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('Failed to save quiz data')),
                //       );
                //     }
                //   },
                //   child: Text('Confirm and Save to Firebase'),
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget customContainer(
    String question,
    String option1,
    String option2,
    String option3,
    String option4,
  ) {
    return Container(
      child: Column(
        children: [
          Text(question),
          optionsRow(option1),
          optionsRow(option2),
          optionsRow(option3),
          optionsRow(option4),
        ],
      ),
    );
  }
}

Widget optionsRow(option) {
  return Row(
    children: [
      Container(
        height: 5,
        width: 5,
        decoration:
            const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      ),
      SizedBox(
        width: 3.sp,
      ),
      Text(option),
    ],
  );
}

Future<void> buttonFn(QuizProvider vm, BuildContext context) async {
  Timestamp now = Timestamp.now();
  vm.model = QuizModel(
    title: vm.model.title,
    type: vm.model.type,
    des: vm.model.des,
    questions: vm.model.questions,
    createdAt: now,
    updatedAt: now,
  );
  await context.read<QuizProvider>().saveQuizDataToFirestore(
        vm.model,
      );
}
