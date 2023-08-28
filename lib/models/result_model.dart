class Result {
  String isHeld, usn, name, branch, semester, sgpa;
  List<String> subCodes, subjects, grades;

  Result({
    required this.isHeld,
    required this.usn,
    required this.name,
    required this.branch,
    required this.semester,
    required this.sgpa,
    required this.subCodes,
    required this.subjects,
    required this.grades,
  });
}

class Subject {
  String code, name, grade;

  Subject({
    required this.code,
    required this.name,
    required this.grade,
  });
}
