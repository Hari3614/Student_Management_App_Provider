import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/core/constants.dart';
import 'package:student_management_provider/model/student_model.dart';
import 'package:student_management_provider/presentation/student_list_screen/student_list.dart';
import 'package:student_management_provider/presentation/widgets/text_button.dart';
import 'package:student_management_provider/student_model/student_controller.dart';

void showDialogueforDelete(BuildContext context, StudentModel student) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: 200,
          height: 250,
          decoration: containerDecoration2.copyWith(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  "Are you sure you to delete?",
                  style: ageandDepTxt,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButtonWidgets(
                      onPressed: () async {
                        await Provider.of<DeleteStudentProvider>(context,
                                listen: false)
                            .deleteStudent(student.id!);
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentListScreen()));
                      },
                      buttontext: 'OK',
                    ),
                    SizedBox(width: 16),
                    TextButtonWidgets(
                      buttontext: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
