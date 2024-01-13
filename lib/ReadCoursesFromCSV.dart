import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'Course.dart';
////////////////////
// Testing
void main() => runApp(App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Course> courses = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Courses'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                List<Course> loadedCourses = await _loadCSV( "assets/Courses.csv");
                setState(() {
                  courses = loadedCourses;
                });
              },
              child: Text('Get Courses'),
            ),
            buildListView(),
          ],
        ),
      ),
    );
  }

  Column buildListView() {
    if (courses.isEmpty) {
      return Column(
        children: [Text('No data found!!')],
      );
    }

    return Column(
      children: courses
          .map(
            (e) => ListTile(
          title: Text(
            "${e.name} ${e.activity} ${e.hours} ${e.instructor} ${e.sectionNumber} ${e.time}",
          ),
        ),
      )
          .toList(),
    );
  }
}

////////////////////

  Future<List<Course>> _loadCSV(String filePath) async {
    List<List<dynamic>> _data = [];
    List<Course> courses = [];
    var result = await rootBundle.loadString(
     filePath,
    );
    _data = const CsvToListConverter().convert(result, eol: "\n");
    _data.removeAt(0);
    for (var d in _data) {
      courses.add(Course(d[0].toString(), d[1].toString(), d[2].toString(),
          d[3].toString(), d[4].toString(), d[5].toString()));
    }
    return courses;
  }
