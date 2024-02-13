import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_task/controller/provider/quiz_provider.dart';
import 'package:job_task/controller/services/firebase_service.dart';
import 'package:job_task/model/quiz_model.dart';
import 'package:provider/provider.dart';

class Review extends StatefulWidget {
  static String route = "/reviewQuizPage";

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List<QuizModel> questions = [];
  dynamic args;
  QuizModel? model;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args['model'] != null) {
          model = args['model'];
        }
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider basicVar = Provider.of<QuizProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Quiz Category Screen data
            Text('Quiz Title: $widget.model?.title ?? "No Title"'),
            Text('Quiz Category: $widget.model?.category ?? "No Category"'),
            Text(
                'Quiz Description: $widget.model?.description ?? "No Description"'),

            // Display Create Quiz Page data

            for (var question in questions) ...[
              Text('Question: ${basicVar.quizModel.dquestion}'),
              Text('Optional1: ${basicVar.quizModel.firstQuestion}'),
              Text('Optional2: ${basicVar.quizModel.secondQuestion}'),
              Text('Optional3: ${basicVar.quizModel.thirdQuestion}'),
              Text('Optional4: ${basicVar.quizModel.fourthQuestion}'),
            ],

            ElevatedButton(
              onPressed: () async {
                try {
                  await FirestoreService().saveQuizData(
                    quizTitle: basicVar.category.title!,
                    quizCategory: basicVar.category.type!,
                    quizDescription: basicVar.category.des!,
                    questions:
                        questions.map((question) => question.toJson()).toList(),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Quiz data saved successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to save quiz data')),
                  );
                }
              },
              child: Text('Confirm and Save to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
