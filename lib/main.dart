import 'package:flutter/material.dart';
import 'package:lang_practice/core/route/app_routes.dart';
import 'package:lang_practice/core/values/string.dart';
import 'package:lang_practice/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjector();
  runApp(const LangPracticeApp());
}

class LangPracticeApp extends StatelessWidget {
  const LangPracticeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.routeWords,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}