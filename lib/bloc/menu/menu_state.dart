// part of 'menu_bloc.dart';

// sealed class MenuState extends Equatable {
//   const MenuState();

//   @override
//   List<Object> get props => [];
// }

// final class MenuInitial extends MenuState {}
import 'package:equatable/equatable.dart';

import '../../model/menu_model.dart';

abstract class MenuState extends Equatable {
  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final MenuModel menu;

  MenuLoaded(this.menu);

  @override
  List<Object> get props => [menu];
}

class MenuError extends MenuState {
  final String message;

  MenuError(this.message);

  @override
  List<Object> get props => [message];
}
