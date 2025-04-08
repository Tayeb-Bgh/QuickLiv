import 'package:flutter/material.dart';
import 'package:mobileapp/features/example/business/entities/user_entity.dart';

class UserList extends StatelessWidget {
  final List<UserEntity> users;

  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final hobbies = user.hobies;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: ListTile(
            title: Text(user.username),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Âge: ${user.age} ans'),  // Affichage de l'âge
                Text('Role: ${user.role}'),
                const SizedBox(height: 4),
                Text(
                  hobbies.isNotEmpty
                      ? 'Hobbies: ${hobbies.map((h) => h.name).join(", ")}'
                      : 'Aucun hobby trouvé',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            leading: user.imgUrl.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(user.imgUrl), // Affichage de l'image
                    radius: 25,
                  )
                : CircleAvatar(
                    radius: 25,
                    child: Text(
                      user.username.isNotEmpty 
                          ? user.username[0].toUpperCase() 
                          : '?',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
          ),
        );
      },
    );
  }
}