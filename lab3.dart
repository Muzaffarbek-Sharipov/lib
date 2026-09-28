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

//4
/// Abstract service interface defining data persistence operations.
abstract class StorageService {
  /// Saves the provided [data] to persistent storage.
  void saveData(String data);
}

/// A local file implementation of [StorageService].
class FileStorageService implements StorageService {
  /// Saves the given [data] to disk.
  ///
  /// Implements [StorageService.saveData].
  @override
  void saveData(String data) {
    print('Saving data to local file: $data');
  }

  /// Writes data directly to an unencrypted temporary file.
  ///
  /// Deprecated: Use [saveData] instead for safer persistence.
  /// Will be removed in version 2.0.0.
  @Deprecated('Use saveData() instead. This method will be removed in v2.0.0')
  void writeRawTemp(String data) {
    print('Writing raw data: $data');
  }
}

void main() {
  final storage = FileStorageService();

  // Standard overridden method call
  storage.saveData('User preference: Dark mode');

  // Triggering deprecated method (IDE will strike-through this method)
  // ignore: deprecated_member_use
  storage.writeRawTemp('Temp log');
}

//5
/// A client library for interacting with the Weather REST API.
///
/// Use [WeatherApiClient] to retrieve current weather conditions and forecasts.
///
/// ### Example:
/// ```dart
/// final client = WeatherApiClient(apiKey: 'your_api_key_here');
/// try {
///   final report = await client.fetchCurrentWeather('Tashkent');
///   print('Temperature: ${report.temperatureC}°C');
/// } on WeatherApiException catch (e) {
///   print('API Error: ${e.message}');
/// }
/// ```
class WeatherApiClient {
  /// The authentication key used for authorized API requests.
  final String apiKey;

  /// The base URL endpoint of the weather service.
  final Uri baseUrl;

  /// Creates a new [WeatherApiClient] instance.
  ///
  /// Requires an [apiKey]. Optionally accepts an alternative [baseUrl].
  WeatherApiClient({
    required this.apiKey,
    Uri? baseUrl,
  }) : baseUrl = baseUrl ?? Uri.parse('https://api.weather.example.com/v1');

  /// Fetches the current weather report for a given [cityName].
  ///
  /// * [cityName]: The name of the city (e.g., `'London'`, `'Tokyo'`).
  ///
  /// Returns a [Future] completing with a [WeatherReport].
  ///
  /// Throws an [ArgumentError] if [cityName] is blank.
  /// Throws a [WeatherApiException] if the server returns a non-200 response.
  Future<WeatherReport> fetchCurrentWeather(String cityName) async {
    if (cityName.trim().isEmpty) {
      throw ArgumentError.value(cityName, 'cityName', 'City name cannot be empty.');
    }

    // Simulated network call
    return WeatherReport(
      city: cityName,
      temperatureC: 22.5,
      condition: 'Sunny',
    );
  }
}

/// Represents the weather status of a specific location.
class WeatherReport {
  /// Name of the city.
  final String city;

  /// Current temperature in degrees Celsius.
  final double temperatureC;

  /// Current sky condition description (e.g., 'Sunny', 'Rainy').
  final String condition;

  /// Creates a [WeatherReport] model.
  const WeatherReport({
    required this.city,
    required this.temperatureC,
    required this.condition,
  });

  /// The temperature converted to degrees Fahrenheit.
  double get temperatureF => (temperatureC * 9 / 5) + 32;

  @override
  String toString() => '$city: $temperatureC°C ($condition)';
}

/// Exception thrown when the weather API fails to fulfill a request.
class WeatherApiException implements Exception {
  /// The descriptive error message from the API.
  final String message;

  /// The HTTP status code returned by the endpoint, if available.
  final int? statusCode;

  /// Creates a [WeatherApiException] with a [message] and an optional [statusCode].
  const WeatherApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'WeatherApiException: $message (Status: $statusCode)';
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

//4
class BankAccount {
  // Private backing field
  double _balance;

  BankAccount([double initialBalance = 0.0]) : _balance = initialBalance {
    if (initialBalance < 0) {
      throw ArgumentError('Initial balance cannot be negative.');
    }
  }

  /// Custom getter to expose the balance
  double get balance => _balance;

  set balance(double newBalance) {
    if (newBalance < 0) {
      throw ArgumentError('Balance cannot be set to a negative value.');
    }
    if (_balance - newBalance > 50000) {
      throw StateError('Daily single-transaction withdrawal limit exceeded.');
    }
    _balance = newBalance;
  }
}

//5
class UserDto {
  final int id;
  final String username;
  final String email;
  final DateTime createdAt;

  /// Constant constructor initializing all final fields
  const UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  /// Factory constructor to deserialize from JSON map
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Converts the DTO into a JSON map for transmission
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'createdAt': createdAt.toIso8601String(),
  };

  @override
  String toString() => 'UserDto(id: $id, username: $username, email: $email)';
}

void main() {
  final user = UserDto(
    id: 101,
    username: 'john_doe',
    email: 'john@example.com',
    createdAt: DateTime.utc(2024, 1, 1),
  );

  print(user); 

  final json = user.toJson();
  print(json);

  final restoredUser = UserDto.fromJson(json);
  print('Restored User: ${restoredUser.username}');
}

void main() {
  final account = BankAccount(100.0);

  print('Current balance: ${account.balance}'); // 100.0

  account.balance = 250.0;
  print('Updated balance: ${account.balance}'); // 250.0

  try {
    account.balance = -50.0;
  } catch (e) {
    print('Caught error: $e'); 
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
}

//4
enum Priority {
  low,
  medium,
  high,
}

Priority? parsePrioritySafely(String raw) {
  try {
    return Priority.values.byName(raw.trim().toLowerCase());
  } on ArgumentError {
    return null;
  }
}

void main() {
  String validString = 'high';
  String invalidString = 'urgent';

  Priority? result1 = parsePrioritySafely(validString);
  Priority? result2 = parsePrioritySafely(invalidString);

  print(result1); // Priority.high
  print(result2); // null
}

//5
enum ConfigProperty<T> {
  maxRetries<int>(3),
  timeoutMs<double>(5000.0),
  appName<String>('MyApp'),
  debugMode<bool>(false);

  final T defaultValue;

  const ConfigProperty(this.defaultValue);

  static ConfigProperty<T>? getByExactType<T>() {
    for (final property in ConfigProperty.values) {
      if (property.defaultValue is T) {
        return property as ConfigProperty<T>;
      }
    }
    return null;
  }

  static void printAllDefaults() {
    for (final prop in ConfigProperty.values) {
      print('${prop.name}: ${prop.defaultValue} (${prop.defaultValue.runtimeType})');
    }
  }
}

void main() {
  final intProp = ConfigProperty.getByExactType<int>();
  print(intProp); // ConfigProperty.maxRetries

  ConfigProperty.printAllDefaults();
}

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

//2
class Car {
  final String brand;

  Car(this.brand);
}

class ElectricCar extends Car {
  final double batteryCapacity; // In kWh

  ElectricCar(super.brand, this.batteryCapacity);

  void printDetails() {
    print('Brand: $brand, Battery: $batteryCapacity kWh');
  }
}

void main() {
  final myCar = ElectricCar('Tesla', 75.0);
  myCar.printDetails(); 
}

//3
import 'dart:math';

abstract class Shape {
  final String name;

  Shape(this.name);

  double calculateArea();
}

abstract class Polygon extends Shape {
  final int sides;

  Polygon(super.name, this.sides);
}

class Triangle extends Polygon {
  final double a;
  final double b;
  final double c;

  Triangle(this.a, this.b, this.c) : super('Triangle', 3);

  @override
  double calculateArea() {
    final s = (a + b + c) / 2;
    return sqrt(s * (s - a) * (s - b) * (s - c));
  }
}

void main() {
  final tri = Triangle(3, 4, 5);

  print('Shape name: ${tri.name}');           
  print('Number of sides: ${tri.sides}');    
  print('Area: ${tri.calculateArea()}');      
}

//4

abstract class Vehicle {
  final String model;

  Vehicle(this.model);

  void startEngine();

  void stopEngine();

  void displayInfo() {
    print('Vehicle Model: $model');
  }
}

class Car extends Vehicle {
  Car(super.model);

  @override
  void startEngine() {
    print('$model: Push button ignition started.');
  }

  @override
  void stopEngine() {
    print('$model: Engine turned off.');
  }
}

void main() {
  final myCar = Car('Toyota Camry');
  myCar.displayInfo();
  myCar.startEngine();
  myCar.stopEngine();
}

//5
import 'security_library.dart';

base class CustomProcessor extends BasePaymentProcessor {
  CustomProcessor(super.amount);
}

void main() {
  final token = ImmutableToken('abc-123-xyz');
  token.validate();

  final processor = CustomProcessor(99.99);
  processor.processPayment();
}
``````dart
abstract class Vehicle {
  final String model;

  Vehicle(this.model);

  void startEngine();

  void displayInfo() {
    print('Vehicle model: $model');
  }
}

class Car extends Vehicle {
  Car(super.model);

  @override
  void startEngine() {
    print('Car $model engine started with ignition key.');
  }
}

void main() {
  Vehicle myCar = Car('Toyota Camry');
  myCar.displayInfo();
  myCar.startEngine();
}

//problem set 9

//1
abstract interface class DBConnector {
  void connect();
  void disconnect();
  void executeQuery(String query);
}

class MySQLConnector implements DBConnector {
  final String host;
  final int port;

  MySQLConnector(this.host, this.port);

  @override
  void connect() {
    print('Connected to MySQL at $host:$port');
  }

  @override
  void disconnect() {
    print('Disconnected from MySQL');
  }

  @override
  void executeQuery(String query) {
    print('Executing MySQL query: $query');
  }
}

void main() {
  final DBConnector db = MySQLConnector('localhost', 3306);
  db.connect();
  db.executeQuery('SELECT * FROM users;');
  db.disconnect();
}
//2
mixin Flyable {
  void fly() {
    print('Flying high in the sky');
  }
}

class Bird with Flyable {
  final String species;

  Bird(this.species);
}

void main() {
  final eagle = Bird('Eagle');
  print(eagle.species);
  eagle.fly();
}
//3
mixin Walker {
  void walk() {
    print('Walking on land');
  }
}

mixin Swimmer {
  void swim() {
    print('Swimming in water');
  }
}

mixin Flyable {
  void fly() {
    print('Flying through the air');
  }
}

class Duck with Walker, Swimmer, Flyable {
  final String name;

  Duck(this.name);
}

void main() {
  final duck = Duck('Donald');
  duck.walk();
  duck.swim();
  duck.fly();
}
//4
abstract class Animal {
  final String name;

  Animal(this.name);
}

mixin MammalBehavior on Animal {
  void nurse() {
    print('$name is nursing young');
  }
}

class Cat extends Animal with MammalBehavior {
  Cat(super.name);
}

void main() {
  final cat = Cat('Whiskers');
  cat.nurse();
}
//5
abstract class LoggerInterface {
  void log(String message);
}

class ConsoleService implements LoggerInterface {
  @override
  void log(String message) {
    print('ConsoleService (implements): $message');
  }
}

mixin LoggerMixin {
  void log(String message) {
    print('LoggerMixin (with): $message');
  }
}

class DatabaseService with LoggerMixin {
  void execute() {
    log('Transaction completed.');
  }
}

void main() {
  final console = ConsoleService();
  console.log('Application started.');

  final db = DatabaseService();
  db.execute();
  db.log('Direct call via mixin.');
}

//problem set 10

//1
import 'dart:math';

abstract class Shape {
  double area();
}

class Circle extends Shape {
  final double radius;

  Circle(this.radius);

  @override
  double area() => pi * radius * radius;
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  double area() => width * height;
}

void main() {
  final List<Shape> shapes = [
    Circle(5.0),
    Rectangle(4.0, 6.0),
    Circle(2.5),
  ];

  for (final shape in shapes) {
    print(shape.area());
  }
}
//2
abstract class Vehicle {}

class Car extends Vehicle {
  void drive() {
    print('Driving on the road');
  }
}

class Boat extends Vehicle {
  void sail() {
    print('Sailing on water');
  }
}

void operateVehicle(Vehicle vehicle) {
  if (vehicle is Car) {
    vehicle.drive();
  }

  final Object mysteryObject = vehicle;
  final Car forcedCar = mysteryObject as Car;
  forcedCar.drive();
}

void main() {
  final Vehicle myCar = Car();
  operateVehicle(myCar);
}

//3
abstract class Entity {
  final int id;

  Entity(this.id);
}

class User extends Entity {
  final String name;

  User(super.id, this.name);
}

class Product extends Entity {
  final String title;

  Product(super.id, this.title);
}

class Repository<T extends Entity> {
  final List<T> _items = [];

  void add(T item) {
    _items.add(item);
  }

  T? getById(int id) {
    for (final item in _items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  List<T> getAll() => List.unmodifiable(_items);
}

void main() {
  final userRepo = Repository<User>();
  userRepo.add(User(1, 'Alice'));
  userRepo.add(User(2, 'Bob'));

  final user = userRepo.getById(1);
  print(user?.name);

  final productRepo = Repository<Product>();
  productRepo.add(Product(101, 'Laptop'));

  final product = productRepo.getById(101);
  print(product?.title);
}

//4
sealed class NetworkState {}

class Loading extends NetworkState {}

class Success extends NetworkState {
  final String data;

  Success(this.data);
}

class Failure extends NetworkState {
  final String errorMessage;

  Failure(this.errorMessage);
}

String handleState(NetworkState state) {
  return switch (state) {
    Loading() => 'Fetching data...',
    Success(:final data) => 'Data loaded: $data',
    Failure(:final errorMessage) => 'Error: $errorMessage',
  };
}

void main() {
  final NetworkState state1 = Loading();
  final NetworkState state2 = Success('Profile Data');
  final NetworkState state3 = Failure('Connection timed out');

  print(handleState(state1));
  print(handleState(state2));
  print(handleState(state3));
}

//5
abstract interface class PaymentStrategy {
  void pay(double amount);
}

class CreditCardPayment implements PaymentStrategy {
  final String cardNumber;

  CreditCardPayment(this.cardNumber);

  @override
  void pay(double amount) {
    print('Paid \$$amount using Credit Card ($cardNumber)');
  }
}

class PayPalPayment implements PaymentStrategy {
  final String email;

  PayPalPayment(this.email);

  @override
  void pay(double amount) {
    print('Paid \$$amount using PayPal ($email)');
  }
}

class ShoppingCart {
  PaymentStrategy? _paymentStrategy;

  void setPaymentStrategy(PaymentStrategy strategy) {
    _paymentStrategy = strategy;
  }

  void checkout(double amount) {
    if (_paymentStrategy == null) {
      throw StateError('Payment strategy not set');
    }
    _paymentStrategy!.pay(amount);
  }
}

void main() {
  final cart = ShoppingCart();

  cart.setPaymentStrategy(CreditCardPayment('1234-5678-9012-3456'));
  cart.checkout(99.99);

  cart.setPaymentStrategy(PayPalPayment('user@example.com'));
  cart.checkout(45.50);
}

//problem set 11
//1
import 'dart:async';

Future<Map<String, dynamic>> fetchUserData(int userId) async {
  await Future.delayed(Duration(seconds: 2));
  return {
    'id': userId,
    'name': 'Alice Johnson',
    'email': 'alice@example.com',
  };
}

void main() async {
  print('Querying database...');
  final user = await fetchUserData(42);
  print('User retrieved: $user');
}

//2
import 'dart:async';

Future<String> fetchUsername() async {
  await Future.delayed(Duration(milliseconds: 500));
  return 'bob_smith';
}

Future<int> fetchUserPoints() async {
  await Future.delayed(Duration(milliseconds: 300));
  return 1250;
}

Future<List<String>> fetchUserBadges() async {
  await Future.delayed(Duration(milliseconds: 400));
  return ['Early Adopter', 'Top Contributor'];
}

void main() async {
  final results = await Future.wait([
    fetchUsername(),
    fetchUserPoints(),
    fetchUserBadges(),
  ]);

  final username = results[0] as String;
  final points = results[1] as int;
  final badges = results[2] as List<String>;

  print('Profile: $username | Points: $points | Badges: $badges');
}

//3
import 'dart:async';

void main() {
  final stream = Stream<int>.periodic(
    Duration(seconds: 1),
    (count) => count + 1,
  );

  late StreamSubscription<int> subscription;

  subscription = stream.listen((tick) {
    print('Tick: $tick');
    if (tick >= 5) {
      print('Limit reached. Cancelling subscription.');
      subscription.cancel();
    }
  });
}
//4
import 'dart:async';

void main() async {
  final numbers = Stream.fromIterable([1, 2, 2, 3, 4, 4, 5, 6, 7, 8, 8, 9]);

  final transformedStream = numbers
      .where((n) => n % 2 == 0)
      .distinct()
      .map((n) => 'Even Number Squared: ${n * n}');

  await for (final value in transformedStream) {
    print(value);
  }
}

//5
import 'dart:async';

Stream<int> countWithErrors() async* {
  yield 1;
  yield 2;
  throw Exception('Connection dropped unexpectedly');
  yield 3;
}

void main() {
  countWithErrors()
      .handleError((error) {
        print('Handled in stream pipeline: $error');
      })
      .listen(
        (data) => print('Received: $data'),
        onDone: () => print('Stream completed.'),
      );
}

//problem set 12
//1
int divideNumbers(int a, int b) {
  try {
    return a ~/ b;
  } on UnsupportedError catch (e) {
    print('Caught an UnsupportedError: ${e.message}');
    return 0;
  }
}

void main() {
  print(divideNumbers(10, 2));
  print(divideNumbers(10, 0)); 
}

//2
void validateUsername(String? username) {
  if (username == null || username.trim().isEmpty) {
    throw ArgumentError('Username must not be null or empty.');
  }

  print('Valid username: $username');
}

void main() {
  validateUsername('john_doe'); 

  try {
    validateUsername('');
  } catch (e) {
    print(e); 
  }
}

//3
void processInput(String input) {
  try {
    int parsedNumber = int.parse(input);
    if (parsedNumber < 0) {
      throw RangeError('Number must be non-negative.');
    }
    print('Processed number: $parsedNumber');
  } on FormatException catch (e) {
    print('Specific Handler [FormatException]: Invalid integer format -> ${e.message}');
  } on RangeError catch (e) {
    print('Specific Handler [RangeError]: Out of bounds -> ${e.message}');
  } catch (e) {
    print('Generic Handler [Exception]: An unexpected error occurred -> $e');
  }
}

void main() {
  processInput('abc'); 
  processInput('-5');  
}

//4
void deepFailure() {
  throw StateError('Database connection pool exhausted.');
}

void intermediateOperation() {
  deepFailure();
}

void main() {
  try {
    intermediateOperation();
  } catch (exception, stackTrace) {
    print('--- Exception Caught ---');
    print(exception);
    print('\n--- Full Stack Trace ---');
    print(stackTrace);
  }
}

//5
void logAndProcessOrder(int orderId) {
  try {
    if (orderId <= 0) {
      throw ArgumentError('Order ID must be positive.');
    }
    print('Processing order #$orderId');
  } catch (e, stackTrace) {
    print('[Audit Log] Failed processing order #$orderId: $e');
    rethrow;
  }
}

void main() {
  try {
    logAndProcessOrder(-1);
  } catch (e) {
    print('Top-level handler received: $e');
  }
}

