import 'package:zartek/model/menu_model.dart';

import 'package:zartek/repository/menu_repo/menu_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';

import '../../utils/app_url.dart';

// class MenuRepoImpl implements MenuRepo {
//   final BaseApiServices _apiServices = NetworkApiService();

//   @override
//   Future<MenuModel> getFoodApi() async {
//     dynamic response = await _apiServices.getApi(AppUrl.appUrl);
//     return MenuModel.fromJson(response);
//   }
// }

class MenuRepoImpl implements MenuRepo {
  final BaseApiServices _apiServices;

  MenuRepoImpl(this._apiServices);

  @override
  Future<MenuModel> getFoodApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.appUrl);
    return MenuModel.fromJson(response);
  }
}
