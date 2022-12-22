import 'package:course_reminder/main.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:course_reminder/course.dart';

class CourseRepository {
  late Box<Course> _box;

  CourseRepository() {
    Hive.openBox<Course>('courses').then((value) {
      _box = value;
    });
  }

  Future<void> addCourse(Course course) async {
    await _box.add(course);
  }

  Future<void> deleteCourse(int index) async {
    await _box.deleteAt(index);
  }

  List<Course> getAllCourses() {
    return _box.values.toList();
  }
}
