import '../model/Dto/AvailableSection.dart';

Future<List<AvailableSection>> getSuggestedCourses() async {
  List<AvailableSection>? availableSections = await _loadCourses();
  List<AvailableSection> notFinishedCourses = [];

  return generateSuggestionList(availableSections, notFinishedCourses);
}

List<AvailableSection> generateSuggestionList(
    List<AvailableSection>? availableSections, List<AvailableSection> notFinishedCourses) {



  return [];
}

Future<List<AvailableSection>?> _loadCourses() async {
  try {
    // List<Course> fetchedCourses = await getAvailableSections();
    // return fetchedCourses;
  } catch (error) {
    print("Error loading courses: $error");
    return null;
  }
}
