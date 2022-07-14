import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/models/user.dart';
import 'package:bpbd_jatim/screens/user/donation/proof_of_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/payment_list.dart';

class Confirmation extends StatefulWidget {
  final PaymentList paymentMethod;
  final String? disasterId;
  final String? disasterName;
  final int? donationAmount;
  final String? note;

  const Confirmation({
    Key? key, 
    this.paymentMethod = PaymentList.linkAja,
    this.disasterId,
    this.disasterName,
    this.donationAmount,
    this.note
  }) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  User? user;

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
                  'Konfirmasi',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.surface),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/' + getAsset(widget.paymentMethod)),
                  const SizedBox(width: 10),
                  Text(
                    '( Dicek Otomatis )',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Container(
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.black,
              ),
              Text(
                'No. e-wallet',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '087861130080',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                          const ClipboardData(text: '087861130080'));
                    },
                    child: Text(
                      'Salin',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: const Color(0xFF00B8D1),
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Button(
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProofOfPayment(
                    donationAmount: widget.donationAmount,
                    note: widget.note,
                    disasterId: widget.disasterId,
                    disasterName: widget.disasterName,
                  )));
                },
                text: 'Konfirmasi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}