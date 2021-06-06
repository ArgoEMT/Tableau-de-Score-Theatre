import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tableau_score_theatre/core/viewmodel/counters_screen_view_model.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'components/counter.dart';

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

  final CountdownController _controller = CountdownController();

  @override
  Widget build(BuildContext context) {
    CountersSreenViewModel model = Provider.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Theme :',
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
                      hintText: 'Theme',
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
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      child: Text(
                        'Lancer',
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: () {
                        _controller.start();
                      },
                    ),
                    SizedBox(width: 25),
                    ElevatedButton(
                      child: Text(
                        'Réinitialiser',
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: () {
                        _controller.restart();
                        _controller.pause();
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: Text(
                          'Temps',
                          style: TextStyle(color: Colors.black),
                        ),
                        children: [
                          Divider(),
                          Form(
                            key: model.formKey,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Minutes',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Container(
                                      width: 70,
                                      child: TextFormField(
                                        initialValue:
                                            model.formMinutes.toString(),
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          hintText: 'min',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        onSaved: (newValue) => model
                                            .formMinutes = int.parse(newValue!),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Erreur';
                                          }
                                          if (int.parse(value) < 0) {
                                            return 'Erreur';
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 25),
                                    Text(
                                      'Secondes',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Container(
                                      width: 70,
                                      child: TextFormField(
                                        initialValue:
                                            model.formSeconds.toString(),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          hintText: 's',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        textAlign: TextAlign.center,
                                        onSaved: (newValue) => model
                                            .formSeconds = int.parse(newValue!),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            print('vide');
                                            return 'Erreur';
                                          }
                                          if (int.tryParse(value)! < 0) {
                                            return 'Erreur';
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                if (model.formKey.currentState!.validate()) {
                                  model.saveTimer();
                                  Navigator.of(context).pop();
                                  _controller.restart();
                                  _controller.pause();
                                }
                              },
                              child: Text('Valider'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Countdown(
                    controller: _controller,
                    seconds: model.temps,
                    build: (_, double time) => returnTimer(time),
                    interval: Duration(seconds: 1),
                    onFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("C'est fini !"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(),
          ],
        ),
      ),
    );
  }

  Text returnTimer(double time) {
    var minutes = (time / 60).truncate();
    var seconds = (time - (minutes * 60)).truncate();

    return Text(
      '${jolifyTime(minutes)} : ${jolifyTime(seconds)}',
      style: TextStyle(
        fontSize: 100,
      ),
    );
  }

  String jolifyTime(int time) {
    if (time < 10) {
      return '0$time';
    }
    return time.toString();
  }
}
