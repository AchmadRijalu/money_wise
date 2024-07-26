

import 'package:money_wise/models/category_model.dart';
import 'package:money_wise/theme/theme.dart';

List<CategoryModel> getCategories() {
  return categories.values.toList();
}

Map<int, CategoryModel> categories = {
  1: CategoryModel(
      id: 1,
      title: "Makanan",
      color: categoryYellowColor,
      image: "assets/images/image_pizza.svg"),
  2: CategoryModel(
      id: 2,
      title: "Internet",
      color: categoryBlueInternetColor,
      image: "assets/images/image_internet.svg"),
  3: CategoryModel(
      id: 3,
      title: "Edukasi",
      color: categoryOrangeColor,
      image: "assets/images/image_book.svg"),
  4: CategoryModel(
      id: 4,
      title: "Hadiah",
      color: categoryRedColor,
      image: "assets/images/image_gift.svg"),
  5: CategoryModel(
      id: 5,
      title: "Transport",
      color: categoryPurpleColor,
      image: "assets/images/image_car.svg"),
  6: CategoryModel(
      id: 6,
      title: "Belanja",
      color: categoryGreenColor,
      image: "assets/images/image_cart.svg"),
  7: CategoryModel(
      id: 7,
      title: "Alat Rumah",
      color: categoryPinkColor,
      image: "assets/images/image_home.svg"),
  8: CategoryModel(
      id: 8,
      title: "Olahraga",
      color: categoryBlueOlahragaColor,
      image: "assets/images/image_basketball.svg"),
  9: CategoryModel(
      id: 9,
      title: "Hiburan",
      color: categoryBlueHiburanColor,
      image: "assets/images/image_board.svg"),
};
