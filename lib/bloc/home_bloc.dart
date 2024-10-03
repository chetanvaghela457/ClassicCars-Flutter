import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Event
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadInitialItems extends HomeEvent {}
class ViewAllItems extends HomeEvent {}

// State
abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<Widget> items;
  HomeLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Widget> elements = [];
  List<Widget> items = [];

  HomeBloc() : super(HomeInitial()) {
    on<LoadInitialItems>((event, emit) {
      // Load initial items
      items = elements.take(15).toList();
      // Load first set of items
      emit(HomeLoaded(items));
    });

    on<ViewAllItems>((event, emit) {
      // Load all items
      items.addAll(elements.skip(15));
      emit(HomeLoaded(items));
    });
  }

  void initializeItems(List<Widget> element) {
    elements = element;
    var future = Future(() {});
    for (var element in elements) {
      future = future.then((_) {
        int index = items.length;
        items.insert(index, element);
        return Future.delayed(const Duration(milliseconds: 50));
      });
    }
  }
}