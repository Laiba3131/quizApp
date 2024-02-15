import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_task/common_widgets/custom_button.dart';
import 'package:job_task/common_widgets/text_form_field.dart';
import 'package:job_task/common_widgets/validators.dart';
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
  late QuizProvider quizCreate;
  dynamic args;
  QuizModel? quizCategoryModel;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    quizCreate = Provider.of<QuizProvider>(context, listen: false);
    if (quizCreate.questionsList.isEmpty) {
      quizCreate.questionsList.add(QuestionModel());
    }
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider quozInstance =
        Provider.of<QuizProvider>(context, listen: false);
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.sp),
          child: CustomButton(
              buttonTitle: 'Next',
              tap: () {
                debugPrint("${quozInstance.model.title}");

                if (_formKey.currentState!.validate()) {
                  Get.toNamed(
                    ReviewScreen.route,
                  );
                }
              }),
        ),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            'Create Quiz',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.sp),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  heading('Create Quiz', () {
                    setState(() {
                      quizCreate.questionsList.add(QuestionModel());
                    });
                  }),
                  //
                  for (int index = 0;
                      index < quizCreate.questionsList.length;
                      index++) ...[
                    questionTextField(index),
                    SizedBox(
                      height: 2.sp,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ));
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
              text: quizCreate.questionsList[index].dquestion),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FieldValidator.validateEmpty,
          onChanged: (value) {
            quizCreate.questionsList[index].dquestion = value;
            return "";
          },
        ),
        SizedBox(
          height: 5.sp,
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
                    text: quizCreate.questionsList[index].firstQuestion),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FieldValidator.validateEmpty,
                onChanged: (value) {
                  quizCreate.questionsList[index].firstQuestion = value;
                  return "";
                },
              ),
            ),
            SizedBox(
              width: 5.sp,
            ),
            Expanded(
              flex: 5,
              child: CustomTextFormField(
                hintText: "option 2",
                // focusNode: instituteFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.name,

                controller: TextEditingController(
                    text: quizCreate.questionsList[index].secondQuestion),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FieldValidator.validateEmpty,
                onChanged: (value) {
                  quizCreate.questionsList[index].secondQuestion = value;

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
                      quizCreate.questionsList.removeAt(index);
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
        SizedBox(
          height: 5.sp,
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: CustomTextFormField(
                hintText: "option 3",
                inputAction: TextInputAction.next,
                inputType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FieldValidator.validateEmpty,
                controller: TextEditingController(
                    text: quizCreate.questionsList[index].thirdQuestion),
                onChanged: (value) {
                  quizCreate.questionsList[index].thirdQuestion = value;
                  return "";
                },
              ),
            ),
            SizedBox(
              width: 5.sp,
            ),
            Expanded(
              flex: 5,
              child: CustomTextFormField(
                hintText: "optiona 4",
                // focusNode: instituteFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.text,
                validator: FieldValidator.validateEmpty,
                controller: TextEditingController(
                    text: quizCreate.questionsList[index].fourthQuestion),
                autovalidateMode: AutovalidateMode.onUserInteraction,

                onChanged: (value) {
                  quizCreate.questionsList[index].fourthQuestion = value;
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
        SizedBox(
          height: 5.sp,
        ),
      ],
    );
  }
}
