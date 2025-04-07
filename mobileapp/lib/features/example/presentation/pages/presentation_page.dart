import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';
import '../widgets/user_list.dart';

class ExamplePage extends ConsumerStatefulWidget {
  const ExamplePage({super.key});

  @override
  ConsumerState<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends ConsumerState<ExamplePage> {
  Future<void> _refresh() async {
    return await ref.refresh(usersFutureProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final usersAsyncValue = ref.watch(usersFutureProvider);

    return Container(
      color: Colors.white,
      child: usersAsyncValue.when(
        data: (users) => RefreshIndicator(
          onRefresh: _refresh,
          child: UserList(users: users),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Erreur : $err')),
      ),
    );
  }
}
