import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryDonation extends StatelessWidget {
  final String? userId;

  const HistoryDonation({ Key? key, this.userId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                  .collection('donations')
                  .where(userId!)
                  .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return DonationCard(
                          disasterName: snapshot.data!.docs[index]['disasterName'],
                          donationAmount: snapshot.data!.docs[index]['donationAmount'],
                          date: snapshot.data!.docs[index]['date'],
                        );
                      },
                    );
                  }
                  return const Text('Data tidak ditemukan');
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
  final String? disasterName;
  final int? donationAmount;
  final Timestamp? date;

  const DonationCard({
    Key? key,
    this.disasterName,
    this.donationAmount,
    this.date
  }) : super(key: key);

  String formattedDate (date) {      
    dynamic dateData = date;
    final birthDate = DateTime.fromMicrosecondsSinceEpoch(dateData.microsecondsSinceEpoch);
    String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
    return formattedDate;
  }

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
          Text(disasterName!,
              style: Theme.of(context).textTheme.headline6),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp.' + donationAmount!.toString(),
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Text(
                  formattedDate(date!),
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
