import 'package:get/route_manager.dart';
import 'package:job_task/view/review_screen.dart';
import 'package:job_task/view/quiz_category.dart';
import 'package:job_task/view/create_quiz_screen.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: QuizCategoryScreen.route, page: () => const QuizCategoryScreen()),
    GetPage(name: CreateQuizPage.route, page: () => CreateQuizPage()),
    GetPage(name: ReviewScreen.route, page: () => ReviewScreen()),
  ];
}
