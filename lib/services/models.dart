import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class User {
  final String ID;
  final String email;
  final String name;
  String type;
  List<String> tags;

  User({
    this.ID = '',
    this.email = '',
    this.name = '',
    this.type = '',
    this.tags = const ['a', 'b'],
  });

  Map<String, dynamic> toJson() => {
        'ID': ID,
        'name': name,
        'email': email,
        'type': type,
        'tags': tags,
      };

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Student {
  final String ID;
  final String name;
  final String email;
  final String grad_yr;

  Student({
    this.ID = '',
    this.name = '',
    this.email = '',
    this.grad_yr = '',
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}

@JsonSerializable()
class Prof {
  final String ID;
  final String dept;
  final String email;
  final List<String> spec;

  Prof({
    this.ID = '',
    this.dept = '',
    this.email = '',
    this.spec = const [],
  });
  factory Prof.fromJson(Map<String, dynamic> json) => _$ProfFromJson(json);
}

@JsonSerializable()
class Projects {
  final String ID;
  final String date;
  final String description;
  final String name;
  final String prof;
  final List<String> tags;

  Projects({
    this.ID = '',
    this.date = '',
    this.description = '',
    this.name = '',
    this.prof = '',
    this.tags = const [],
  });
  factory Projects.fromJson(Map<String, dynamic> json) =>
      _$ProjectsFromJson(json);
}

@JsonSerializable()
class Feed {
  final String ID;
  final String News;
  final String Time;

  Feed({
    this.ID = '',
    this.News = '',
    this.Time = '',
  });
  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}

@JsonSerializable()
class Interests {
  final String ID;
  final String email;
  final List<String> tags;

  Interests({
    this.ID = '',
    this.email = '',
    this.tags = const [],
  });
  factory Interests.fromJson(Map<String, dynamic> json) =>
      _$InterestsFromJson(json);
}
