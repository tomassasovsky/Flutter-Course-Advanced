part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class PaymentSelectCardEvent extends PaymentEvent {
  final CreditCardModel card;
  PaymentSelectCardEvent(this.card);
}

class PaymentUnselectCardEvent extends PaymentEvent {}
