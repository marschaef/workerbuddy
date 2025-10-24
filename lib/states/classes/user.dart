import 'package:json_annotation/json_annotation.dart';

// Create user.g.dart with command: dart run build_runner build
part 'user.g.dart';

// Json serializable user class
@JsonSerializable()
class User {
  final int id;
  final String email;

  User(this.id, this.email);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
