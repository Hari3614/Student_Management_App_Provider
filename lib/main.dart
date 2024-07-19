import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/presentation/student_list_screen/student_list.dart';
import 'package:student_management_provider/student_model/student_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeleteStudentProvider(),
        )
      ],
      child: const MaterialApp(
        home: StudentListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
