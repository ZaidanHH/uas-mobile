import 'package:flutter/material.dart';
import 'package:course_reminder/course.dart';
import 'package:course_reminder/course_repository.dart';

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final CourseRepository _repository = CourseRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _scheduleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Mata Kuliah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Mata Kuliah'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mohon masukkan nama mata kuliah';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(labelText: 'Kode Mata Kuliah'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mohon masukkan kode mata kuliah';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _scheduleController,
                decoration: InputDecoration(labelText: 'Jadwal Kelas'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mohon masukkan jadwal kelas';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final course = Course(
                        _nameController.text,
                        _codeController.text,
                        _scheduleController.text,
                      );
                      _repository.addCourse(course);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
