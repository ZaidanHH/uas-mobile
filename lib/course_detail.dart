import 'package:flutter/material.dart';
import 'package:course_reminder/course.dart';

typedef OnDeleteCallback = void Function();

class CourseDetailPage extends StatelessWidget {
  final Course course;
  final int index;
  final OnDeleteCallback onDelete;

  CourseDetailPage({
    required this.course,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kode Mata Kuliah: ${course.code}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Jadwal Kelas: ${course.schedule}',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onDelete,
        child: Icon(Icons.delete),
      ),
    );
  }
}
