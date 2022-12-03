import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/widgets/bottom_loader.dart';
import 'package:flutter_infinite_list/posts/widgets/post_list_item.dart';
import 'package:nb_utils/nb_utils.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: colorPrimary,
                title: Text("Home"),
              ),
              body: Container(
                width: context.width(),
                height: context.height(),
                child: Column(
                  children: [
                    10.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: filter_color),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: SizedBox(
                                  child: Text(
                                'Köpek',
                                style: TextStyle(
                                    fontFamily: 'Halvetica', fontSize: 15),
                              )),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: filter_color),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: SizedBox(
                                  child: Text(
                                'Kedi',
                                style: TextStyle(
                                    fontFamily: 'Halvetica', fontSize: 15),
                              )),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: filter_color),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: SizedBox(
                                  child: Text(
                                'Kuş',
                                style: TextStyle(
                                    fontFamily: 'Halvetica', fontSize: 15),
                              )),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: filter_color),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: SizedBox(
                                  child: Text(
                                'Balık',
                                style: TextStyle(
                                    fontFamily: 'Halvetica', fontSize: 15),
                              )),
                            )),
                      ],
                    ),
                    10.height,
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return index >= state.posts.length
                              ? const BottomLoader()
                              : PostListItem(post: state.posts[index]);
                        },
                        itemCount: state.hasReachedMax
                            ? state.posts.length
                            : state.posts.length + 1,
                        controller: _scrollController,
                      ),
                    ),
                  ],
                ),
              ),
            );
          case PostStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
