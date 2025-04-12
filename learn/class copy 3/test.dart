class Animal {
  String name;
  int leg;

  Animal(this.name, this.leg);

  Animal.pet()
      : name = "pet",
        leg = 4;

  int get noLeg => leg;

  set noLeg(int value) {
    leg = value;
  }

  void speak() {
    print('animal sound');
  }
}

class Cat extends Animal {
  Cat(String name, int leg) : super(name, leg);

  @override
  void speak() {
    print('meow meow');
  }
}

void main() {
  Animal dog = Animal('dong', 4);
  var cat = Animal.pet();
  dog.noLeg = 4;
  print(dog.noLeg); // Output: 4

  Cat kitty = Cat('Kitty', 4);
  kitty.speak();    // Output: meow meow
}
