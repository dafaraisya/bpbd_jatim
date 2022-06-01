import 'package:bpbd_jatim/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/payment_list.dart';

class Confirmation extends StatelessWidget {
  final PaymentList paymentMethod;
  const Confirmation({Key? key, this.paymentMethod = PaymentList.linkAja})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/' + getAsset(paymentMethod)),
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
              press: () {},
              text: 'Konfirmasi',
            ),
          ],
        ),
      ),
    );
  }
}
