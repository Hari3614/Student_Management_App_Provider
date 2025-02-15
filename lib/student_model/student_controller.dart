import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_provider/model/student_model.dart';
import 'package:student_management_provider/services/database_helper.dart';

class StudentProvider extends ChangeNotifier {
  final List<StudentModel> students = [];
  final List<StudentModel> filteredStudents = [];
  String pickedImage = '';

  StudentProvider() {
    loadStudents();
  }

  Future<void> setPickedImage(String imagePath) async {
    pickedImage = imagePath;
    notifyListeners();
  }

  Future<String?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) {
        return null;
      }
      pickedImage = pickedFile.path;
      return pickedFile.path;
    } catch (e) {
      print('error fetching image: $e');
      return null;
    }
  }

  Future<void> loadStudents() async {
    List<Map<String, dynamic>> studentData =
        await DbHelper().getAllStudentsData();
    students.clear();
    students
        .addAll(studentData.map((data) => StudentModel.fromMap(data)).toList());
    filterStudents('');
    notifyListeners();
  }

  void filterStudents(String query) {
    print('Filtering students with query: $query');
    filteredStudents.clear();
    filteredStudents.addAll(students
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList());
    print('Filtered students: $filteredStudents');
    notifyListeners();
  }

  Future<void> addStudent(StudentModel student) async {
    await DbHelper().insertData(student);
    loadStudents();
  }

  Future<void> updateStudent(StudentModel updatedStudent) async {
    await DbHelper().updateDatabase(updatedStudent);
    loadStudents();
  }

  Future<void> setInitialImage(String imageUrl) async {
    pickedImage = imageUrl;
  }
}

class DeleteStudentProvider extends ChangeNotifier {
  Future<void> deleteStudent(int id) async {
    await DbHelper().deleteStudent(id);
    notifyListeners();
  }
}
