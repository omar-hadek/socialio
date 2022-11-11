import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/auth/providers/auth_state_provider.dart';
import 'package:socialio/state/comments/providers/delete_comment_provider.dart';
import 'package:socialio/state/comments/providers/send_comment_provider.dart';
import 'dart:developer' as devtools show log;

import 'package:socialio/state/image_upload/providers/image_uploader_provider.dart';
import 'package:socialio/state/posts/providers/delete_post_provider.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  final isLoadingImage = ref.watch(imageUploaderProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  return authState.isLoading ||
      isLoadingImage ||
      isDeletingComment ||
      isDeletingPost ||
      isSendingComment;
});
