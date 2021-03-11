import 'package:flutter/material.dart';

class TagMelhorPreco extends StatelessWidget {
  const TagMelhorPreco({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.label,
            color: Colors.white,
          ),
          Text(
            'Melhor Preço',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
