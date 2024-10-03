import 'package:flutter_lorem/flutter_lorem.dart' as lorem;

import '../models/car.dart';

class AppCars {
  int count = 5;
  List<Car> getCars() {
    List<Car> cars = [];
    for (var i = 1; i <= count; i++) {
      cars.add(Car(
        id: i,
        title: lorem.lorem(words: 1),
        description: lorem.lorem(words: 100),
        image_path: "assets/images/car-$i.png",
        score: i,
      ));
    }
    return cars;
  }
}
