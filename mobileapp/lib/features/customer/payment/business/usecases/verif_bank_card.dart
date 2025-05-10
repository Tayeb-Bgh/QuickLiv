import 'package:mobileapp/features/customer/payment/business/entities/bank_card.dart';

class VerifBankCard {
  final List<BankCard> bankCardsList;
  VerifBankCard({required this.bankCardsList});

  int call(String cardNb, String cvv, String dateExp, String owerName) {
    print("liste $bankCardsList");
    return cardNb.isEmpty || cvv.isEmpty || dateExp.isEmpty || owerName.isEmpty
        ? 1
        : !BankCard.isValidAlgerianCardFormat(cardNb)
        ? 2
        : !BankCard.isValidCvvFormat(cvv)
        ? 3
        : !BankCard.isValidDateFormat(dateExp)
        ? 4
        : (bankCardsList
                .where(
                  (card) =>
                      card.cardNb == cardNb &&
                      card.cvvNb == cvv &&
                      card.dateExp == dateExp &&
                      card.nameOwner == owerName,
                )
                .isNotEmpty
            ? 0
            : 5);
  }
}
