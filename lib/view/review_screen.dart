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
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(7.sp),
            child: CustomButton(
                buttonTitle: 'Save',
                tap: () async {
                  // if (_formKey.currentState!.validate())
                  {
                    await buttonFn(vm, context);
                    debugPrint('clicked');
                  }
                }),
          ),
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text(
              'Review Quiz',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.sp,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return customContainer(
                          "${quozInstance.questionsList[index].dquestion}",
                          "${quozInstance.questionsList[index].firstQuestion}",
                          "${quozInstance.questionsList[index].secondQuestion}",
                          "${quozInstance.questionsList[index].thirdQuestion}",
                          "${quozInstance.questionsList[index].fourthQuestion}");
                    },
                    itemCount: quozInstance.questionsList.length),
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
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
          color: Colors.amber[100], borderRadius: BorderRadius.circular(10.sp)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question),
          optionsRow(option1),
          optionsRow(option2),
          optionsRow(option3),
          optionsRow(option4),
          SizedBox(
            height: 5.sp,
          )
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
        width: 10.sp,
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
