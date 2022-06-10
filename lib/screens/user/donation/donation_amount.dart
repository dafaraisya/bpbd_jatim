import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DonationAmount extends StatelessWidget {
  const DonationAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Nominal donasi',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            const AmountCard(),
            const SizedBox(height: 40),
            Text(
              'Catatan',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            const NoteCard(),
            const SizedBox(height: 40),
            Button(
              text: 'Lanjutkan',
              press: () => Provider.of<DonationProvider>(context, listen: false).changeIndex(1),
            ),
          ],
        ),
      ),
    );
  }
}

class AmountCard extends StatefulWidget {
  const AmountCard({Key? key}) : super(key: key);

  @override
  State<AmountCard> createState() => _AmountCardState();
}

class _AmountCardState extends State<AmountCard> {
  TextEditingController amount = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    amount = TextEditingController(text: '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 82,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Rp. ',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 40),
            child: IntrinsicWidth(
              child: TextField(
                controller: amount,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NoteCard extends StatefulWidget {
  const NoteCard({Key? key}) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  TextEditingController controller = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 8,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        hintText: 'Tuliskan pesan anda untuk mereka ...',
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "id_ID");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
