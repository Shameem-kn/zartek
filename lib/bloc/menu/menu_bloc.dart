import 'package:bloc/bloc.dart';
import 'package:zartek/bloc/menu/menu_event.dart';
import 'package:zartek/bloc/menu/menu_state.dart';

import '../../domain/repo_impl/menu_repo.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepo _menuRepo;

  MenuBloc({required MenuRepo menuRepo})
      : _menuRepo = menuRepo,
        super(MenuInitial()) {
    on<FetchMenuEvent>(_onFetchMenu);
  }

  Future<void> _onFetchMenu(
      FetchMenuEvent event, Emitter<MenuState> emit) async {
    emit(MenuLoading());
    try {
      final menu = await _menuRepo.getFoodApi();
      emit(MenuLoaded(menu));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }
}
