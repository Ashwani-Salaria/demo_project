import 'package:DemoProject/Theme/images_path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  dynamic userImage;
  dynamic userName;
  dynamic imageHeight;
  dynamic imageWidth;
  dynamic defaultCircleWidth;
  dynamic borderColor;

  UserAvatar({
    this.userImage,
    this.userName,
    this.imageHeight,
    this.imageWidth,
    this.defaultCircleWidth,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return _userAvatarWidget();
  }

  Widget _userAvatarWidget() {
    print(userImage);
    return (userImage != null)
        ? CachedNetworkImage(
            height: (imageHeight != null) ? imageHeight.toDouble() : 30,
            imageUrl: '$userImage',
            imageBuilder: (context, imageProvider) => Container(
              width: (imageWidth != null) ? imageWidth.toDouble() : 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
            ),
            placeholder: (context, url) => Image.asset(
              ImagesPath.onErrorImage,
            ),
            errorWidget: (context, url, error) => Image.asset(
              ImagesPath.onErrorImage,
              width: (imageWidth != null) ? imageWidth.toDouble() : 30,
            ),
          )
        : Image.asset(
            ImagesPath.onErrorImage,
            width: (imageWidth != null) ? imageWidth.toDouble() : 30,
          );
  }
}
