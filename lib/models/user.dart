import 'package:flutter/foundation.dart';

class User {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              username == other.username &&
              passwordHash == other.passwordHash &&
              role == other.role &&
              createdAt == other.createdAt;

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ passwordHash.hashCode ^ role.hashCode ^ createdAt.hashCode;


  int? id;
  String username;
  String passwordHash;
  String role;
  DateTime? createdAt; // Added this

  User({
    this.id,
    required this.username,
    required this.passwordHash,
    required this.role,
    this.createdAt, // Added this
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password_hash': passwordHash,
      'role': role,
      'created_at': createdAt?.toIso8601String(), // Added this
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      passwordHash: map['password_hash'],
      role: map['role'],
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at']) : null, // Added this
    );
  }
}