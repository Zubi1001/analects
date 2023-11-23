// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CreatorSubscrptionModel {
  String tier;
  bool recommended;
  int price;
  List<dynamic> advantages;
  CreatorSubscrptionModel({
    required this.tier,
    required this.recommended,
    required this.price,
    required this.advantages,
  });

  CreatorSubscrptionModel copyWith({
    String? tier,
    bool? recommended,
    int? price,
    List<dynamic>? advantages,
  }) {
    return CreatorSubscrptionModel(
      tier: tier ?? this.tier,
      recommended: recommended ?? this.recommended,
      price: price ?? this.price,
      advantages: advantages ?? this.advantages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tier': tier,
      'recommended': recommended,
      'price': price,
      'advantages': advantages,
    };
  }

  factory CreatorSubscrptionModel.fromMap(Map<String, dynamic> map) {
    return CreatorSubscrptionModel(
      tier: map['tier'] as String,
      recommended: map['recommended'] as bool,
      price: map['price'] as int,
      advantages: List<dynamic>.from((map['advantages'] as List<dynamic>),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatorSubscrptionModel.fromJson(String source) =>
      CreatorSubscrptionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreatorSubscrptionModel(tier: $tier, recommended: $recommended, price: $price, advantages: $advantages)';
  }

  @override
  bool operator ==(covariant CreatorSubscrptionModel other) {
    if (identical(this, other)) return true;

    return other.tier == tier &&
        other.recommended == recommended &&
        other.price == price &&
        listEquals(other.advantages, advantages);
  }

  @override
  int get hashCode {
    return tier.hashCode ^
        recommended.hashCode ^
        price.hashCode ^
        advantages.hashCode;
  }
}
