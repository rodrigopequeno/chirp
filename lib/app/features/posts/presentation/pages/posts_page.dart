import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:chirp/app/features/posts/presentation/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:get/get.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Get.find<AuthCubit>().logout();
              Get.offAllNamed('/');
            },
          ),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider<PostsCubit>(
          create: (context) => Get.find<PostsCubit>()..getPosts(),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is PostsError) {
          asuka.showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is PostsLoading || state is PostsInitial) {
          return _buildLoading();
        } else if (state is PostsError) {
          return _buildError(context, state);
        } else if (state is PostsSuccess) {
          return _buildPosts(state);
        }
        return Container();
      },
    );
  }

  Center _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  RefreshIndicator _buildError(BuildContext context, PostsError state) {
    return RefreshIndicator(
      onRefresh: context.read<PostsCubit>().getPosts,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(state.message),
            ElevatedButton(
              onPressed: () async =>
                  await context.read<PostsCubit>().getPosts(),
              child: const Text('UPDATE'),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildPosts(PostsSuccess state) {
    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        final post = state.posts[index];
        return PostWidget(post: post);
      },
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed("/add-post");
      },
      child: const Icon(Icons.add),
    );
  }
}
