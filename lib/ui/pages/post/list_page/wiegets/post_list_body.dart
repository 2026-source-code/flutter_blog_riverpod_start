import 'package:flutter/material.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_page.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_vm.dart';
import 'package:flutter_blog/ui/pages/post/list_page/wiegets/post_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostListBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostListModel? model = ref.watch(postListProvider);
    PostListVM vm = ref.read(postListProvider.notifier);

    if (model == null) {
      return Center(child: CircularProgressIndicator());
    }

    List<Post> posts = model.posts;

    return SmartRefresher(
      controller: vm.refreshCtrl,
      onLoading: () async {
        Logger().d("onLoading");
        await vm.nextList();
      },
      onRefresh: () async {
        Logger().d("onRefresh");
        await vm.init();
      },
      enablePullDown: true,
      enablePullUp: true,
      child: ListView.separated(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PostDetailPage()));
            },
            child: PostListItem(posts[index]),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
