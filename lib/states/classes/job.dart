import 'package:json_annotation/json_annotation.dart';

// Create job.g.dart with command: dart run build_runner build
part 'job.g.dart';

// Json serializable user class
@JsonSerializable()
class Job {
  final int id;
  final int userID;

  Job(this.id, this.userID);

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
  Map<String, dynamic> toJson() => _$JobToJson(this);
}
