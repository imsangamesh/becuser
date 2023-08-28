class MyHelper {
  static String giveMyDepartmentShort(String sem) {
    switch (sem) {
      case 'Artificial Intelligence':
        return 'AI-ML';
      case 'automibile':
        return 'AU';
      case 'Bio technology':
        return 'BT';
      case 'Computer Science':
        return 'CSE';
      case 'Civil Engineering':
        return 'CV';
      case 'Electronics and Communication':
        return 'ECE';
      case 'Electronics and Electricals':
        return 'EEE';
      case 'Electronics and Instrumentation':
        return 'EI';
      case 'Industrial Production':
        return 'IP';
      case 'Information Science':
        return 'ISE';
      case 'Mechanical Engineering':
        return 'ME';

      default:
        return 'unknown';
    }
  }

  static String giveMySemShort(String sem) {
    switch (sem) {
      case 'P cycle':
        return 'P - Cycle';
      case 'C cycle':
        return 'C - Cycle';
      case '3 - Semester':
        return 'III sem';
      case '4 - Semester':
        return 'IV sem';
      case '5 - Semester':
        return 'V sem';
      case '6 - Semester':
        return 'VI sem';
      case '7 - Semester':
        return 'VII sem';
      case '8 - Semester':
        return 'VIII sem';

      default:
        return 'unknown';
    }
  }
}
