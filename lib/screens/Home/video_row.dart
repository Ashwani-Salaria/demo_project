import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Theme/images_path.dart';
import '../../Theme/styles.dart';
import '../../widgets/user_avatar.dart';

class VideoRowScreen extends StatefulWidget {
  @override
  _VideoRowScreenState createState() => _VideoRowScreenState();
}

class _VideoRowScreenState extends State<VideoRowScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Styles.whiteColor,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) {
                return _videoRow();
              },
            ))
      ],
    );
  }

  Widget _videoRow({context, obj, index, objModel}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 140.0,
        margin: EdgeInsets.only(
            left: index == 0 ? 10 : 6, right: index == 10 ? 5 : 0, top: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Styles.blackColor45,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Styles.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: CachedNetworkImage(
                  height: 70.0,
                  width: 140.0,
                  imageUrl: 'https://picsum.photos/250?image=9',
                  placeholder: ((context, s) => Container(
                        height: 70.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage(ImagesPath.onErrorImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  // fit: BoxFit.scaleDown,
                  errorWidget: (context, url, error) => Container(
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage(ImagesPath.onErrorImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              width: 120.0,
              child: Text(
                'Justin Bieber - Peachesft. Daniel Caesar, Giveon',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles.smallParaText(
                    color: Styles.blackColor, fountSized: 14.0),
              ),
            ),
            _location(),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Row(
                children: [
                  UserAvatar(),
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Divya Sharma',
                          style: Styles.smallParaText(fountSized: 14.0),
                        ),
                        Text(
                          '10K Subscribers',
                          style: Styles.smallParaText(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _location() {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Icon(
                  Icons.location_on,
                  color: Styles.pinkColor,
                  size: 20,
                ),
              ),
            ),
            Text(
              'San Francisco',
              style: Styles.smallParaText(color: Styles.blackColor),
            ),
          ],
        ));
  }
}
