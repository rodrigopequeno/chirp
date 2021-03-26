import 'package:chirp/app/core/widgets/avatar/avatar_widget.dart';
import 'package:chirp/app/core/widgets/spacers/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/entities/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/details", arguments: post);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    AvatarWidget(
                      cor: Theme.of(context).primaryColor,
                      image: post.author.image,
                      width: 50,
                    ),
                  ],
                ),
                const SpacerW(15),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(post.author.authorName),
                          const SpacerW(10),
                          Text(DateFormat("dd/MM/yyyy").format(post.published)),
                        ],
                      ),
                      Text(post.content),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

// Column(
//                   children: [
//
//                     const SizedBox(
//                       height: 20,
//                     ),
//
//                     Text(
//                         "Date: ${DateFormat("dd/MM/yyyy").format(post.published)}"),
//                   ],
//                 ),
