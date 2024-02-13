import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_task/common_widgets/custom_button.dart';
import 'package:job_task/common_widgets/text_form_field.dart';
import 'package:job_task/controller/provider/quiz_provider.dart';
import 'package:job_task/model/quiz_model.dart';
import 'package:job_task/view/create_quiz_screen.dart';
import 'package:job_task/view/review_screen.dart';

class QuizCategoryScreen extends StatefulWidget {
  static String route = "/createcategoryPage";
  final CategoryModel? model;

  const QuizCategoryScreen({super.key, this.model});

  @override
  // ignore: library_private_types_in_public_api
  _QuizCategoryScreenState createState() => _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _pickedImage;

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = pickedImage as PickedFile;
    });
  }

  @override
  void dispose() {
    _textFieldController1.dispose();
    _textFieldController2.dispose();
    _textFieldController3.dispose();
    super.dispose();
  }

  late QuizProvider quizProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 16.0),
            _pickedImage != null
                ? Image.file(
                    File(_pickedImage!.path),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : Container(),
            CustomTextFormField(
              hintText: 'Quiz title',
              controller: _textFieldController1,
              fieldTitle: 'Quiz Title',
              onChanged: (value) {
                quizProvider.category.title = value;

                return "";
              },
            ),
            CustomTextFormField(
                hintText: 'Quiz Category',
                controller: _textFieldController2,
                fieldTitle: 'Quiz Category',
                onChanged: (value) {
                  quizProvider.category.type = value;

                  return "";
                }),
            CustomTextFormField(
                hintText: 'Quiz titDescriptionle',
                controller: _textFieldController3,
                fieldTitle: 'Quiz Description',
                maxLines: 3,
                onChanged: (value) {
                  quizProvider.category.des = value;
                  return "";
                }),
            const SizedBox(height: 16.0),
            CustomButton(
              tap: () {
                Get.toNamed(CreateQuizPage.route, arguments: {
                  'quizTitle': _textFieldController1.text,
                  'quizCategory': _textFieldController2.text,
                  'quizDescription': _textFieldController3.text,
                  'quizImage': _pickedImage!.path
                });
              },
              buttonTitle: 'Next',
            )
          ],
        ),
      ),
    );
  }
}
