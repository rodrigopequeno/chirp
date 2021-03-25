import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/character_limit.dart';
import '../../../../core/widgets/loading_indicator/loading_indicator_widget.dart';
import '../cubit/add_post_cubit.dart';

class AddPostPage extends StatelessWidget {
  final loading = LoadingIndicatorImpl();
  final TextEditingController contentController = TextEditingController();

  AddPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create post'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider<AddPostCubit>(
          create: (context) => Get.find<AddPostCubit>(),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is AddPostLoading) {
          loading.show();
        } else if (loading.isShow) {
          loading.hide();
        }

        if (state is AddPostError) {
          asuka.showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is AddPostSuccess) {
          Get.offNamed('/posts');
        }
      },
      builder: (context, state) {
        return Column(
          children: <Widget>[
            TextFormField(
              controller: contentController,
              maxLength: kCharacterLimit,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: ' Type your text here ...',
              ),
            ),
            ElevatedButton(
              onPressed: () async => await context
                  .read<AddPostCubit>()
                  .addPost(contentController.text),
              child: const Text('CREATE POST'),
            ),
          ],
        );
      },
    );
  }
}
