import '../model/Dto/Course.dart';

Future<List<Course>> getSuggestedCourses() async {
  List<Course>? availableSections = await _loadCourses();
  List<Course> notFinishedCourses = [];

  return generateSuggestionList(availableSections, notFinishedCourses);
}

List<Course> generateSuggestionList(
    List<Course>? availableSections, List<Course> notFinishedCourses) {



  return [];
}

Future<List<Course>?> _loadCourses() async {
  try {
    // List<Course> fetchedCourses = await getAvailableSections();
    // return fetchedCourses;
  } catch (error) {
    print("Error loading courses: $error");
    return null;
  }
}
