import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/core/constants.dart';
import 'package:student_management_provider/presentation/searchpage/search_page.dart';
import 'package:student_management_provider/presentation/student_add_screen/add_student_scrreen.dart';
import 'package:student_management_provider/presentation/widgets/app_bar_widget.dart';
import 'package:student_management_provider/presentation/widgets/floating_actionbutton.dart';
import 'package:student_management_provider/presentation/widgets/show_doalogue.dart';
import 'package:student_management_provider/student_model/student_controller.dart';

class StudentListScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const StudentListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final studentProviderController = context.read<StudentProvider>();
    studentProviderController.loadStudents();
    return Scaffold(
      backgroundColor: appBarClrWhite,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBarWidget(
          lefticon: Icons.menu,
          righticon: Icons.search,
          onTapright: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StudentsSearchScreen(),
            ));
          },
          title: 'STUDENTS LIST',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<StudentProvider>(
            builder: (context, studentProvider, _) {
              if (studentProvider.students.isEmpty) {
                return Text(
                  'No Student Found',
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: Constants().blackColor),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => setHeight,
                    scrollDirection: Axis.vertical,
                    itemCount: studentProviderController.students.length,
                    itemBuilder: (context, index) {
                      var student = studentProviderController.students[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 500,
                          decoration: containerDecoration1.copyWith(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: InkWell(
                                    onTap: () {
                                      showsDialogBoxs(
                                          context: context,
                                          circleAvatar: CircleAvatar(
                                            radius: 100,
                                            backgroundColor: appBarClrWhite,
                                            backgroundImage: FileImage(
                                                File(student.imageUrl)),
                                          ),
                                          studentname: Text(
                                            student.name,
                                            style: innerName,
                                          ),
                                          age: Text(
                                            'Age : ${student.age}',
                                            style: ageandDepTxt,
                                          ),
                                          parentname: Text(
                                            'Guardian Name : ${student.guardianName}',
                                            style: ageandDepTxt,
                                          ),
                                          department: Text(
                                            'Department : ${student.department}',
                                            style: ageandDepTxt,
                                          ),
                                          place: Text(
                                            'Place : ${student.place}',
                                            style: ageandDepTxt,
                                          ),
                                          phonenumber: Text(
                                            'Phone : ${student.phoneNumber}',
                                            style: ageandDepTxt,
                                          ),
                                          student: student);
                                    },
                                    child: Container(
                                      width: 320,
                                      height: 350,
                                      decoration: BoxDecoration(
                                        borderRadius: boxborderRadius,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              FileImage(File(student.imageUrl)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                setHeight15,
                                Text(
                                  student.name,
                                  style: innerName,
                                ),
                                setHeight,
                                Text(
                                  'Age : ${student.age}',
                                  style: ageandDepTxt,
                                ),
                                Text(
                                  'Department : ${student.department}',
                                  style: ageandDepTxt,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton:
          const FloatingActionButtonWidget(page: AddStudentScreen()),
    );
  }
}
