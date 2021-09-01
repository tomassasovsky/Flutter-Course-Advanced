class CreditCardModel {
  final String cardNumberHidden;
  final String cardNumber;
  final String brand;
  final String cvv;
  final String expiryDate;
  final String cardHolderName;

  CreditCardModel({
    required this.cardNumberHidden,
    required this.cardNumber,
    required this.brand,
    required this.cvv,
    required this.expiryDate,
    required this.cardHolderName,
  });
}
