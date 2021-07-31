import 'package:core/utils/humanize_duration.dart';
import 'package:flutter/material.dart';

import '../../entities/post.dart';
import '../avatar/avatar_widget.dart';
import '../spacers/spacers.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final void Function()? onPressed;
  const PostWidget({Key? key, required this.post, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.all(15),
        elevation: 5,
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AvatarWidget(
                    cor: Theme.of(context).primaryColor,
                    image: post.author.image,
                    width: 50,
                  ),
                  const SpacerW(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author.authorName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SpacerH(2),
                      Text(
                        Humanize().differenceDateTimeNow(post.published),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SpacerH(15),
              Text(post.content),
              const SpacerH(40),
            ],
          ),
        ),
      ),
    );
  }
}
