import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:socialio/state/constants/firebase_field_name.dart';

import '../../posts/type_defs/post_id.dart';
import '../../posts/type_defs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId likedBy,
    required DateTime date,
  }) : super({
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: likedBy,
          FirebaseFieldName.date: date.toIso8601String(),
        });
}
