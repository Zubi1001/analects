import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String id;
  String email;
  String profileImage;
  String name;
  bool creator;
  int analects;
  String category;
  String creatorBio;
  int followers;
  int noOfListener;
  int noOfSubscribers;
  int following;
  String creatorSubs;

  UserModel({
    required this.id,
    required this.email,
    required this.profileImage,
    required this.name,
    required this.creator,
    required this.analects,
    required this.category,
    required this.creatorBio,
    required this.followers,
    required this.noOfListener,
    required this.noOfSubscribers,
    required this.following,
    required this.creatorSubs,
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
      'creatorBio': creatorBio,
      'followers': followers,
      'noOfListener': noOfListener,
      'noOfSubscribers': noOfSubscribers,
      'following': following,
      'creatorSubs': creatorSubs,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      profileImage: map['profileImage'] as String,
      name: map['name'] as String,
      creator: map['creator'] as bool,
      analects: map['analects'] as int,
      category: map['category'] as String,
      creatorBio: map['creatorBio'] as String,
      followers: map['followers'] as int,
      noOfListener: map['noOfListener'] as int,
      noOfSubscribers: map['noOfSubscribers'] as int,
      following: map['following'] as int,
      creatorSubs: map['creatorSubs'] as String,
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
    int? analects,
    String? category,
    String? creatorBio,
    int? followers,
    int? noOfListener,
    int? noOfSubscribers,
    int? following,
    String? creatorSubs,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
      creator: creator ?? this.creator,
      analects: analects ?? this.analects,
      category: category ?? this.category,
      creatorBio: creatorBio ?? this.creatorBio,
      followers: followers ?? this.followers,
      noOfListener: noOfListener ?? this.noOfListener,
      noOfSubscribers: noOfSubscribers ?? this.noOfSubscribers,
      following: following ?? this.following,
      creatorSubs: creatorSubs ?? this.creatorSubs,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, profileImage: $profileImage, name: $name, creator: $creator, analects: $analects, category: $category, creatorBio: $creatorBio, followers: $followers, noOfListener: $noOfListener, noOfSubscribers: $noOfSubscribers, following: $following, creatorSubs: $creatorSubs)';
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
      other.category == category &&
      other.creatorBio == creatorBio &&
      other.followers == followers &&
      other.noOfListener == noOfListener &&
      other.noOfSubscribers == noOfSubscribers &&
      other.following == following &&
      other.creatorSubs == creatorSubs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      profileImage.hashCode ^
      name.hashCode ^
      creator.hashCode ^
      analects.hashCode ^
      category.hashCode ^
      creatorBio.hashCode ^
      followers.hashCode ^
      noOfListener.hashCode ^
      noOfSubscribers.hashCode ^
      following.hashCode ^
      creatorSubs.hashCode;
  }
}
