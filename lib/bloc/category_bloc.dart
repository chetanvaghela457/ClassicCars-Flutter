import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Event
abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectCategory extends CategoriesEvent {
  final int selectedIndex;

  SelectCategory(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

// State
class CategoriesState extends Equatable {
  final int selectedIndex;

  CategoriesState(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

// Bloc
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState(0)) {
    on<SelectCategory>((event, emit) {
      emit(CategoriesState(event.selectedIndex));
    });
  }
}