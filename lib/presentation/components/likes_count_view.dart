// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/presentation/components/animations/small_error_animation_view.dart';

import 'package:socialio/state/likes/providers/post_likes_count_provider.dart';

import '../../state/posts/type_defs/post_id.dart';
import 'constants/strings.dart';

class LikedCountView extends ConsumerWidget {
  final PostId postId;
  const LikedCountView({
    required this.postId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(data: (data) {
      final personOrPeople =
          likesCount.value == 1 ? Strings.person : Strings.people;
      final likesText =
          '${likesCount.value} $personOrPeople ${Strings.likedThis}';
      return Text(likesText);
    }, error: (error, stackTrace) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
