import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/auth/providers/auth_state_provider.dart';
import 'package:socialio/state/posts/type_defs/user_id.dart';

final userIdProvider = Provider<UserId?>((ref) {
  return ref.watch(authStateNotifierProvider).userId;
});
