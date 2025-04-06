
import 'package:flutter/material.dart';
import 'package:mobileapp/features/home/business/entities/user_entity.dart';

class UserList extends StatelessWidget {
  final List<UserEntity> users;

  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.username),
          subtitle: Text('Role: ${user.role}'),
          leading: CircleAvatar(child: Text(user.id.toString())),
        );
      },
    );
  }
}
