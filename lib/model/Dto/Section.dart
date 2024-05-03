class Section {
  int sectionId;
  int courseId;
  bool status;
  String time;

  Section(this.sectionId, this.courseId, this.status, this.time);

  @override
  String toString() {
    return 'Section{sectionid: $sectionId, courseId: $courseId, status: $status, time: $time}\n';
  }
}
