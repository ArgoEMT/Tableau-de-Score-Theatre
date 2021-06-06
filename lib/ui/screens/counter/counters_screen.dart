import 'package:flutter/material.dart';

import 'components/counter.dart';
import 'components/timer.dart';

class CountersScreen extends StatefulWidget {
  const CountersScreen({Key? key}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CountersScreen> {
  bool imageBase = true;

  String get imagePath {
    return imageBase
        ? 'lib/assets/images/toucan.png'
        : 'lib/assets/images/trophee.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Text('Développé par Victor Daumas. https://github.com/ArgoEMT/'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Thème :',
                      style: TextStyle(fontSize: 60, color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.amber,
                      ),
                    ),
                    width: 500,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Thème',
                        hintStyle: TextStyle(
                          color: Colors.amberAccent,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.amberAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.lime,
                      ),
                    ),
                    width: 300,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Catégorie',
                        hintStyle: TextStyle(color: Colors.limeAccent),
                      ),
                      style: TextStyle(fontSize: 25, color: Colors.limeAccent),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Counter(
                    equipe: 1,
                  ),
                  SizedBox(width: 25),
                  GestureDetector(
                    onTap: () => setState(() {
                      imageBase = !imageBase;
                    }),
                    child: Image.asset(
                      imagePath,
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 25),
                  Counter(
                    equipe: 2,
                  ),
                ],
              ),
              SizedBox(height: 25),
              Timer(),
            ],
          ),
        ),
      ),
    );
  }
}
