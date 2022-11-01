import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/auth/infra/authenticator.dart';
import 'package:socialio/state/auth/models/auth_result.dart';
import 'package:socialio/state/auth/models/auth_state.dart';
import 'package:socialio/state/user_info/models/infra/user_info_storage.dart';

import '../../posts/type_defs/user_id.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook() async {
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) async {
    await _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName!,
        email: _authenticator.email);
  }
}
