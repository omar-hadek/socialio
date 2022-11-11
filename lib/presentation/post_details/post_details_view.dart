import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialio/enums/date_sorting.dart';
import 'package:socialio/presentation/components/animations/error_animation_view.dart';
import 'package:socialio/presentation/components/animations/loading_animation_view.dart';
import 'package:socialio/presentation/components/comment/compact_comment_column.dart';
import 'package:socialio/presentation/components/dialogs/alert_dialog_model.dart';
import 'package:socialio/presentation/components/dialogs/delete_dialog.dart';
import 'package:socialio/presentation/components/like_button.dart';
import 'package:socialio/presentation/components/likes_count_view.dart';
import 'package:socialio/presentation/components/post/post_date_view.dart';
import 'package:socialio/presentation/components/post/post_display_name_and_message_view.dart';
import 'package:socialio/presentation/components/post/post_image_or_video_view.dart';
import 'package:socialio/presentation/components/post_comments/post_comments_view.dart';
import 'package:socialio/state/comments/models/post_comments_request.dart';
import 'package:socialio/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:socialio/state/posts/providers/delete_post_provider.dart';
import 'package:socialio/state/posts/providers/spesific_post_with_comments_provider.dart';

import '../../state/posts/models/post.dart';
import '../components/animations/small_error_animation_view.dart';
import '../constants/strings.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({super.key, required this.post});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
        postId: widget.post.postId,
        limit: 3,
        sortByCreatedAt: true,
        dateSorting: DateSorting.oldestOnTop);

    final postWithComments = ref.watch(
      specificPostWithCommentsProvider(request),
    );

    final canDeletePost = ref.watch(
      canCurrentUserDeletePostProvider(widget.post),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          postWithComments.when(
            data: (postWithComments) {
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  final url = postWithComments.post.fileUrl;
                  Share.share(
                    url,
                    subject: Strings.checkOutThisPost,
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return const SmallErrorAnimationView();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          if (canDeletePost.value ?? false)
            IconButton(
                onPressed: () async {
                  final shouldDeletePost = await const DeleteDialog(
                          titleOfObjectToDelete: Strings.post)
                      .present(context)
                      .then((shouldDelete) => shouldDelete ?? false);

                  if (shouldDeletePost) {
                    await ref.read(deletePostProvider.notifier).deletePost(
                          post: widget.post,
                        );
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      body: postWithComments.when(
        data: (postWithComments) {
          final postId = postWithComments.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(post: postWithComments.post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (postWithComments.post.allowsLikes)
                      LikeButton(postId: postId),
                    if (postWithComments.post.allowsComments)
                      IconButton(
                        icon: const Icon(Icons.mode_comment_outlined),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostCommentsView(postId: postId),
                            ),
                          );
                        },
                      ),
                  ],
                ),
                PostDisplayNameAndMessageView(post: postWithComments.post),
                PostDateView(dateTime: postWithComments.post.createdAt),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white70,
                  ),
                ),
                CompactCommentColumn(comments: postWithComments.comments),
                if (postWithComments.post.allowsLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LikedCountView(postId: postId),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
