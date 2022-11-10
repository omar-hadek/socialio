// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import '../../posts/type_defs/post_id.dart';
import '../../posts/type_defs/user_id.dart';

@immutable
class LikeDislikeRequest {
  final PostId postId;
  final UserId userId;
  const LikeDislikeRequest({
    required this.postId,
    required this.userId,
  });
}
