import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/constants/firebase_collection_name.dart';
import 'package:socialio/state/constants/firebase_field_name.dart';

import '../models/post.dart';
import '../type_defs/search_tem.dart';

final postsBySearchTermProvider =
    StreamProvider.family.autoDispose<Iterable<Post>, SearchTerm>(
  (ref, searchTerm) {
    final controller = StreamController<Iterable<Post>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.posts)
        .orderBy(FirebaseFieldName.createdAt, descending: true)
        .snapshots()
        .listen((snapshot) {
      final posts = snapshot.docs.map((doc) {
        return Post(postId: doc.id, json: doc.data());
      }).where(
        (post) => post.message.toLowerCase().contains(
              searchTerm.toLowerCase(),
            ),
      );
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
