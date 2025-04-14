import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import '../providers/groceries_provider.dart';

class idkoui extends ConsumerStatefulWidget {
  const idkoui({super.key});

  @override
  ConsumerState<idkoui> createState() => _ExamplePageState();
}

class _ExamplePageState extends ConsumerState<idkoui> {
  Future<void> _refresh() async {
    return await ref.refresh(groceriesListProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final groceriesList = ref.watch(groceriesListProvider);

    return Container(
      color: Colors.black26,
      child: groceriesList.when(
        data:
            (users) => RefreshIndicator(
              onRefresh: _refresh,
              child: Text("${users.length}"),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Text("ah tout va mal"),
      ),
    );
  }
}
