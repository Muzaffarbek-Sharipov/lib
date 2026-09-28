final class ImmutableToken {
  final### Problem 5: Create an abstract base class with concrete and abstract methods enforced on subclasses

 String token;

  ImmutableToken(this.token);

  void validate() {
    print('Validating token: $token');
  }
}

base class BasePaymentProcessor {
  final double amount;

  BasePaymentProcessor(this.amount);

  void processPayment() {
    print('Processing payment of \$$amount');
  }
}