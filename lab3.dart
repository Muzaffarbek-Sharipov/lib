//PROBLEM SET 5
//1

/// Represents a user's bank account with deposit and withdrawal capabilities.
class BankAccount {
  /// The current balance of the account in USD.
  double balance;

  /// Creates a new [BankAccount] with an [initialDeposit].
  ///
  /// Throws an [ArgumentError] if [initialDeposit] is negative.
  BankAccount(double initialDeposit) : balance = initialDeposit {
    if (initialDeposit < 0) {
      throw ArgumentError('Deposit cannot be negative');
    }
  }

  /// Deposits an [amount] into the account.
  ///
  /// The [amount] must be strictly greater than zero.
  void deposit(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Deposit amount must be positive');
    }
    balance += amount;
  }
}

//2
/*
  Calculates the total compound interest using the formula:
  A = P * (1 + r / n)^(n * t)
  
  Where:
  - P = Principal amount
  - r = Annual interest rate (in decimal form)
  - n = Number of times interest is compounded per year
  - t = Time the money is invested for (in years)
*/
import 'dart:math';

double calculateCompoundInterest({
  required double principal,
  required double annualRate,
  required int compoundFrequency,
  required double years,
}) {
  double ratePerPeriod = annualRate / compoundFrequency;

\  double totalPeriods = compoundFrequency * years;

  double finalAmount = principal * pow(1 + ratePerPeriod, totalPeriods);

  return finalAmount; 
}

//3
/// A utility class for validating common input data formats.
class ValidationUtils {
  /// Validates whether the given [email] is formatted correctly.
  ///
  /// Takes a [String] [email] representing the address to validate.
  ///
  /// Returns `true` if [email] is a valid format; otherwise, returns `false`.
  ///
  /// Throws a [FormatException] if [email] is empty or whitespace-only.
  static bool isValidEmail(String email) {
    if (email.trim().isEmpty) {
      throw FormatException('Email cannot be empty.');
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validates a user's [age].
  ///
  /// Takes an integer [age] to verify eligibility.
  ///
  /// Returns `true` if the [age] is 18 or older.
  ///
  /// Throws a [RangeError] if [age] is negative or exceeds `130`.
  static bool isAdult(int age) {
    if (age < 0 || age > 130) {
      throw RangeError.range(age, 0, 130, 'age', 'Age must be between 0 and 130.');
    }
    return age >= 18;
  }
}

//PROBLEM SET 6
//1
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  @override
  String toString() => 'Person(name: $name, age: $age)';
}

void main() {
  var person = Person('Alice', 25);
  print(person); 
}

//2
class Rectangle {
  final double width;
  final double height;

  Rectangle(double w, double h)
      : assert(w > 0, 'Width must be greater than zero'),
        assert(h > 0, 'Height must be greater than zero'),
        width = w,
        height = h;
}

//3
class DatabaseService {
  DatabaseService._internal();

  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  void query(String sql) {
    print('Executing query: $sql');
  }
}

void main() {
  var db1 = DatabaseService();
  var db2 = DatabaseService();

  print(identical(db1, db2)); 
}

//problem set 7
//1
enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

void main() {
  for (final day in Day.values) {
    print('${day.name} (index: ${day.index})');
  }
}

//2
enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

/// Maps an [OrderStatus] to a user-friendly UI display string.
String getStatusDisplay(OrderStatus status) => switch (status) {
  OrderStatus.pending => 'Order Placed - Pending Confirmation',
  OrderStatus.processing => 'Preparing Your Items',
  OrderStatus.shipped => 'On the Way',
  OrderStatus.delivered => 'Delivered to Address',
  OrderStatus.cancelled => 'Order Cancelled',
};

void main() {
  var currentStatus = OrderStatus.shipped;
  print(getStatusDisplay(currentStatus)); 
}

//3
/// Abstract interface defining a discount policy
abstract interface class Discountable {
  double applyDiscount(double price);
}

/// Enhanced enum implementing [Discountable]
enum MembershipTier implements Discountable {
  bronze(discountRate: 0.05),
  silver(discountRate: 0.10),
  gold(discountRate: 0.20),
  platinum(discountRate: 0.30);

  final double discountRate;

  const MembershipTier({required this.discountRate});

  @override
  double applyDiscount(double price) {
    return price * (1.0 - discountRate);
  }

  double calculateSavings(double price) {
    return price * discountRate;
  }
}

void main() {
  const originalPrice = 100.0;
  final tier = MembershipTier.gold;

  print('Discounted Price: \$${tier.applyDiscount(originalPrice)}'); 
  print('Total Savings: \$${tier.calculateSavings(originalPrice)}');   


//PROBLEM SET 8
//1
// Base class
class Animal {
  final String name;

  Animal(this.name);

  void makeSound() {
    print('$name makes a sound.');
  }
}


class Dog extends Animal {
  Dog(super.name);

  @override
  void makeSound() {
    print('$name barks: Woof! Woof!');
  }
}

void main() {
  final animal = Animal('Generic Animal');
  final dog = Dog('Buddy');

  animal.makeSound();
  dog.makeSound();   
}