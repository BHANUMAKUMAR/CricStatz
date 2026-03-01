import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({super.key, required this.name, required this.role});

  final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(name),
      subtitle: Text(role),
    );
  }
}
