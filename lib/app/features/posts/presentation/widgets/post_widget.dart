import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/entities/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(post.content),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Author: ${post.author.authorName}"),
                const Spacer(),
                Text(
                    "Date: ${DateFormat("dd/MM/yyyy").format(post.published)}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
