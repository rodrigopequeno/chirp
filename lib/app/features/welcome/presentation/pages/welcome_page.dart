import 'package:asuka/asuka.dart' as asuka;
import 'package:chirp/app/core/widgets/button/button_widget.dart';
import 'package:chirp/app/core/widgets/spacers/spacers.dart';
import 'package:chirp/app/core/widgets/text_field.dart/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
  final controller = Get.find<WelcomeCubit>()..init();
  final loading = LoadingIndicatorImpl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocProvider<WelcomeCubit>(
      create: (context) => controller,
      child: BlocConsumer<WelcomeCubit, WelcomeState>(
        listener: _listener,
        builder: (context, state) => _buildWelcome(state),
      ),
    );
  }

  void _listener(context, state) {
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
  }

  Widget _buildWelcome(WelcomeState state) {
    final visible = state is WelcomeLoadingInitial || state is WelcomeSuccess;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(seconds: 1),
                child: SvgPicture.asset(
                  'assets/images/bird.svg',
                  semanticsLabel: 'CHIRP LOGO',
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(microseconds: 2000),
                curve: Curves.bounceIn,
                child: Column(
                  children: [
                    const SpacerH(80),
                    Text(
                      "Welcome!",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SpacerH(20),
                    Text(
                      "See what's going on\nat Ephrom now.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SpacerH(30),
                    Visibility(
                      visible: !visible,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: _buildForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFieldWidget(
            controller: nameController,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.account_circle_outlined),
            colorBorder: Theme.of(context).primaryColor,
            onFieldSubmitted: (_) async => await _submitted(),
            label: 'Name',
          ),
        ),
        const SpacerH(15),
        ButtonWidget(
          onPressed: () async {
            await _submitted();
          },
          text: "ENTER",
          colorButton: Theme.of(context).primaryColor,
          radius: 20,
          width: 100,
        ),
      ],
    );
  }

  Future<void> _submitted() async {
    await controller.signIn(nameController.text);
  }
}
