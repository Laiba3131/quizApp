import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_task/common_widgets/custom_button.dart';
import 'package:job_task/common_widgets/text_form_field.dart';
import 'package:job_task/controller/provider/quiz_provider.dart';
import 'package:job_task/view/create_quiz_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class QuizCategoryScreen extends StatefulWidget {
  static String route = "/createcategoryPage";
  const QuizCategoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizCategoryScreenState createState() => _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {
  late QuizProvider quizCategory;

  @override
  void initState() {
    super.initState();
    quizCategory = QuizProvider(); // Initialize quizCategory here
  }

  ValueChanged<File?>? uploadImage;
  File? _image;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Consumer<QuizProvider>(builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text(
              'Quiz Category',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    pickImageWidget(vm),
                    SizedBox(
                      height: 5.sp,
                    ),
                    CustomTextFormField(
                      hintText: 'Quiz title',
                      controller:
                          TextEditingController(text: quizCategory.model.title),
                      fieldTitle: 'Quiz Title',
                      onChanged: (value) {
                        quizCategory.model.title = value;
                        print('Title: ${quizCategory.model.title}');
                        return "";
                      },
                    ),
                    CustomTextFormField(
                        hintText: 'Quiz Category',
                        controller: TextEditingController(
                            text: quizCategory.model.type),
                        fieldTitle: 'Quiz Category',
                        onChanged: (value) {
                          quizCategory.model.type = value;

                          return "";
                        }),
                    CustomTextFormField(
                        hintText: 'Quiz titDescriptionle',
                        controller:
                            TextEditingController(text: quizCategory.model.des),
                        fieldTitle: 'Quiz Description',
                        maxLines: 3,
                        onChanged: (value) {
                          quizCategory.model.des = value;
                          return "";
                        }),
                    const SizedBox(height: 16.0),
                    CustomButton(
                      tap: () {
                        Get.toNamed(
                          CreateQuizPage.route,
                          arguments: {"model": quizCategory},
                        );
                      },
                      buttonTitle: 'Next',
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget pickImageWidget(QuizProvider vm) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () async {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
        );

        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      },
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 50.sp,
            height: 50.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(width: 3.0, color: Colors.amber),
            ),
            child: Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue.withOpacity(.08)),
              child: _image == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Icon(
                        Icons.add,
                        size: 25.sp,
                        color: Colors.amber,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.file(
                        File(_image?.path ?? ""),
                        width: 40.sp,
                        height: 40.sp,
                      ),
                    ),
            ),
          ),
          SizedBox(
            width: 3.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Colors.black,
                  letterSpacing: 0.32,
                ),
              ),
              Text(
                'Click to upload image',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey,
                  letterSpacing: -0.012,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
