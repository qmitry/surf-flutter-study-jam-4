import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:surf_practice_magic_ball/ball.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  late Future<Ball> futureBall;
  bool _isContainersVisible = false;
  bool _isContainerTextVisible = false;
  String text = '';

  @override
  void initState() {
    super.initState();
    getStringText();
  }

  Text getText() {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 32,
        fontFamily: 'Gill',
        color: Colors.white,
      ),
    );
  }

  Future<void> getStringText() async {
    setState(() async {
      text = await fetchBallAnswer();
    });
  }

  Future<String> fetchBallAnswer() async {
    final response =
        await http.get(Uri.parse('https://www.eightballapi.com/api'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // setState(() async {
      //   Ball.fromJson(jsonDecode(response.body)).answer;
      // });
      return Ball.fromJson(jsonDecode(response.body)).answer;
      //return 'test';
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return 'Failed to load ball response';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(16, 12, 44, 1),
              Color.fromRGBO(0, 0, 2, 1)
            ])),
        child: Scaffold(
          // By defaut, Scaffold background is white
          // Set its value to transparent
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(16, 12, 44, 1),
            title: const Text(''),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    const Image(image: AssetImage('assets/images/ball.png')),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      opacity: _isContainersVisible ? 1 : 0,
                      child:
                          const Image(image: AssetImage('assets/images/3.png')),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      opacity: _isContainersVisible ? 1 : 0,
                      child:
                          const Image(image: AssetImage('assets/images/2.png')),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _isContainersVisible ? 1 : 0,
                      child:
                          const Image(image: AssetImage('assets/images/1.png')),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isContainersVisible = !_isContainersVisible;
                          _isContainerTextVisible = !_isContainerTextVisible;
                        });

                        if (!_isContainersVisible && !_isContainerTextVisible) {
                          getStringText();
                        }
                      },
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 2000),
                        opacity: _isContainersVisible ? 1 : 0,
                        child: const Image(
                            image: AssetImage('assets/images/4.png')),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isContainerTextVisible = !_isContainerTextVisible;
                          _isContainersVisible = !_isContainersVisible;
                        });

                        if (!_isContainersVisible && !_isContainerTextVisible) {
                          getStringText();
                        }
                      },
                      child: Container(
                        width: 200,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 1500),
                          opacity: _isContainerTextVisible ? 1 : 0,
                          child: getText(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Image(image: AssetImage('assets/images/Ellipse_6.png')),
                const SizedBox(height: 50),
                const Text(
                  'Нажмите на шар\nили потрясите телефон',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Gill',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
