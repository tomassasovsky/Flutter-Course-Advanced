part of 'payment_bloc.dart';

@immutable
class PaymentState {
  final double total;
  final String currency;
  final bool isSelected;
  final CreditCardModel? card;

  PaymentState({
    this.total = 0.0,
    this.currency = 'USD',
    this.isSelected = false,
    this.card,
  });

  PaymentState copyWith({
    double? total,
    String? currency,
    bool? isSelected,
    CreditCardModel? card,
  }) {
    return PaymentState(
      total: total ?? this.total,
      currency: currency ?? this.currency,
      isSelected: isSelected ?? this.isSelected,
      card: card ?? this.card,
    );
  }
}
