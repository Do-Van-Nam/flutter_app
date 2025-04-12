int sum(int a, int b) {
  return a + b;
}

void greet(String name, [String greeting = 'Hello']) {
  print('$greeting $name');
}

void info({int age = 0, String city = 'Unknown'}) {
  print(' Age: $age, City: $city');
}

int square(int a) => a * a;
int cube(int a) => a * a * a;

Function multiply(int a) {
  return (int b)=> a * b;
}

Future <void> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  print('Data fetched!');
}


void main() async {
  print(sum(2, 3)); // Output: 5

  var ar = [1, 2, 3, 4, 5];
  ar.forEach((num) {
    print(num);
  });

  var Times = multiply(2);
  print(Times(3)); // Output: 6


  await fetchData(); // Output: Data fetched! after 2 seconds
}
