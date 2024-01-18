class Course {
  int courseId;
  String courseName;
  int defaultSemester;
  int preRequisitesCourses;
  int creditHours;

  Course(this.courseId,this.courseName, this.defaultSemester, this.preRequisitesCourses, this.creditHours);

  @override
  String toString() {
    return 'Course{courseId: $courseId, courseName: $courseName, defaultSemester: $defaultSemester, preRequisitesCourses: $preRequisitesCourses, creditHours: $creditHours} ========\n\n';
  }
}