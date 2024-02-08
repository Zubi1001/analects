// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnalectModel {
  String analectId;
  String creatorId;
  String creatorName;
  String analectName;
  String category;
  String image;
  String audioUrl;
  int noOfListen;
  int noOfView;
  int timestamp;

  
  AnalectModel({
    required this.analectId,
    required this.creatorId,
    required this.creatorName,
    required this.analectName,
    required this.category,
    required this.image,
    required this.audioUrl,
    required this.noOfListen,
    required this.noOfView,
    required this.timestamp,
  });

  AnalectModel copyWith({
    String? analectId,
    String? creatorId,
    String? creatorName,
    String? analectName,
    String? category,
    String? image,
    String? audioUrl,
    int? noOfListen,
    int? noOfView,
    int? timestamp,
  }) {
    return AnalectModel(
      analectId: analectId ?? this.analectId,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      analectName: analectName ?? this.analectName,
      category: category ?? this.category,
      image: image ?? this.image,
      audioUrl: audioUrl ?? this.audioUrl,
      noOfListen: noOfListen ?? this.noOfListen,
      noOfView: noOfView ?? this.noOfView,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'analectId': analectId,
      'creatorId': creatorId,
      'creatorName': creatorName,
      'analectName': analectName,
      'category': category,
      'image': image,
      'audioUrl': audioUrl,
      'noOfListen': noOfListen,
      'noOfView': noOfView,
      'timestamp': timestamp,
    };
  }

  factory AnalectModel.fromMap(Map<String, dynamic> map) {
    return AnalectModel(
      analectId: map['analectId'] as String,
      creatorId: map['creatorId'] as String,
      creatorName: map['creatorName'] as String,
      analectName: map['analectName'] as String,
      category: map['category'] as String,
      image: map['image'] as String,
      audioUrl: map['audioUrl'] as String,
      noOfListen: map['noOfListen'] as int,
      noOfView: map['noOfView'] as int,
      timestamp: map['timestamp'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnalectModel.fromJson(String source) => AnalectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnalectModel(analectId: $analectId, creatorId: $creatorId, creatorName: $creatorName, analectName: $analectName, category: $category, image: $image, audioUrl: $audioUrl, noOfListen: $noOfListen, noOfView: $noOfView, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant AnalectModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.analectId == analectId &&
      other.creatorId == creatorId &&
      other.creatorName == creatorName &&
      other.analectName == analectName &&
      other.category == category &&
      other.image == image &&
      other.audioUrl == audioUrl &&
      other.noOfListen == noOfListen &&
      other.noOfView == noOfView &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return analectId.hashCode ^
      creatorId.hashCode ^
      creatorName.hashCode ^
      analectName.hashCode ^
      category.hashCode ^
      image.hashCode ^
      audioUrl.hashCode ^
      noOfListen.hashCode ^
      noOfView.hashCode ^
      timestamp.hashCode;
  }
}
