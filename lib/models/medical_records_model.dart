class MedicalRecord {
  final String id;
  final String name;
  final String date;
  final String type;
  final String lastModify;
  final int exam;

  MedicalRecord({
    required this.id,
    required this.name,
    required this.date,
    required this.type,
    required this.lastModify,
    required this.exam
  });
}