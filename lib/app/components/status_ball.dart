import 'package:flutter/material.dart';

class StatusBall extends StatelessWidget {
  final String status;
  final bool active;

  const StatusBall({
    Key key,
    this.status,
    this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: active ? Colors.grey[300] : Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: active ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: !active ? Border.all(color: Colors.grey) : null,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(status),
        ),
      ],
    );
  }
}
