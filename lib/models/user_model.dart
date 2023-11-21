import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String id;
  String email;
  String profileImage;
  String name;
  bool creator;
  String analects;
  String category;

  UserModel({
    required this.id,
    required this.email,
    this.profileImage = "",
    required this.name,
    required this.creator,
    required this.analects,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'profileImage': profileImage,
      'name': name,
      'creator': creator,
      'analects': analects,
      'category': category,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      profileImage: map['profileImage'] as String,
      name: map['name'] as String,
      creator: map['creator'] as bool,
      analects: map['analects'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? email,
    String? profileImage,
    String? name,
    bool? creator,
    String? analects,
    String? category,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
      creator: creator ?? this.creator,
      analects: analects ?? this.analects,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, profileImage: $profileImage, name: $name, creator: $creator, analects: $analects, category: $category)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.profileImage == profileImage &&
      other.name == name &&
      other.creator == creator &&
      other.analects == analects &&
      other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      profileImage.hashCode ^
      name.hashCode ^
      creator.hashCode ^
      analects.hashCode ^
      category.hashCode;
  }
}
