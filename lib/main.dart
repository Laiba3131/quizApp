import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_task/controller/provider/quiz_provider.dart';
import 'package:job_task/view/quiz_category.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'app_routes/app_routes.dart';

void main() {
  runApp(const MyApp());
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => QuizProvider()),
    ],
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: QuizCategoryScreen.route,
        getPages: AppPages.pages ?? [],
      );
    });
  }
}
