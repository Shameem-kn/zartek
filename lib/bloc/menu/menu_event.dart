import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMenuEvent extends MenuEvent {}
