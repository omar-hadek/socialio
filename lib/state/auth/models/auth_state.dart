// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:socialio/state/auth/models/auth_result.dart';

import '../../posts/type_defs/user_id.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;
  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copiedWithIsLading(bool isLoading) =>
      AuthState(result: result, isLoading: isLoading, userId: userId);

  @override
  bool operator ==(covariant AuthState other) {
    if (identical(this, other)) return true;

    return other.result == result &&
        other.isLoading == isLoading &&
        other.userId == userId;
  }

  @override
  int get hashCode => result.hashCode ^ isLoading.hashCode ^ userId.hashCode;
}
