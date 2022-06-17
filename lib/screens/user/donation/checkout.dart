import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/data/payment_list.dart';
import 'package:bpbd_jatim/screens/user/donation/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/app_radio_button.dart';

class Checkout extends StatefulWidget {
  final int? donation;
  final String? note;
  final String? disasterId;
  final String? disasterName;

  const Checkout({
    Key? key,
    this.donation,
    this.note,
    this.disasterId,
    this.disasterName
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  PaymentList? _paymentList = PaymentList.linkAja;

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Checkout",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Theme.of(context).colorScheme.surface),
                  ),
                  Text(
                    "Rp. 100.000",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Theme.of(context).colorScheme.primary),
                  )
                ],
              ),
            ),
            DefaultTabController(
              initialIndex: 1,
              length: 2,
              child: Column(
                children: [
                  Container(
                    height: 69,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25.0)),
                    child: TabBar(
                      indicator: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(25.0)),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'E-wallet',
                        ),
                        Tab(
                          text: 'Bank Transer',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            AppRadioButton<PaymentList>(
                              value: PaymentList.linkAja,
                              groupValue: _paymentList,
                              onChanged: (PaymentList? value) {
                                setState(() {
                                  _paymentList = value;
                                });
                              },
                              text: 'LinkAja',
                            ),
                            AppRadioButton<PaymentList>(
                              value: PaymentList.ovo,
                              groupValue: _paymentList,
                              onChanged: (PaymentList? value) {
                                setState(() {
                                  _paymentList = value;
                                });
                              },
                              text: 'OVO',
                            ),
                            AppRadioButton<PaymentList>(
                              value: PaymentList.gopay,
                              groupValue: _paymentList,
                              onChanged: (PaymentList? value) {
                                setState(() {
                                  _paymentList = value;
                                });
                              },
                              text: 'Gopay',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            AppRadioButton<PaymentList>(
                              value: PaymentList.mandiri,
                              groupValue: _paymentList,
                              onChanged: (PaymentList? value) {
                                setState(() {
                                  _paymentList = value;
                                });
                              },
                              text: 'Mandiri',
                            ),
                            AppRadioButton<PaymentList>(
                              value: PaymentList.bca,
                              groupValue: _paymentList,
                              onChanged: (PaymentList? value) {
                                setState(() {
                                  _paymentList = value;
                                });
                              },
                              text: 'BCA',
                            ),
                            AppRadioButton<PaymentList>(
                              value: PaymentList.bri,
                              groupValue: _paymentList,
                              onChanged: (PaymentList? value) {
                                setState(() {
                                  _paymentList = value;
                                });
                              },
                              text: 'BRI',
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Kami akan mengirimkan detail pembayaran ke email anda setelah transaksi berhasil",
                textAlign: TextAlign.center,
              ),
            ),
            Button(
              press: () {
                // Provider.of<DonationProvider>(context, listen: false).changeIndex(2);
                Navigator.push(context, MaterialPageRoute(builder: (_) => Confirmation(
                  donationAmount: widget.donation,
                  note: widget.note,
                  disasterId: widget.disasterId,
                  disasterName: widget.disasterName,
                )));
              },
              text: "Lanjutkan",
            ),
          ],
        ),
      ),
    );
  }
}
