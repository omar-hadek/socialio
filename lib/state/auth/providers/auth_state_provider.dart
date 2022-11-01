import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/auth/models/auth_state.dart';
import 'package:socialio/state/auth/notifiers/auth_state_notifier.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});
