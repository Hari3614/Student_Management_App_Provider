import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/core/constants.dart';
import 'package:student_management_provider/presentation/student_add_screen/add_student_scrreen.dart';
import 'package:student_management_provider/presentation/widgets/app_bar_widget.dart';
import 'package:student_management_provider/presentation/widgets/floating_actionbutton.dart';
import 'package:student_management_provider/presentation/widgets/show_doalogue.dart';
import 'package:student_management_provider/presentation/widgets/textfield_Widget.dart';
import 'package:student_management_provider/student_model/student_controller.dart';

class StudentsSearchScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  StudentsSearchScreen({Key? key});

  final searchController = TextEditingController();
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
          onTapright: () {},
          title: 'STUDENTS LIST',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: searchController,
              labelText: 'Search',
              hintText: 'Search Students',
              inputType: TextInputType.name,
              prefixicon: Icons.search,
              onChanged: (value) {
                studentProviderController.filterStudents(value);
              },
            ),
            Expanded(
              child: Consumer<StudentProvider>(
                builder: (context, studentprovider, _) {
                  if (studentprovider.students.isEmpty) {
                    return const Center(child: Text('No Student Found'));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => setHeight,
                        scrollDirection: Axis.vertical,
                        itemCount: studentprovider.filteredStudents.length,
                        itemBuilder: (context, index) {
                          var student = studentprovider.filteredStudents[index];
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
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                  File(student.imageUrl)),
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
          ],
        ),
      ),
      floatingActionButton:
          const FloatingActionButtonWidget(page: AddStudentScreen()),
    );
  }
}
