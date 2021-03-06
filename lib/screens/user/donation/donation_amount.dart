import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/user/donation/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

TextEditingController amount = TextEditingController(text: "");
TextEditingController note = TextEditingController(text: "");

class DonationAmount extends StatelessWidget {
  final String? disasterId;
  final String? disasterName;

  const DonationAmount({Key? key, this.disasterId, this.disasterName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/icons/back_black.svg"),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Donasi',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.surface),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
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
                press: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => Confirmation(
                  //   donationAmount: int.parse(amount.text),
                  //   note: note.text,
                  //   disasterId: disasterId,
                  //   disasterName: disasterName,
                  // )));

                  Navigator.push(context, MaterialPageRoute(builder: (_) => Checkout(
                    donationAmount: int.parse(amount.text),
                    note: note.text,
                    disasterId: disasterId,
                    disasterName: disasterName,
                  )));
                },
              ),
            ],
          ),
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
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: note,
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
