import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Event
abstract class MenuEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeMenuIndex extends MenuEvent {
  final int selectedIndex;

  ChangeMenuIndex(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

// State
class MenuState extends Equatable {
  final int selectedIndex;

  MenuState(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

// Bloc
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuState(1)) {
    on<ChangeMenuIndex>((event, emit) {
      emit(MenuState(event.selectedIndex));
    });
  }
}