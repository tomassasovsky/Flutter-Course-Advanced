import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe_app/models/credit_card.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState());

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is PaymentSelectCardEvent) {
      yield state.copyWith(card: event.card, isSelected: true);
    } else if (event is PaymentUnselectCardEvent) {
      yield state.copyWith(card: null, isSelected: false);
    }
  }
}
