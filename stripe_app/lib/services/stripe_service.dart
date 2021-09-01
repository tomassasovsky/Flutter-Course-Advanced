import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();
  static final StripeService _instance = StripeService._();
  factory StripeService() => _instance;

  final _publishableKey = 'pk_test_51JUlJsDnjqlUYqXk65rH0whg0Q1Ey1mGMXDFp50xPTvl865dMexxThEdPw2pvdFCADwCh4dhZyi2QtHKSoRDXBMx00L2n6T8xx';
  final _secretKey = 'sk_test_51JUlJsDnjqlUYqXk9HSxiOKhfezZT1boEoUbsovcM8JBgcCUDTE6ArD7Q72fwPkgDbDuHIVqPnkHkNtH67E6UxJt00pKnxBwOQ';
  final _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';

  void init() {}

  Future payWithExistingCard({
    required String amount,
    required String currency,
    required Card card,
  }) async {}

  Future payWithNewCard({
    required String amount,
    required String currency,
  }) async {}

  Future payWithAppleOrGooglePay({
    required String amount,
    required String currency,
  }) async {}

  Future _createPaymentIntent({
    required String amount,
    required String currency,
  }) async {}

  Future _completePayment({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod,
  }) async {}
}
