import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tableau_score_theatre/core/viewmodel/counters_screen_view_model.dart';

class Counter extends StatefulWidget {
  final int equipe;

  const Counter({
    Key? key,
    required this.equipe,
  }) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var counter = 0;
  var intColor = 0;
  Color get containerColor {
    switch (intColor) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.amber;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.pink;

      default:
        return Colors.blue;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.equipe == 1 ? intColor = 0 : intColor = 1;
  }

  void _incrementColor() {
    if (intColor < 3) {
      intColor += 1;
    } else {
      intColor = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CountersSreenViewModel model = Provider.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              iconSize: 50,
              onPressed: () {
                setState(() {
                  model.decrementTeamScore(team: widget.equipe);
                });
              },
              icon: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 25),
            IconButton(
              iconSize: 50,
              onPressed: () {
                setState(() {
                  model.incrementTeamScore(team: widget.equipe);
                });
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: _incrementColor,
          child: Container(
            alignment: Alignment.center,
            color: containerColor,
            width: 250,
            height: 250,
            child: Text(
              model.getScoreByTeam(team: widget.equipe).toString(),
              style: TextStyle(fontSize: 100),
            ),
          ),
        ),
        SizedBox(height: 25),
        GestureDetector(
          onTap: () => model.incrementTeamFautes(team: widget.equipe),
          child: Container(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: model.getTeamFautes(team: widget.equipe) > 0
                      ? Colors.red
                      : Colors.white,
                  height: 50,
                  width: 50,
                ),
                Container(
                  color: model.getTeamFautes(team: widget.equipe) > 1
                      ? Colors.red
                      : Colors.white,
                  height: 50,
                  width: 50,
                ),
                Container(
                  color: model.getTeamFautes(team: widget.equipe) > 2
                      ? Colors.red
                      : Colors.white,
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
