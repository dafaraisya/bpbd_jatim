import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String role;
  final String email;
  final String phone;
  final VoidCallback onTap;

  const UserCard({
    Key? key,
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: (Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Center(
                      child: Text(
                        role,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    // color: Theme.of(context).colorScheme.primary,
                    height: 32,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      email,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      phone,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const Divider(
                color: Color.fromARGB(123, 143, 149, 157),
                thickness: 1,
                height: 0,
              ),
            )
          ],
        ),
        width: double.infinity,
      )),
    );
  }
}
