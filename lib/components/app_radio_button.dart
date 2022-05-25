import 'package:flutter/material.dart';

class AppRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String text;
  final ValueChanged<T?> onChanged;

  const AppRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  Widget _buildLabel(BuildContext context) {
    final bool isSelected = value == groupValue;

    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.background,
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD5DBE1),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildText(),
              _buildLabel(context),
            ],
          ),
        ),
      ),
    );
  }
}
