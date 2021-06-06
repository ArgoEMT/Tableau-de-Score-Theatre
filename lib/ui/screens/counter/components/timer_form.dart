import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/viewmodel/counters_screen_view_model.dart';

class TimerForm extends StatefulWidget {
  const TimerForm({Key? key}) : super(key: key);

  @override
  _TimerFormState createState() => _TimerFormState();
}

class _TimerFormState extends State<TimerForm> {
  @override
  Widget build(BuildContext context) {
    CountersSreenViewModel model = Provider.of(context);
    return SimpleDialog(
      title: Text(
        'Temps',
        style: TextStyle(color: Colors.black),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(),
        ),
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
                      initialValue: model.formMinutes.toString(),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'min',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      onSaved: (newValue) =>
                          model.formMinutes = int.parse(newValue!),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vide';
                        }
                        if (int.parse(value) < 0) {
                          return 'Vide';
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
                      initialValue: model.formSeconds.toString(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 's',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.center,
                      onSaved: (newValue) =>
                          model.formSeconds = int.parse(newValue!),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vide';
                        }
                        if (int.tryParse(value)! < 0) {
                          return 'Vide';
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
                model.controller.restart();
                model.controller.pause();
              }
            },
            child: Text('Valider'),
          ),
        ),
      ],
    );
  }
}
