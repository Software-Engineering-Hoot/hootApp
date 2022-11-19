import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:nb_utils/nb_utils.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: (MediaQuery.of(context).size.width * 0.37),
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: orange,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("1"),
                Text("2"),
                Text("3"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("4"),
              Text("5"),
              Text("6"),
            ],
          )
        ],
      ),
    );
  }
}
