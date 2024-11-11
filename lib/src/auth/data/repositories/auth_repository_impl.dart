import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flow_zero_waste/src/auth/data/mappers/user_mapper.dart';
import 'package:flow_zero_waste/src/auth/data/models/auth_model.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';
import 'package:flow_zero_waste/src/auth/domain/entities/user.dart';
import 'package:flow_zero_waste/src/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

/// Auth repository implementation
@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  /// Auth repository constructor
  const AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required AuthLocalDataSource authLocalDataSource,
    required UserMapper userMapper,
    required LoggerManager logger,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDataSource = authLocalDataSource,
        _userMapper = userMapper,
        _logger = logger;

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final UserMapper _userMapper;
  final LoggerManager _logger;

  @override
  ResultFuture<Failure, User?> getCurrentUser() async {
    _logger.trace(message: 'Getting current user from [local]');
    AuthModel? authModel;
    try {
      authModel = await _authLocalDataSource.getAuth();
    } catch (e, st) {
      _logger.error(
        message: 'Error while getting current user',
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: 'Error while getting current user'));
    }
    _logger.trace(
      message: 'Received current user [local]: ${authModel.runtimeType}',
    );

    if (authModel == null) {
      return const Right(null);
    }

    _logger.trace(message: 'Getting current user from [remote]');

    UserModel? userModel;
    try {
      userModel = await _authRemoteDataSource.getCurrentUser();
    } catch (e, st) {
      _logger.warning(
        message: 'Unable to fetch user from remote',
        error: e,
        stackTrace: st,
      );
    }

    final user = _userMapper.from(userModel ?? authModel.user);

    _logger.trace(
      message: 'Received current user [remote]: ${user.runtimeType}',
    );

    return Right(user);
  }

  @override
  ResultFuture<Failure, User> login({
    required String email,
    required String password,
  }) async {
    _logger.trace(message: 'Logging in');

    AuthModel? authModel;
    try {
      authModel = await _authRemoteDataSource.login(
        email: email,
        password: password,
      );
    } catch (e, st) {
      _logger.error(
        message: 'Error while logging in',
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: 'Error while logging in'));
    }

    final user = _userMapper.from(authModel.user);

    try {
      await _authLocalDataSource.saveAuth(authModel);
    } catch (e, st) {
      _logger.error(
        message: 'Error while saving user auth',
        error: e,
        stackTrace: st,
      );
    }

    return Right(user);
  }

  @override
  ResultFuture<Failure, void> logout() async {
    try {
      await _authLocalDataSource.logout();
      return const Right(null);
    } catch (e, st) {
      _logger.error(
        message: 'Error while logging out',
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: 'Error while logging out'));
    }
  }

  @override
  ResultFuture<Failure, void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      await _authRemoteDataSource.register(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      return const Right(null);
    } catch (e, st) {
      _logger.error(
        message: 'Error while registering',
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: 'Error while registering'));
    }
  }
}
