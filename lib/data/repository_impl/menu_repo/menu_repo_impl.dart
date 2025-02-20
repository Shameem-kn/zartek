import 'package:zartek/model/menu_model.dart';

import 'package:zartek/domain/repo_impl/menu_repo.dart';

import '../../network/base_api_services.dart';

import '../../../core/app_url.dart';

class MenuRepoImpl implements MenuRepo {
  final BaseApiServices _apiServices;

  MenuRepoImpl(this._apiServices);

  @override
  Future<MenuModel> getFoodApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.appUrl);
    return MenuModel.fromJson(response);
  }
}
