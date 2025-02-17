class Shape {
  void draw() {
    print("Drawing shape");
  }
}

class Circle extends Shape {
  @override
  void draw() {
    print("Drawing Circle");
  }
}

void main() {
  Shape shape = Circle();
  shape.draw(); // Calls Circle's draw()
}
