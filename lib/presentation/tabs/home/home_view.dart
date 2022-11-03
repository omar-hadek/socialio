// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:socialio/presentation/components/animations/empty_contents_with_text_animation_view.dart';
// import '../../components/animations/error_animation_view.dart';
// import '../../components/animations/loading_animation_view.dart';
// import '../../components/post/posts_grid_view.dart';
// import '../../constants/strings.dart';

// class HomeView extends ConsumerWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final posts = ref.watch(allPostsProvider);
//     return RefreshIndicator(
//       onRefresh: () {
//         ref.refresh(allPostsProvider);
//         return Future.delayed(
//           const Duration(
//             seconds: 1,
//           ),
//         );
//       },
//       child: posts.when(
//         data: (posts) {
//           if (posts.isEmpty) {
//             return const EmptyContentsWithTextAnimationView(
//               text: Strings.noPostsAvailable,
//             );
//           } else {
//             return PostsGridView(
//               posts: posts,
//             );
//           }
//         },
//         error: (error, stackTrace) {
//           return const ErrorAnimationView();
//         },
//         loading: () {
//           return const LoadingAnimationView();
//         },
//       ),
//     );
//   }
// }
