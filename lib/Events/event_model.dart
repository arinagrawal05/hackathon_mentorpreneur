import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String eventId;
  List<String> images;
  String name;
  String location;
  DateTime eventTime;
  DateTime endDate; // Added property
  String description;
  double lat;
  double long;
  List<String> tags;
  List<String> moreInfo;
  bool isVisible;
  bool isEditorPick; // Added property
  int price; // Added property

  EventModel({
    required this.eventId,
    required this.images,
    required this.name,
    required this.location,
    required this.eventTime,
    required this.endDate, // Added parameter
    required this.description,
    required this.lat,
    required this.long,
    required this.tags,
    required this.moreInfo,
    required this.isVisible,
    required this.isEditorPick, // Added parameter
    required this.price, // Added parameter
  });

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'images': images,
      'name': name,
      'location': location,
      'eventTime': eventTime,
      'endDate': endDate, // Added property
      'description': description,
      'lat': lat,
      'long': long,
      'tags': tags,
      'moreInfo': moreInfo,
      'isVisible': isVisible,
      'isEditorPick': isEditorPick, // Added property
      'price': price, // Added property
    };
  }

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();
    return EventModel(
      eventId: map['eventId'] ?? "",
      images: List<String>.from(map['images'] ?? []),
      name: map['name'] ?? "NA",
      location: map['location'] ?? "NA",
      eventTime:
          map['eventTime'] != null ? map['eventTime'].toDate() : DateTime.now(),
      endDate:
          map['endDate'] != null ? map['endDate'].toDate() : DateTime.now(),
      description: map['description'] ?? "NA",
      lat: map['lat'] ?? 0.0,
      long: map['long'] ?? 0.0,
      tags: List<String>.from(map['tags'] ?? []),
      moreInfo: List<String>.from(map['moreInfo'] ?? []),
      isVisible: map['isVisible'] ?? true,
      isEditorPick: map['isEditorPick'] ?? false, // Added property
      price: map['price'] ?? 0, // Added property
    );
  }

  String toJson() => json.encode(toMap());

  // factory EventModel.fromJson(String source) =>
  //     EventModel.fromMap(json.decode(source));
}
