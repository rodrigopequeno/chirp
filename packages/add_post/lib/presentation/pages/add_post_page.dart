import 'package:add_post/presentation/cubit/add_post_cubit.dart';
import 'package:add_post/presentation/widgets/leave_without_saving_dialog_widget.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:auth/cubit/auth_cubit.dart';
import 'package:core/utils/character_limit.dart';
import 'package:core/widgets/button/button_widget.dart';
import 'package:core/widgets/loading_indicator/loading_indicator_widget.dart';
import 'package:core/widgets/scaffold/scaffold_widget.dart';
import 'package:core/widgets/spacers/spacers.dart';
import 'package:core/widgets/text_field.dart/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddPostPage extends StatelessWidget {
  final loading = LoadingIndicatorImpl();
  final TextEditingController contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = (Get.find<AuthCubit>().state as AuthLogged).user;
    return ScaffoldWidget(
      onWillPop: _onWillPop,
      body: _buildBody(),
      imageUser: user.image,
      nameUser: user.name,
    );
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => Get.find<AddPostCubit>(),
      child: BlocConsumer<AddPostCubit, AddPostState>(
        listener: _listener,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFieldWidget(
                      controller: contentController,
                      textInputAction: TextInputAction.done,
                      label: 'Type your text here ...',
                      border: InputBorder.none,
                      maxLength: kCharacterLimitCreation,
                      keyboardType: TextInputType.multiline,
                      maxLengthEnforcement: MaxLengthEnforcement.none,
                      validator: (value) {
                        const kRequired = "Required field";
                        if (value == null) {
                          return kRequired;
                        } else if (value.isEmpty) {
                          return kRequired;
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) async {
                        await _submitted(context);
                      },
                    ),
                    const SpacerH(30),
                    ButtonWidget(
                      onPressed: () async => await _submitted(context),
                      text: "CREATE POST",
                      colorButton: Theme.of(context).primaryColor,
                      width: 180,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _submitted(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      return await context.read<AddPostCubit>().addPost(contentController.text);
    }
  }

  void _listener(context, state) {
    if (state is AddPostLoading) {
      loading.show();
    } else if (loading.isShow) {
      loading.hide();
    }

    if (state is AddPostError) {
      asuka.showSnackBar(SnackBar(content: Text(state.message)));
    }

    if (state is AddPostSuccess) {
      Get.offAllNamed('/posts');
    }
  }

  Future<bool> _onWillPop() async {
    if (contentController.text.isEmpty) {
      return true;
    } else {
      final result = await asuka.showDialog<bool>(
          barrierDismissible: false,
          builder: (context) => const LeaveWithoutSavingDialogWidget());
      return result ?? true;
    }
  }
}
