import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/core/enums/navigation_type_enum.dart';
import 'package:flow_zero_waste/src/auth/domain/usecases/login_user.dart';
import 'package:flow_zero_waste/src/auth/domain/usecases/register_user.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

/// Auth cubit
@injectable
class AuthCubit extends Cubit<AuthState> {
  /// Auth cubit constructor
  AuthCubit({
    required LoginUser login,
    required RegisterUser register,
    required AuthProvider authProvider,
  })  : _loginUser = login,
        _registerUser = register,
        _authProvider = authProvider,
        super(AuthIdle());

  final LoginUser _loginUser;
  final RegisterUser _registerUser;
  final AuthProvider _authProvider;

  /// Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await _loginUser(
      LoginUserParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) {
        emit(AuthError(message: failure.message ?? 'Error while logging in'));
      },
      (user) {
        _authProvider.updateUserData(user);
        emit(AuthLoggedIn());
      },
    );

    emit(AuthIdle());
  }

  /// Register
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    emit(AuthLoading());
    final result = await _registerUser(
      RegisterUserParams(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      ),
    );

    result.fold(
      (failure) {
        emit(AuthError(message: failure.message ?? 'Error while registering'));
      },
      (_) {
        emit(AuthRegistered());
      },
    );

    emit(AuthIdle());
  }
}
