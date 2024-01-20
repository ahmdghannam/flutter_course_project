class AvailableSection {
  String code;
  String name;
  String sectionNumber;
  String activity;
  String time;
  String hours;

  AvailableSection({required this.code,required this.name, required this.sectionNumber, required this.activity, required this.time,
      required this.hours});

  @override
  String toString() {
    return 'Course{code: $code, name: $name, sectionNumber: $sectionNumber, activity: $activity, time: $time, hours: $hours} \n\n============\n\n';
  }
}
