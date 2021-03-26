import 'package:asuka/asuka.dart' as asuka;
import 'package:chirp/app/core/widgets/button/button_widget.dart';
import 'package:chirp/app/core/widgets/scaffold/scaffold_widget.dart';
import 'package:chirp/app/core/widgets/spacers/spacers.dart';
import 'package:chirp/app/features/posts/presentation/widgets/logout_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/cubit/auth_cubit.dart';
import '../../../../core/widgets/post/post_widget.dart';
import '../cubit/posts_cubit.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      loggedUser: (Get.find<AuthCubit>().state as AuthLogged).user,
      floatingActionButton: _floatingActionButton(),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: "Logout",
          onPressed: () async {
            asuka.showDialog(
              builder: (context) => LogoutDialogWidget(
                confirmation: () async {
                  Navigator.pop(context);
                  await Get.find<AuthCubit>().logout();
                  Get.offAllNamed('/');
                },
              ),
            );
          },
        ),
      ],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: BlocProvider(
        create: (context) => Get.find<PostsCubit>()..getPosts(),
        child: BlocConsumer<PostsCubit, PostsState>(
          listener: _listener,
          builder: (context, state) {
            if (state is PostsLoading || state is PostsInitial) {
              return _buildLoading();
            } else if (state is PostsError) {
              return _buildError(context, state);
            } else if (state is PostsSuccess) {
              return _buildPosts(context, state);
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _listener(context, state) {
    if (state is PostsError) {
      asuka.showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Center _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, PostsError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SpacerH(20),
          ButtonWidget(
            onPressed: () async => await context.read<PostsCubit>().getPosts(),
            text: "UPDATE",
            width: 120,
            colorButton: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }

  Widget _buildPosts(BuildContext context, PostsSuccess state) {
    return RefreshIndicator(
      onRefresh: context.read<PostsCubit>().getPosts,
      child: ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (context, index) {
          final post = state.posts[index];
          return PostWidget(post: post);
        },
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed("/add-post");
      },
      tooltip: "Create post",
      child: const Icon(Icons.add_comment_rounded),
    );
  }
}
