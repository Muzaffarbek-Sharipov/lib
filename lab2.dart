//problem set 1

//2

// void main(List<String> arguments){
//   print("Length of arguments: ${arguments.length}");
// }

//3

// void main(List<String> arguments) {
//   if(arguments.isEmpty){
//     print("No arg");
//     return;
//   }
//   double sum = 0;
//   int count = 0;
//   for (var arg in arguments) {
//       double num = double.parse(arg);
//       sum += num;
//       count++;
//     }
  
//   print("Average of arguments: ${sum / count}");
// }

//4

// void main(List<String> arguments) {
//   if (arguments.isEmpty) {
//     print("No arguments provided.");
//     return;
//   }
//   if (arguments.length != 2) {
//     print("Please provide exactly two numbers");
//     print("You provided ${arguments.length} arguments.");
//     return;
//   }
// }



//PROBLEM 2

//1

// void main(){
//   int age =20;
//   String country  = "uzb";
//   double gpa = 4.5;
//   bool isStudent= true;

//   print(age);
//   print(gpa);
//   print(country);
// }

//2

// void main(){
//   final runTime= DateTime.now();
//   print(runTime);
// }

//3

// void main(){
//   String? city;
//   String displayCity = city ?? "Unknown";
//   print(displayCity);

//   city = "Tashkent";
//   String updatedCity = city ?? "Unknown";
//   print(updatedCity);
// } 

//4

// void main(){
//   dynamic thing = "Hello";
//   if (thing is String) {
//     print("The length of the string is: ${thing.length}");
//   } else {
//     print("The variable 'thing' is not a string.");
//   }

// }

// PROBLEM SET 3

//1

// void main() {
//   int number = -5;
  
//   if (number > 0) {
//     print('$number is positive.');
//   } else if (number < 0) {
//     print('$number is negative.');
//   } else {
//     print('The number is zero.');
//   }
// }

//2

// void main() {
//   int n = 5;  
//   int factorialStandard = 1;
//   for (int i = 1; i <= n; i++) {
//     factorialStandard *= i;
//   }
//   print('Factorial of $n (Standard for loop): $factorialStandard');

//   int factorialForIn = 1;
//   List<int> numbers = List.generate(n, (index) => index + 1);
  
//   for (int num in numbers) {
//     factorialForIn *= num;
//   }
//   print('Factorial of $n (for-in loop): $factorialForIn');
// }

//3

// import 'dart:math';

// void main() {
//   int targetValue = 7;
//   int guess = 0;
//   int attempts = 0;
//   Random random = Random();

//   while (true) {
//     guess = random.nextInt(10) + 1; 
//     attempts++;
    
//     if (guess == targetValue) {
//       print('Target $targetValue found in $attempts attempts');
//       break; 
//     } else {
//       print('Guessed $guess. Trying again...');
//     }
//   }
// }

//4

// void main() {
//   outerLoop:
//   for (int i = 1; i <= 3; i++) {
//     for (int j = 1; j <= 3; j++) {
//       if (i == 2 && j == 2) {
//         print('  -> Skipping i=2, j=2 and continuing outer loop');
//         continue outerLoop; 
//       }
      
//       if (i == 3 && j == 2) {
//         print('  -> Breaking outer loop entirely at i=3, j=2');
//         break outerLoop; 
//       }
      
//       print('i: $i, j: $j');
//     }
//   }
// }

//problem set 4

//1

// bool isEven(int n) => n % 2 == 0;

// void main() {
//   print('Is 10 even? ${isEven(10)}');
//   print('Is 7 even? ${isEven(7)}');
// }

//2


// String formatMessage(String message, [String prefix = '', String suffix = '']) {
//   return '$prefix$message$suffix';
// }

// void main() {
//   print(formatMessage('Alert')); 
//   print(formatMessage('Alert', 'ERROR: ')); 
//   print(formatMessage('Alert', 'ERROR: ', ' !!!')); 
// }

//3

// List<int> transformNumbers(List<int> numbers, int Function(int) transformer) {
//   List<int> result = [];
//   for (int number in numbers) {
//     result.add(transformer(number));
//   }
//   return result;
// }

// void main() {
//   List<int> myNumbers = [1, 2, 3, 4, 5];
  
//   List<int> multiplied = transformNumbers(myNumbers, (n) => n * 3);
  
//   print('Original: $myNumbers');
//   print('Transformed: $multiplied');
// }

//4

// int fibonacci(int n) {
//   if (n <= 0) return 0;
//   if (n == 1) return 1;
  
//   return fibonacci(n - 1) + fibonacci(n - 2);
// }

// void main() {
//   int target = 8;
//   print('The Fibonacci number at position $target is: ${fibonacci(target)}');
// }

