class Person {
  String name;
  int age;

  // Default Constructor
  Person(this.name, this.age);

  // Named Constructor
  Person.named({this.name = "Unknown", this.age = 0});

  void show() {
    print("Name: $name, Age: $age");
  }
}

void main() {
  Person p1 = Person("John", 25);
  Person p2 = Person.named(age: 30);
  p1.show();
  p2.show();
}
