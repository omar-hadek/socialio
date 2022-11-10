// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:socialio/presentation/components/post/post_video_view.dart';
import 'package:socialio/state/image_upload/models/file_type.dart';

import '../../../state/posts/models/post.dart';
import 'post_image_view.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(
          post: post,
        );
      case FileType.video:
        return PostVideoView(post: post);
      default:
        return const SizedBox();
    }
  }
}
