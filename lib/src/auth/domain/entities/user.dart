import 'package:equatable/equatable.dart';

/// User entity
class User extends Equatable {
  /// User constructor
  const User({
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
}
