import 'package:flutter/material.dart';

class LabelVerify extends StatelessWidget {
  const LabelVerify({ Key? key, this.text }) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: text == 'Accept' ? Colors.green : text == 'Reject' ? Colors.red : Theme.of(context).colorScheme.secondary,
      ),
      child: Center(
        child: Text(
          text!,
          style: Theme.of(context).textTheme.headline6?.copyWith(
            color: Theme.of(context).colorScheme.background,
            fontSize: 14,
          ),
        ),
      ),
      // color: Theme.of(context).colorScheme.primary,
      height: 32,
    );
  }
}