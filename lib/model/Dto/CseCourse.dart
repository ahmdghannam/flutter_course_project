class CseCourse {
  int courseId;
  String courseName;
  int defaultSemester;
  int creditHours;
  int preRequisitesCourses;

  CseCourse(this.courseId, this.courseName, this.defaultSemester, this.creditHours,
      this.preRequisitesCourses);

  @override
  String toString() {
    return 'Course{courseId: $courseId, courseName: $courseName, defaultSemester: $defaultSemester, creditHours: $creditHours, preRequisitesCourses: $preRequisitesCourses}';
  }
}