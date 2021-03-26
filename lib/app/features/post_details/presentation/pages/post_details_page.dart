import 'package:asuka/asuka.dart' as asuka;
import 'package:chirp/app/core/widgets/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/cubit/auth_cubit.dart';
import '../../../../core/entities/post.dart';
import '../../../../core/widgets/loading_indicator/loading_indicator_widget.dart';
import '../cubit/post_details_cubit.dart';
import '../widgets/delete_dialog_widget.dart';
import '../widgets/edit_dialog_widget.dart';

class PostDetailsPage extends StatefulWidget {
  late final Post model;
  late final bool isAuthor;

  PostDetailsPage({Key? key}) : super(key: key) {
    model = Get.arguments as Post;
    isAuthor =
        model.author.id == (Get.find<AuthCubit>().state as AuthLogged).user.uid;
  }

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final loading = LoadingIndicatorImpl();

  final cubit = Get.find<PostDetailsCubit>();
  late Post post;

  @override
  void initState() {
    post = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostDetailsCubit>(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Details'),
          centerTitle: true,
          actions: [
            Visibility(
              visible: widget.isAuthor,
              child: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    asuka.showDialog(
                      builder: (context) => EditDialogWidget(
                        content: post.content,
                        edit: (newContent) async {
                          Navigator.pop(context);
                          await cubit.edit(post.id, newContent);
                        },
                      ),
                    );
                  }),
            ),
            Visibility(
              visible: widget.isAuthor,
              child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    asuka.showDialog(
                      builder: (context) => DeleteDialogWidget(
                        delete: () async {
                          Navigator.pop(context);
                          await cubit.delete(post.id);
                          Get.offAllNamed('/posts');
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<PostDetailsCubit, PostDetailsState>(
        listener: (context, state) {
          if (state is PostDetailsLoading) {
            loading.show();
          } else if (loading.isShow) {
            loading.hide();
          }
          if (state is PostDetailsError) {
            asuka.showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is PostDetailsDeleteSuccess) {
            asuka.showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is PostDetailsEditSuccess) {
            post = state.editedPost;
            asuka.showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return PostWidget(post: post);
        },
      ),
    );
  }
}
