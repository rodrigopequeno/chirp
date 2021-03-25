import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/loading_indicator/loading_indicator_widget.dart';
import '../cubit/welcome_cubit.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController nameController = TextEditingController();

  final loading = LoadingIndicatorImpl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider<WelcomeCubit>(
          create: (context) => Get.find<WelcomeCubit>()..init(),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<WelcomeCubit, WelcomeState>(
      listener: (context, state) {
        if (state is WelcomeLoading) {
          loading.show();
        } else if (loading.isShow) {
          loading.hide();
        }

        if (state is WelcomeError) {
          asuka.showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is WelcomeSuccess) {
          Get.offNamed('/posts');
        }
      },
      builder: (context, state) {
        if (state is WelcomeLoadingInitial || state is WelcomeSuccess) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            ElevatedButton(
              onPressed: () async => await context
                  .read<WelcomeCubit>()
                  .signIn(nameController.text),
              child: const Text('ENTER'),
            ),
          ],
        );
      },
    );
  }
}
