import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String street;
  final String date;
  final VoidCallback onTap;

  const AppCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.street,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 206,
      width: 154,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD5DBE1),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 94,
              width: 138,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            street,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: const Color(0xFF858585),
                ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF858585),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 13),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: onTap,
              child: Text(
                'Lihat data  >  ',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
