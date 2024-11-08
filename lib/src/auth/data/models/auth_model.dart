import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';

/// Login model
class AuthModel extends Equatable {
  /// Login model constructor
  const AuthModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  /// User model
  final UserModel user;

  /// Access token
  final String accessToken;

  /// Access token
  final String refreshToken;

  @override
  List<Object?> get props => [user, accessToken, refreshToken];

  /// Convert login model to json
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  /// Convert json to login model
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
