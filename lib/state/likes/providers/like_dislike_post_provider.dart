import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/constants/firebase_collection_name.dart';
import 'package:socialio/state/constants/firebase_field_name.dart';
import 'package:socialio/state/likes/models/like.dart';
import 'package:socialio/state/likes/models/like_dislike_request.dart';

final likeDislikePostProvider =
    FutureProvider.family.autoDispose<bool, LikeDislikeRequest>(
  (ref, request) async {
    final query = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldName.postId, isEqualTo: request.postId)
        .where(FirebaseFieldName.userId, isEqualTo: request.userId)
        .get();

    final hasLiked = await query.then(
      (snapshot) => snapshot.docs.isNotEmpty,
    );

    if (hasLiked) {
      try {
        await query.then((snapshot) async {
          for (final doc in snapshot.docs) {
            doc.reference.delete();
          }
        });
        return true;
      } catch (_) {
        return false;
      }
    } else {
      try {
        final like = Like(
            postId: request.postId,
            likedBy: request.userId,
            date: DateTime.now());

        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.likes)
            .add(like);
        return true;
      } catch (e) {
        return false;
      }
    }
  },
);
