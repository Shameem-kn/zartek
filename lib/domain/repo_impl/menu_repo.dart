import '../../model/menu_model.dart';

abstract class MenuRepo {
  Future<MenuModel> getFoodApi();
}
