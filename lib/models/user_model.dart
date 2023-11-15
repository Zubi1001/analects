import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String id;
  String email;
  String profileImage;
  String name;

  UserModel({
    required this.id,
    required this.email,
    this.profileImage = "",
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'profileImage': profileImage,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      profileImage: map['profileImage'] as String,
      name: map['name'] as String,
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
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, profileImage: $profileImage, name: $name)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.profileImage == profileImage &&
      other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      profileImage.hashCode ^
      name.hashCode;
  }
}
