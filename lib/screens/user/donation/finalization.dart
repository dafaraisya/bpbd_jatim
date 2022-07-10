import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/dashboard.dart';
import 'package:flutter/material.dart';

class Finalization extends StatelessWidget {
  const Finalization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 59),
        Center(child: Image.asset('assets/images/donation_illustration.png')),
        const SizedBox(height: 47),
        Text(
          'Transaksi telah berhasil !!!',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Button(
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboard()));
            },
            text: 'Kembali ke halaman utama',
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
