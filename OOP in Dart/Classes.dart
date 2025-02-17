class Student {
  String name;
  int age;

  Student(this.name, this.age);

  void display() {
    print("Student: $name, Age: $age");
  }
}

void main() {
  Student s1 = Student("Alice", 21);
  s1.display();
}
