import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialio/enums/date_sorting.dart';
import 'package:socialio/presentation/components/dialogs/alert_dialog_model.dart';
import 'package:socialio/presentation/components/dialogs/delete_dialog.dart';
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
    );
  }
}
