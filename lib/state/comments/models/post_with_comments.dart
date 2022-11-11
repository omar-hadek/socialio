// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/equality.dart';
import 'package:flutter/material.dart';

import '../../posts/models/post.dart';
import 'comment.dart';

@immutable
class PostWithComments {
  final Post post;
  final Iterable<Comment> comments;
  const PostWithComments({
    required this.post,
    required this.comments,
  });

  @override
  bool operator ==(covariant PostWithComments other) {
    if (identical(this, other) &&
        const IterableEquality().equals(comments, other.comments)) return true;

    return other.post == post && other.comments == comments;
  }

  @override
  int get hashCode => post.hashCode ^ comments.hashCode;
}
