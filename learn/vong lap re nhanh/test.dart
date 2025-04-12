void main() {
  int a = 10;
  double b = 3.14;
  var grade = 'A';
  var mixedList =[1,'hello',true];

  if (a > 10) {
    print("lon hon 10");
  } else if (a > 5) {
    print("lon hon 5");
  } else {
    print('nho hon bang 5 ');
  }

  (a%2==0)? print('a la so chan'): print('a la so le');
  switch (grade) {
    case 'A':
      print('gioi');
      break;
    case 'B':
      print('Kha');
      break;
    default:
      print("khong xac dinh");
  }

  for (var i = 0; i < 5; i++) {
    print(i);
  }
  while(a>3){
    print(a);--a;
  }
  do {
    print(a); --a;
  } while (a>0);


  for (var element in mixedList) {
    print(element);
  }
}
