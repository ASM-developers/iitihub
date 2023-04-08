// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      ID: json['ID'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'ID': instance.ID,
      'email': instance.email,
      'name': instance.name,
      'type': instance.type,
    };

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      ID: json['ID'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      grad_yr: json['grad_yr'] as String? ?? '',
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'ID': instance.ID,
      'name': instance.name,
      'email': instance.email,
      'grad_yr': instance.grad_yr,
    };

Prof _$ProfFromJson(Map<String, dynamic> json) => Prof(
      ID: json['ID'] as String? ?? '',
      dept: json['dept'] as String? ?? '',
      email: json['email'] as String? ?? '',
      spec:
          (json['spec'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$ProfToJson(Prof instance) => <String, dynamic>{
      'ID': instance.ID,
      'dept': instance.dept,
      'email': instance.email,
      'spec': instance.spec,
    };

Projects _$ProjectsFromJson(Map<String, dynamic> json) => Projects(
      ID: json['ID'] as String? ?? '',
      Date: json['Date'] as String? ?? '',
      description: json['description'] as String? ?? '',
      name: json['name'] as String? ?? '',
      prof: json['prof'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$ProjectsToJson(Projects instance) => <String, dynamic>{
      'ID': instance.ID,
      'Date': instance.Date,
      'description': instance.description,
      'name': instance.name,
      'prof': instance.prof,
      'tags': instance.tags,
    };

Feed _$FeedFromJson(Map<String, dynamic> json) => Feed(
      ID: json['ID'] as String? ?? '',
      News: json['News'] as String? ?? '',
      Time: json['Time'] as String? ?? '',
    );

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'ID': instance.ID,
      'News': instance.News,
      'Time': instance.Time,
    };

Interests _$InterestsFromJson(Map<String, dynamic> json) => Interests(
      ID: json['ID'] as String? ?? '',
      email: json['email'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$InterestsToJson(Interests instance) => <String, dynamic>{
      'ID': instance.ID,
      'email': instance.email,
      'tags': instance.tags,
    };
