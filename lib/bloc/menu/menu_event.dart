// part of 'menu_bloc.dart';

// sealed class MenuEvent extends Equatable {
//   const MenuEvent();

//   @override
//   List<Object> get props => [];
// }
import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMenuEvent extends MenuEvent {}
