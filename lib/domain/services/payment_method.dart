// Common payment contract keeps checkout independent from payment strategy.
// Strategy contract keeps checkout independent from a payment mechanism.
abstract interface class PaymentMethod {
  String get name;
  Future<void> pay({required double amount});
}

class CashPayment implements PaymentMethod {
  @override
  String get name => 'cash';

  @override
  Future<void> pay({required double amount}) async {}
}

class CardPayment implements PaymentMethod {
  @override
  String get name => 'card';

  @override
  Future<void> pay({required double amount}) async {}
}
