import 'package:flutter/material.dart';

class HistoryDonation extends StatelessWidget {
  const HistoryDonation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap () {}

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Histori donasi",
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const DonationCard();
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}

class DonationCard extends StatelessWidget {
  const DonationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: Theme.of(context).colorScheme.background,
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD5DBE1),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Kebakaran Gedung",
              style: Theme.of(context).textTheme.headline6),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rp. 100.000",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Text(
                  "24 / 05 / 2021",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
