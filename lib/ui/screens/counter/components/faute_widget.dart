import 'package:flutter/material.dart';

class FauteWidget extends StatelessWidget {
  final Color cardColor;
  const FauteWidget({
    Key? key,
    required this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: cardColor,
      child: Container(
        height: 50,
        width: 50,
      ),
    );
  }
}
