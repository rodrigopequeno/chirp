import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:flutter/material.dart';

import 'package:chirp/app/core/widgets/avatar/avatar_widget.dart';
import 'package:chirp/app/core/widgets/spacers/spacers.dart';

class AppBarWidget extends StatelessWidget {
  final Widget body;
  final List<Widget> actions;
  final LoggedUser loggedUser;

  const AppBarWidget({
    Key? key,
    required this.body,
    required this.loggedUser,
    this.actions = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Stack(
        children: [
          _appBarInfo(context),
          Container(
            margin: const EdgeInsets.only(top: 110),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
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
    );
  }

  Widget _appBarInfo(BuildContext context) {
    return Positioned(
      top: 40,
      left: 30,
      right: 25,
      child: Row(
        children: [
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
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
            ),
          ),
          const SpacerW(10),
          ...actions,
        ],
      ),
    );
  }
}
