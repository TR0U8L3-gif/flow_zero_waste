import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';
import 'package:flow_zero_waste/src/auth/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

/// Mapper class from [UserModel] to [User].
@singleton
class UserMapper extends Mapper<UserModel, User> {
  @override
  User from(UserModel object) {
    return User(
      id: object.id,
      name: object.name,
      email: object.email,
      phoneNumber: object.phoneNumber,
    );
  }

  @override
  UserModel to(User object) {
    return UserModel(
      id: object.id,
      name: object.name,
      email: object.email,
      phoneNumber: object.phoneNumber,
    );
  }
}
