abstract class Vehicle {
  void start();
}

class Bike extends Vehicle {
  @override
  void start() {
    print("Bike started");
  }
}

void main() {
  Bike myBike = Bike();
  myBike.start();
}
