import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'timer_form.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../core/viewmodel/counters_screen_view_model.dart';

class Timer extends StatelessWidget {
  const Timer({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    CountersSreenViewModel model = Provider.of(context);
    return Column(
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
                model.controller.start();
              },
            ),
            SizedBox(width: 25),
            ElevatedButton(
              child: Text(
                'Réinitialiser',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                model.controller.restart();
                model.controller.pause();
              },
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => TimerForm(),
            );
          },
          child: Countdown(
            controller: model.controller,
            seconds: model.temps,
            build: (_, double time) => returnTimer(time),
            interval: Duration(seconds: 1),
            onFinished: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Center(
                    child: Text(
                      'Le temps est écoulé.',
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
