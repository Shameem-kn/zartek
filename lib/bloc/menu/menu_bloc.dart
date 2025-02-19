// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'menu_state.dart';

// class MenuBloc extends Bloc<MenuEvent, MenuState> {
//   MenuBloc() : super(MenuInitial()) {
//     on<MenuEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:zartek/bloc/menu/menu_event.dart';
import 'package:zartek/bloc/menu/menu_state.dart';

import '../../repository/menu_repo/menu_repo.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepo _menuRepo;

  // MenuBloc({required this.menuRepo}) : super(MenuInitial()) {
  //   on<FetchMenuEvent>(_onFetchMenu);
  // }
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
