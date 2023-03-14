import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _imL = [];
  double top = -300;
  double left = -300;
  @override
  void initState() {
    super.initState();
    for (var i = 1; i <= 44; i++) {
      _imL.add("assets/Movie Poster CB Background By Zaman Editz (${i}).jpg");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final columns = sqrt(_imL.length).toInt();
    return Scaffold(
      body: _imL.isEmpty
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : GestureDetector(
              onPanUpdate: (details) {
                var topPos = top + (details.delta.dy * 1.5);
                var leftPos = left + (details.delta.dx * 1.5);
                //set the state
                setState(() {
                  top = topPos;
                  left = leftPos;
                });
              },
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      top: top,
                      left: left,
                      child: SizedBox(
                        width: columns * 320,
                        child: Wrap(
                            children: List.generate(
                          _imL.length,
                          (index) => Transform.translate(
                            offset: Offset(0, index.isEven ? 240 : 0),
                            child: MovieCard(
                              img: _imL[index],
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.img,
  });

  final String img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 300,
        height: 500,
        child: Stack(
          children: [
            Hero(
              tag: img,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  img,
                  width: 300,
                  height: 533,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
