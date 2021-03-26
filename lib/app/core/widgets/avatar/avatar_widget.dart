import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? image;
  final double width;
  final Color cor;

  const AvatarWidget(
      {Key? key, required this.image, this.width = 40, required this.cor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: image != null,
      replacement: Center(
        child: Icon(
          Icons.account_circle,
          size: width,
          color: cor,
        ),
      ),
      child: Center(
        child: CachedNetworkImage(
          imageUrl: image ?? "",
          imageBuilder: (context, imageProvider) => Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).primaryColor),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(4, 4), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Icon(
            Icons.account_circle,
            size: width,
            color: cor,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            size: width,
            color: Colors.red[900],
          ),
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
