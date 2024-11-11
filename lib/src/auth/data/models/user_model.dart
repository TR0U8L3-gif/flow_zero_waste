import 'package:equatable/equatable.dart';

/// User model
class UserModel extends Equatable {
  /// User model constructor
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  /// User id
  final String id;
  /// User name
  final String name;
  /// User email
  final String email;
  /// User phone number
  final String phoneNumber;
  
  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phoneNumber,
  ];

  /// Convert user model to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  /// Convert json to user model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }
}
