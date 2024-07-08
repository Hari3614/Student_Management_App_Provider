import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/core/constants.dart';
import 'package:student_management_provider/model/student_model.dart';
import 'package:student_management_provider/presentation/widgets/app_bar_widget.dart';
import 'package:student_management_provider/presentation/widgets/snack_bar.dart';
import 'package:student_management_provider/presentation/widgets/textfield_Widget.dart';
import 'package:student_management_provider/student_model/student_controller.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProviderController = context.read<StudentProvider>();
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    TextEditingController phoneNoController = TextEditingController();
    TextEditingController guardianNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBarWidget(
          onTapLeft: () {
            Navigator.pop(context);
          },
          title: 'Enter Student Details',
          lefticon: Icons.arrow_back,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 120, top: 25),
              child: Consumer<StudentProvider>(
                builder: (context, studentprovider, child) => InkWell(
                  onTap: () async {
                    final imagepath = await studentProviderController
                        .pickImage(ImageSource.gallery);
                    studentProviderController.setPickedImage(imagepath ?? '');
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 189, 186, 186),
                          borderRadius: boxborderRadius,
                          image: studentProviderController
                                  .pickedImage.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(File(
                                      studentProviderController.pickedImage)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        width: 150,
                        height: 170,
                        child: studentProviderController.pickedImage.isEmpty
                            ? const Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Constants().kheight20,
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      prefixicon: Icons.person,
                      controller: nameController,
                      hintText: 'Enter the name',
                      labelText: 'Name',
                      inputType: TextInputType.name,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'please enter a valid name';
                        }
                        return null;
                      },
                    ),
                    TextFormFieldWidget(
                      prefixicon: Icons.calendar_month,
                      controller: ageController,
                      hintText: 'Enter the age',
                      labelText: 'Age',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.parse(value) >= 120 ||
                            int.parse(value) <= 0) {
                          return 'please enter a valid age';
                        }
                        return null;
                      },
                    ),
                    TextFormFieldWidget(
                      prefixicon: Icons.diversity_3,
                      controller: guardianNameController,
                      hintText: 'Enter the name of the Guardian',
                      labelText: 'Guardian Name',
                      inputType: TextInputType.name,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'please enter a valid name';
                        }
                        return null;
                      },
                    ),
                    TextFormFieldWidget(
                      prefixicon: Icons.library_books,
                      controller: departmentController,
                      hintText: 'Enter the department',
                      labelText: 'Department',
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'please enter a valid department';
                        }
                        return null;
                      },
                    ),
                    TextFormFieldWidget(
                      prefixicon: Icons.location_city,
                      controller: placeController,
                      hintText: 'Enter the place',
                      labelText: 'Place',
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'please enter a valid place';
                        }
                        return null;
                      },
                    ),
                    TextFormFieldWidget(
                      prefixicon: Icons.phone,
                      controller: phoneNoController,
                      hintText: 'Enter the phone number',
                      labelText: 'Contact Number',
                      inputType: TextInputType.phone,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 10) {
                          return 'please enter a valid phone no';
                        }
                        return null;
                      },
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: appBarClrBlk, borderRadius: boxborderRadius),
                      child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                studentProviderController
                                    .pickedImage.isNotEmpty) {
                              studentProviderController.addStudent(StudentModel(
                                  name: nameController.text,
                                  age: int.parse(ageController.text),
                                  department: departmentController.text,
                                  place: placeController.text,
                                  phoneNumber:
                                      int.parse(phoneNoController.text),
                                  guardianName: guardianNameController.text,
                                  imageUrl:
                                      studentProviderController.pickedImage));

                              snackBarFunction(
                                context: context,
                                title: 'Success',
                                subtitle: 'Adding Successfully',
                                backgroundColor: appBarClrGrn,
                                borderRadius: 10,
                                duration: const Duration(seconds: 4),
                                animationDuration: const Duration(seconds: 4),
                                dismissDirection: DismissDirection.horizontal,
                                reverseAnimationCurve: Curves.bounceInOut,
                              );

                              nameController.clear();
                              ageController.clear();
                              departmentController.clear();
                              placeController.clear();
                              phoneNoController.clear();
                              guardianNameController.clear();
                              studentProviderController.pickedImage = '';
                            } else if (studentProviderController
                                .pickedImage.isEmpty) {
                              snackBarFunction(
                                title: 'Error',
                                subtitle: 'Please select an image',
                                backgroundColor: Colors.red,
                                dismissDirection: DismissDirection.horizontal,
                                borderRadius: 10,
                                animationDuration: const Duration(seconds: 2),
                                reverseAnimationCurve: Curves.bounceOut,
                                duration: const Duration(seconds: 2),
                                context: context,
                              );
                            } else {}
                          },
                          child: Text(
                            'Upload Details',
                            style: buttonTxt,
                          )),
                    ),
                    setHeight
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
