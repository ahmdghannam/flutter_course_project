class Section {
  int sectionId;
  int courseId;
  String dayOfWeek;
  int startTime;
  int endTime;
  bool status; // open or close section
  String lecturerName;

  Section(this.sectionId,this.courseId, this.dayOfWeek, this.startTime, this.endTime,this.status, this.lecturerName);

  @override
  String toString() {
    String statusString = status == 1 ? 'open' : 'close';
    return 'Course{sectionId: $sectionId, courseId: $courseId, dayOfWeek: $dayOfWeek, Time: $startTime-$endTime, status: $statusString, lecturerName: $lecturerName} ============\n\n';
  }
}