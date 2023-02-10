import 'dart:async';
import 'dart:developer';
import 'package:DemoProject/Theme/images_path.dart';
import 'package:DemoProject/screens/Home/video_row.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../Theme/custom_track_shape.dart';
import '../../../Theme/styles.dart';
import '../../../widgets/user_avatar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double valueHolder = 0;
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;
  DragStartDetails? startVerticalDragDetails;
  DragUpdateDetails? updateVerticalDragDetails;
  Future<void>? _initializeVideoPlayerFuture;
  bool isPlaying = false;
  bool isMute = false;
  bool isFullscreen = false;

  bool keyboardStatus = false;
  List chatArray = [];
  bool videoLoader = true;
  bool _centerActionButtonShow = true;
  var videoId;

  bool descriptionHideShow = false;

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  void startTimer() {
    var _timer;
    var _start = 4;
    var oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            _centerActionButtonShow = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> initializePlayer() async {
    String videoUrl =
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
    _videoPlayerController1 = VideoPlayerController.network(videoUrl);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1!,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      showControls: false,
      placeholder: Container(
        color: Styles.greyColor600,
      ),
    );

    _videoPlayerController1!.addListener(() {
      var val = _videoPlayerController1!.value.position.toString().split(':');
      var splSec = val[2].toString().split('.');

      if (splSec[0].toString() == '02') {
        Timer(const Duration(milliseconds: 100), () {
          _centerActionButtonShow = false;
          setState(() {});
        });
      }

      if (_videoPlayerController1!.value.position ==
          _videoPlayerController1!.value.duration) {
        print("seek function==========>>>");
        Timer(const Duration(milliseconds: 100), () {
          _chewieController!.seekTo(const Duration(seconds: 0));
          if (_videoPlayerController1!.value.isInitialized) {
            isPlaying = true;
            _chewieController!.pause();
          }

          _centerActionButtonShow = true;
          setState(() {});
        });
      }
    });
    _initializeVideoPlayerFuture = Future.value();

    setState(() {});
  }

  colorChk(videoPlay, index) {
    print("index========>>>>$index");

    if (_convertTimeTodoulbe(videoPlay.questionList[index].questionDoneTime) ==
        _videoPlayerController1!.value.position.inSeconds) {
      for (var i = 0; i <= videoPlay.questionList.length - 1; i++) {
        videoPlay.questionList[i].questionColorStatus = false;
      }

      videoPlay.questionList[index].questionColorStatus = true;
    }
    if (_videoPlayerController1!.value.position ==
        _videoPlayerController1!.value.duration) {
      videoPlay.questionList[index].questionColorStatus = false;
    }
    return true;
  }

  double _convertTimeTodoulbe(String questionTime) {
    List<String> timeArray = questionTime.toString().split(':');
    double sec = 0.0;
    if (double.parse(timeArray[0]) > 0) {
      sec = double.parse(timeArray[0]) * 60;
      sec = sec * 60;
      print("sssss=====222==$sec");
    }
    if (double.parse(timeArray[1]) > 0) {
      sec += double.parse(timeArray[1]) * 60;
      print("sssss=====333==$sec");
    }
    if (double.parse(timeArray[2]) > 0) {
      sec += double.parse(timeArray[2]);
      print("sssss=====4444==$sec");
    }

    print("sssss=====$sec");
    return sec;
  }

  _playVideoFrom(double newValue) {
    if (_chewieController != "null" &&
        _videoPlayerController1 != "null" &&
        _videoPlayerController1!.value != "null" &&
        _videoPlayerController1!.value.isInitialized) {
      if (_videoPlayerController1!.value.isPlaying) {
        //_chewieController.pause();
        //isPlaying = false;
      } else {
        //_chewieController.play();
        //isPlaying = true;
      }
      _chewieController!.play();
      isPlaying = false;
      setState(() {});
    }
    _chewieController!.seekTo(Duration(seconds: newValue.round()));
    print("seek function==========>>>tewwwooo");
    valueHolder = newValue.toDouble();

    //seekChkColor();
    Timer(const Duration(milliseconds: 100), () {
      isPlaying = false;

      setState(() {});
      log('video Ended ====');
    });
    //}
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _videoPlayerController1!.dispose();
    //widget._videoPlayerController1.dispose();
    _chewieController!.dispose();
    _initializeVideoPlayerFuture = null;

    super.dispose();
  }

  showTimer(value) {
    if (value != null && value != '') {
      var val = value.toString().split(':');
      var splSec = val[2].toString().split('.');

      return Text(
        val[1].toString() + ':' + splSec[0].toString(),
        style: const TextStyle(
          color: Styles.whiteColor,
        ),
      );
    }
  }

  Widget _videoControlles() {
    // return Container(child: Text("kklklklklkl"),);
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15, right: 5, left: 20),
                  child: Row(
                    children: [
                      Container(
                        child: ValueListenableBuilder(
                          valueListenable: _videoPlayerController1!,
                          builder: (context, VideoPlayerValue value, child) {
                            return (value != "null" && value.position != "null")
                                ? Container(child: showTimer(value.position))
                                : const Text(
                                    '00:00',
                                    style: TextStyle(
                                      color: Styles.whiteColor,
                                    ),
                                  );
                          },
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          child: const Text(
                            "/",
                            style: TextStyle(
                              color: Styles.whiteColor,
                            ),
                          )),
                      ValueListenableBuilder(
                        valueListenable: _videoPlayerController1!,
                        builder: (context, VideoPlayerValue value, child) {
                          return (value != "null" && value.duration != "null")
                              ? Container(child: showTimer(value.duration))
                              : const Text(
                                  '00:00',
                                  style: TextStyle(
                                    color: Styles.whiteColor,
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      //_chewieController!.toggleFullScreen();
                      //isFullscreen = !isFullscreen;
                      if (isFullscreen == false) {
                        setState(() {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight
                          ]);
                          isFullscreen = true;
                        });
                      } else {
                        setState(() {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitDown,
                            DeviceOrientation.portraitUp
                          ]);
                          isFullscreen = false;
                        });
                      }
                    },
                    child: Container(
                      width: 30,
                      margin: const EdgeInsets.only(left: 10),
                      child: Icon(
                        (isFullscreen == true)
                            ? Icons.fullscreen_exit_sharp
                            : Icons.fullscreen_outlined,
                        color: Styles.whiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _videoSeekBarWidget(),
          ],
        ),
      ),
    );
  }

  Widget _videoSeekBarWidget() {
    return Container(
      height: 15,
      margin: const EdgeInsets.only(bottom: 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              color: Styles.greyColor600,
            ),
          ),
          ValueListenableBuilder(
              valueListenable: _videoPlayerController1!,
              builder: (context, VideoPlayerValue value, child) {
                if (value != "null" &&
                    value.position != "null" &&
                    value.duration != "null" &&
                    value.duration.inSeconds != "null" &&
                    value.position.inSeconds != "null") {
                  valueHolder = value.position.inSeconds.toDouble();

                  return Container(
                    // color: Colors.yellow,
                    width: MediaQuery.of(context).size.width,
                    height: 8.0,
                    //child:Text('jjjjjjjjjjjj')
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackShape: CustomTrackShape(),
                      ),
                      child: Slider(
                          value: value.position.inSeconds.toDouble(),
                          min: 0,
                          max: value.duration.inSeconds.toDouble(),
                          activeColor: Styles.redColor,
                          inactiveColor: Styles.greyColor,
                          label: '${value.position.inSeconds.round()}',
                          onChanged: (double newValue) {
                            _playVideoFrom(newValue);
                          },
                          semanticFormatterCallback: (double newValue) {
                            log('newValue ===>>> $newValue');
                            return '${newValue.round()}';
                          }),
                    ),
                  );
                } else {
                  return Text(' ');
                }
              }),
        ],
      ),
    );
  }

  Widget _centerActionButtonBlur() {
    if (_centerActionButtonShow == true) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(59, 22, 44, 33),
                ),
                margin: const EdgeInsets.only(top: 87),
                height: 48,
                width: 48,
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _centerActionButton() {
    return GestureDetector(
      onTap: () {
        if (_videoPlayerController1!.value.isPlaying) {
          _chewieController!.pause();
          isPlaying = true;
        } else {
          _chewieController!.play();
          isPlaying = false;
        }
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              child: Image(
                image: AssetImage(
                  (isPlaying == true)
                      ? ImagesPath.playButton
                      : ImagesPath.pauseButton,
                ),
                height: 60,
                width: 60,
              ),
              height: 60,
              width: 60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _muteIconShow() {
    return GestureDetector(
      onTap: () {
        if (isMute == true) {
          _chewieController!.setVolume(1.0);
        } else {
          _chewieController!.setVolume(0.0);
        }

        setState(() {
          isMute = !isMute;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            //color: Styles.greyColor,
            width: 30,
            margin: const EdgeInsets.only(right: 15, top: 15),
            child: Icon(
              (isMute == true) ? Icons.volume_off : Icons.volume_up,
              color: Styles.whiteColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  setScreen() {
    Navigator.pop(context);
    if (_chewieController != "null" &&
        _videoPlayerController1 != "null" &&
        _videoPlayerController1!.value != "null" &&
        _videoPlayerController1!.value.isInitialized) {
      if (_videoPlayerController1!.value.isPlaying) {
        _chewieController!.pause();
      }
    }
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.greyColor600,
      child: Scaffold(
        backgroundColor: Styles.greyColor600,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _centerActionButtonShow = true;
                          });
                          startTimer();
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        child: Container(
                          color: Styles.greyColor600,
                          padding: const EdgeInsets.only(top: 30),
                          height: !isFullscreen
                              ? 250
                              : MediaQuery.of(context).size.height - 25,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              (snapshot.connectionState == ConnectionState.done)
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Chewie(
                                        controller: _chewieController!,
                                      ),
                                    )
                                  : Stack(
                                      children: const [
                                        Center(
                                            child: CircularProgressIndicator())
                                      ],
                                    ),
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  _centerActionButtonShow == true)
                                _videoControlles(),
                              if (snapshot.connectionState ==
                                  ConnectionState.done)
                                _muteIconShow(),
                              if (snapshot.connectionState ==
                                  ConnectionState.done)
                                (_centerActionButtonShow == true)
                                    ? _centerActionButtonBlur()
                                    : const SizedBox.shrink(),
                              if (snapshot.connectionState ==
                                  ConnectionState.done)
                                (_centerActionButtonShow == true)
                                    ? _centerActionButton()
                                    : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Styles.whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _firstRow(),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: Divider(
                                    color: Styles.blackColor45,
                                  )),
                              _second(),
                              _third(),
                              _fourth(),
                              _five(),
                              _description(),
                              _commentRow(),
                              _commentWidget(),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 15),
                                child: Text(
                                  'Recommended',
                                  style: Styles.userNameText,
                                ),
                              ),
                              VideoRowScreen(),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstRow() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Icon(
                    Icons.thumb_up,
                    color: Styles.pinkColor,
                    size: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 10),
                child: Text(
                  '400k',
                  style: Styles.smallParaText(),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Icon(
                    Icons.thumb_down,
                    color: Styles.pinkColor,
                    size: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 10),
                child: Text(
                  '20',
                  style: Styles.smallParaText(),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Icon(
                    Icons.comment,
                    color: Styles.pinkColor,
                    size: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 10),
                child: Text(
                  '40',
                  style: Styles.smallParaText(),
                ),
              ),
              Container(
                height: 20,
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white, //New
                        blurRadius: 25.0,
                      ),
                    ],
                    border: Border.all(
                      color: Styles.blackColor45,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  '40k Views',
                  style: Styles.smallParaText(),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Icon(
                Icons.share,
                color: Styles.blackColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _second() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Row(children: [
        for (int i = 0; i < 4; i++)
          Container(
            height: 20,
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            margin: EdgeInsets.only(left: i == 0 ? 0 : 10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white, //New
                    blurRadius: 25.0,
                  ),
                ],
                border: Border.all(
                  color: Styles.blackColor45,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              i == 0 || i == 2 ? 'Music' : 'Dance',
              style: Styles.smallParaText(),
            ),
          )
      ]),
    );
  }

  Widget _third() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lofi hip hop mix - Beats',
              style: Styles.userNameText,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Icon(
                  Icons.bookmark,
                  color: Styles.blackColor45,
                  size: 20,
                ),
              ),
            )
          ],
        ));
  }

  Widget _fourth() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
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
              style: Styles.textH4,
            ),
          ],
        ));
  }

  Widget _five() {
    return Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white, //New
                blurRadius: 25.0,
              ),
            ],
            border: Border.all(
              color: Styles.blackColor45,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar(),
                Container(
                  padding: EdgeInsets.only(top: 4, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Divya Sharma',
                        style: Styles.userNameText,
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
            Text(
              'Follow',
              style: Styles.smallParaText(color: Styles.pinkColor),
            ),
          ],
        ));
  }

  Widget _description() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Description',
              style: Styles.userNameText,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Styles.blackColor45,
                  size: 25,
                ),
              ),
            )
          ],
        ));
  }

  Widget _commentRow() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 30,
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                  color: Styles.blackColor45,
                  border: Border.all(
                    color: Styles.whiteColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                'Comments',
                style: Styles.smallParaText(
                    color: Styles.whiteColor, fountSized: 18.0),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Styles.blackColor45,
                  size: 25,
                ),
              ),
            )
          ],
        ));
  }

  Widget _commentWidget() {
    return Column(
      children: [
        for (int i = 0; i < 5; i++)
          Container(
              // height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white, //New
                      blurRadius: 15.0,
                    ),
                  ],
                  border: Border.all(
                    color: Styles.blackColor45,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          UserAvatar(),
                          Container(
                            padding: EdgeInsets.only(top: 4, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Divya Sharma',
                                  style: Styles.userNameText,
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
                      Text(
                        'reply',
                        style: Styles.smallParaText(color: Styles.blackColor),
                      ),
                    ],
                  ),
                  Text(
                    'When one door of happiness closes, anotheropens, but often we look so long at the closeddoor that we do not see the one that has beenopened for us.@Divya',
                    style: Styles.smallParaText(
                        color: Styles.blackColor, fountSized: 14.0),
                  ),
                ],
              )),
      ],
    );
  }
}
