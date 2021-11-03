import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;

  const ProfileHeader({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 80,
        padding: const EdgeInsets.all(16).copyWith(left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(color: Colors.white),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
