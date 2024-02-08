// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:reaction_askany/models/emotions.dart';

class CommentModel {
  String id;
  String commenterId;
  String? commentorName;
  String? commentText;
  String? commentorImage;
  String analectId;

  Map<Emotions, int> commentReactionCount;
  // Map<Emotions, String>? commentReactors;
  int getReactionCount(Emotions emotion) => commentReactionCount[emotion] ?? 0;
  int get totalReactionCount => commentReactionCount.values.fold(0, (previousValue, element) => previousValue + element);
  DateTime? timestamp;
  CommentModel({
    required this.id,
    required this.commenterId,
    this.commentorName,
    this.commentText,
    required this.analectId,
    this.commentorImage,
    this.commentReactionCount = const <Emotions, int>{},
    // this.commentReactors = const <Emotions, String>{},
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'commenterId': commenterId,
      'commentorName': commentorName,
      'commentText': commentText,
      'analectId': analectId,
      'commentorImage': commentorImage,
      'commentReactionCount': commentReactionCount.map((key, value) => MapEntry(key.index, value)),
      // 'commentReactors': commentReactors,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'totalReactionCount':totalReactionCount,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id:  map['id'] as String,
      commenterId:
          map['commenterId'] as String,
      commentorName:
          map['commentorName'] != null ? map['commentorName'] as String : null,
      commentText:
          map['commentText'] != null ? map['commentText'] as String : null,
      analectId: map['analectId'] as String,
      commentorImage:
          map['commentorImage'] != null ? map['commentorImage'] as String : null,
      commentReactionCount: map['commentReactionCount'] != null
          ? Map<Emotions, int>.from(
              (map['commentReactionCount'] as Map).map((key, value) => MapEntry(Emotions.values[key as int], value as int)))
          : {},
      // commentReactors: map['commentReactors'] != null
      //     ? Map<Emotions, String>.from(
      //         (map['commentReactors'] as Map<Emotions, String>))
      //     : null,
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CommentModel copyWith({
    String? id,
    String? commenterId,
    String? commentorName,
    String? commentText,
    String? analectId,
    String? commentorImage,
    Map<Emotions, int>? commentReactionCount,
    Map<Emotions, String>? commentReactors,
    DateTime? timestamp,
  }) {
    return CommentModel(
      id: id ?? this.id,
      commenterId: commenterId ?? this.commenterId,
      commentorName: commentorName ?? this.commentorName,
      commentText: commentText ?? this.commentText,
      analectId: analectId ?? this.analectId,
      commentorImage: commentorImage ?? this.commentorImage,
      commentReactionCount: commentReactionCount ?? this.commentReactionCount,
      // commentReactors: commentReactors ?? this.commentReactors,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() {
    return 'CommentModel(id: $id, commenterId: $commenterId, commentorName: $commentorName, commentText: $commentText, analectId: $analectId,commenterImage: $commentorImage, commentReactionCount: $commentReactionCount, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.commenterId == commenterId &&
        other.commentorName == commentorName &&
        other.commentText == commentText &&
        other.analectId == analectId &&
        other.commentorImage == commentorImage &&
        mapEquals(other.commentReactionCount, commentReactionCount) &&
        // mapEquals(other.commentReactors, commentReactors) &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        commenterId.hashCode ^
        commentorName.hashCode ^
        commentText.hashCode ^
        analectId.hashCode ^
        commentorImage.hashCode ^
        commentReactionCount.hashCode ^
        // commentReactors.hashCode ^
        timestamp.hashCode;
  }
}
