import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/auth/infra/authenticator.dart';
import 'package:socialio/state/auth/models/auth_result.dart';
import 'package:socialio/state/auth/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();

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
    if (result == AuthResult.success && userId != null) {}
  }
}