import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/pick_location/providers/pick_location_providers.dart';
import 'package:mobileapp/features/pick_location/widgets/location_display.dart';
import 'package:mobileapp/features/pick_location/widgets/location_picker_dialog.dart';

const kPrimaryRed = Color(0xFFDA291C);

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Utilisation de .watch pour réagir aux changements du provider
    final addressAsync = ref.watch(addressFromConfirmedProvider);
    // Ajout: surveiller également la position confirmée pour nous assurer que l'UI se met à jour
    final confirmedPosition = ref.watch(confirmedPositionProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryRed,
        title: const Text("Sélection localisation"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text("Définir ma localisation"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
              ),
              onPressed:
                  () => showDialog(
                    context: context,
                    builder: (ctx) => const LocationPickerDialog(),
                  ),
            ),
            const SizedBox(height: 24),
            addressAsync.when(
              data:
                  (address) => Text(
                    address == null
                        ? "Aucune localisation définie."
                        : "Adresse : $address",
                    style: const TextStyle(fontSize: 16),
                  ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text("Erreur : $e"),
            ),
            if (confirmedPosition != null) ...[
              const SizedBox(height: 16),

              LocationDisplay(position: confirmedPosition),
            ],
          ],
        ),
      ),
    );
  }
}
