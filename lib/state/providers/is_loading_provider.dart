import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/auth/providers/auth_state_provider.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);

  print('auth state is loading ${authState.isLoading}');
  return authState.isLoading;
});
