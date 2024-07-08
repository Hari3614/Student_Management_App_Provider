import 'package:flutter/material.dart';
import 'package:student_management_provider/core/constants.dart';
import 'package:student_management_provider/presentation/student_add_screen/add_student_scrreen.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
    this.page,
  });
  final dynamic page;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: FloatingActionButton(
          backgroundColor: appBarClrBlk,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddStudentScreen(),
            ));
          },
          child: const Icon(
            Icons.add,
            size: 25,
            color: appBarClrWhite,
          )),
    );
  }
}
