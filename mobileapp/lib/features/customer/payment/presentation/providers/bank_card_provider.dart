import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/payment/business/entities/bank_card.dart';
import 'package:mobileapp/features/customer/payment/business/usecases/verif_bank_card.dart';

final bankCardsProvider = Provider<List<BankCard>>((ref) {
  return [
    BankCard(
      cardNb: "6280702377317563",
      cvvNb: "292",
      dateExp: "09/26",
      nameOwner: "Badis AOURTILANE",
      sold: 0,
    ),
    BankCard(
      cardNb: "6280123401234560",
      cvvNb: "032",
      dateExp: "10/26",
      nameOwner: "Tayeb BOUGUERMOUH",
      sold: 122500,
    ),
    BankCard(
      cardNb: "6280123401234578",
      cvvNb: "336",
      dateExp: "8/25",
      nameOwner: "Anis AYOUAZ",
      sold: 2310,
    ),
    BankCard(
      cardNb: "6280123401234586",
      cvvNb: "298",
      dateExp: "01/26",
      nameOwner: "Doussan BENKERROU",
      sold: 2500,
    ),
    BankCard(
      cardNb: "6280123401234594",
      cvvNb: "931",
      dateExp: "05/25",
      nameOwner: "Amel BENAISSA",
      sold: 22500,
    ),
    BankCard(
      cardNb: "6280123401234602",
      cvvNb: "201",
      dateExp: "11/26",
      nameOwner: "Kenza BELALOUI",
      sold: 0,
    ),
  ];
});

final cardNbTextProvider = StateProvider<String>((ref) => "");

final cardNbTextControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      final initialText = ref.read(cardNbTextProvider); // read instead of watch
      final controller = TextEditingController(text: initialText);

      ref.onDispose(() => controller.dispose());

      return controller;
    });

final cvvNbTextProvider = StateProvider<String>((ref) => "");

final cvvNbControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final initialText = ref.read(cvvNbTextProvider); // read instead of watch
  final controller = TextEditingController(text: initialText);

  ref.onDispose(() => controller.dispose());

  return controller;
});

final dateExpTextProvider = StateProvider<String>((ref) => "");

final dateExpControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final initialText = ref.read(dateExpTextProvider); // read instead of watch
  final controller = TextEditingController(text: initialText);

  ref.onDispose(() => controller.dispose());

  return controller;
});

final owernNameTextProvider = StateProvider<String>((ref) => "");

final owernNameControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) {
    final initialText = ref.read(
      owernNameTextProvider,
    ); // read instead of watch
    final controller = TextEditingController(text: initialText);

    ref.onDispose(() => controller.dispose());

    return controller;
  },
);

final checkCardProvider = Provider<VerifBankCard>((ref) {
  return VerifBankCard(bankCardsList: ref.watch(bankCardsProvider));
});
