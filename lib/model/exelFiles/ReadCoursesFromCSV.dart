import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import '../Dto/Course.dart';
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
                List<Course> loadedCourses = await _loadCSV( "assets/courses.csv");
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

  Widget buildListView() {
    if (courses.isEmpty) {
      return Column(
        children: [Text('No data found!!')],
      );
    }

    return ListView(
      children:[ Column(
        children: courses
            .map(
              (e) => ListTile(
            title: Text(
              "${e.name}",
            ),
          ),
        )
            .toList(),
      ),],
        shrinkWrap: true
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
    print(_data[0]);
    _data.removeAt(0);
    for (var d in _data) {
      courses.add(Course(d[2].toString(), d[8].toString(), d[7].toString(),
          d[11].toString(), d[3].toString()));
    }
    return courses;
  }
