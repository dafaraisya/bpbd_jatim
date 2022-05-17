import 'package:flutter/material.dart';

class AppGrid extends StatelessWidget {
  const AppGrid({
    Key? key,
    required this.widgetList,
  }) : super(key: key);

  final List widgetList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < widgetList.length; i += 2)
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widgetList[i],
                widgetList.asMap().containsKey(i + 1)
                    ? widgetList[i + 1]
                    : const SizedBox(width: 0, height: 0)
              ],
            ),
          )
      ],
    );
  }
}
