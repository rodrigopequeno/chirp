import 'package:flutter/material.dart';

import 'package:chirp/app/core/widgets/avatar/avatar_widget.dart';
import 'package:chirp/app/core/widgets/spacers/spacers.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:get/get.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget body;
  final List<Widget> actions;
  final LoggedUser loggedUser;
  final Future<bool> Function()? onWillPop;
  final Widget? floatingActionButton;
  final Widget? content;
  const ScaffoldWidget({
    Key? key,
    required this.body,
    required this.loggedUser,
    this.actions = const <Widget>[],
    this.floatingActionButton,
    this.onWillPop,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Stack(
          children: [
            _appBarInfo(context),
            Container(
              margin: const EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(0, -1), // changes position of shadow
                  ),
                ],
              ),
              child: body,
            )
          ],
        ),
      ),
    );
  }

  Widget _appBarInfo(BuildContext context) {
    return AnimatedPositioned(
      top: 40,
      // ignore: invalid_use_of_protected_member
      left: Get.routing.route?.hasActiveRouteBelow ?? false ? 10 : 30,
      right: 20,
      duration: const Duration(milliseconds: 400),
      child: Row(
        children: [
          Visibility(
            // ignore: invalid_use_of_protected_member
            visible: Get.routing.route?.hasActiveRouteBelow ?? false,
            child: BackButton(onPressed: () async {
              if (onWillPop == null) {
                Get.back();
              } else if (onWillPop != null && await onWillPop!()) {
                Get.back();
              }
            }),
          ),
          ..._contentAppBar(context),
          const SpacerW(10),
          ...actions,
        ],
      ),
    );
  }

  List<Widget> _contentAppBar(BuildContext context) {
    if (content != null) return [content!];
    return [
      AvatarWidget(
        image: loggedUser.image,
        cor: Colors.white,
        width: 50,
      ),
      const SpacerW(10),
      Expanded(
        child: Text(
          loggedUser.name,
          maxLines: 2,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      )
    ];
  }
}
