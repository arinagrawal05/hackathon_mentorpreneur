import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String phone;
  String name;
  int age;
  String type;
  bool isAvailable;
  bool isMale;
  List<String> skillsSelected;
  String occupation;
  String businessIdea;
  Timestamp timestamp;

  UserModel({
    required this.userId,
    required this.phone,
    required this.name,
    required this.age,
    required this.type,
    required this.isAvailable,
    required this.isMale,
    required this.skillsSelected,
    required this.occupation,
    required this.businessIdea,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userid': userId,
      'phone': phone,
      'name': name,
      'age': age,
      'type': type,
      'isAvailable': isAvailable,
      'isMale': isMale,
      'skills_selected': skillsSelected,
      'occupation': occupation,
      'bussiness_idea': businessIdea,
      'timestamp': timestamp.toDate().millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();
    return UserModel(
      userId: map['userid'] ?? "",
      phone: map['phone'] ?? "",
      name: map['name'] ?? "",
      age: map['age'] ?? 0,
      type: map['type'] ?? "",
      isAvailable: map['isAvailable'] ?? false,
      isMale: map['isMale'] ?? false,
      skillsSelected: List<String>.from(map['skills_selected'] ?? []),
      occupation: map['occupation'] ?? "",
      businessIdea: map['bussiness_idea'] ?? "",
      timestamp: map['timestamp'] != null ? map['timestamp'] : Timestamp.now(),
    );
  }
  factory UserModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('Input map cannot be null');
    }

    return UserModel(
      userId: map['userid'] ?? "NA",
      phone: map['phone'],
      name: map['name'],
      age: map['age'],
      type: map['type'],
      isAvailable: map['isAvailable'] ?? false,
      isMale: map['isMale'] ?? false,
      skillsSelected: List<String>.from(map['skills_selected'] ?? []),
      occupation: map['occupation'],
      businessIdea: map['bussiness_idea'],
      timestamp: map['timestamp'] != null
          ? Timestamp.fromDate(
              DateTime.fromMillisecondsSinceEpoch(map['timestamp']))
          : Timestamp.now(),
    );
  }
  String toJson() => json.encode(toMap());

  // factory UserProfileModel.fromJson(String source) =>
  //     UserProfileModel.fromMap(json.decode(source));
}
