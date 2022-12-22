import 'package:flutter/material.dart';
import 'package:course_reminder/course_repository.dart';
import 'package:course_reminder/course.dart';
import 'package:course_reminder/add_course.dart';
import 'package:course_reminder/course_detail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

Future<void> openBox() async {
  await Hive.deleteBoxFromDisk('courses');
  await Hive.openBox<Course>('courses');
}

void main() async {
  await Hive.initFlutter();
  var _box = await Hive.openBox('course');
  runApp(CourseReminderApp());
  Hive.close();
}

class CourseReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Reminder',
      home: CourseReminderHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

class CourseReminderHomePage extends StatefulWidget {
  @override
  _CourseReminderHomePageState createState() => _CourseReminderHomePageState();
}

class _CourseReminderHomePageState extends State<CourseReminderHomePage> {
  final CourseRepository _repository = CourseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Reminder'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: Hive.openBox('courses'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return _buildListView();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddCoursePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _repository.getAllCourses().length,
      itemBuilder: (context, index) {
        final course = _repository.getAllCourses()[index];
        return Card(
          child: ListTile(
            title: Text(course.name),
            subtitle: Text(course.code),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CourseDetailPage(
                    course: course,
                    index: index,
                    onDelete: () {
                      setState(() {
                        _repository.deleteCourse(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
