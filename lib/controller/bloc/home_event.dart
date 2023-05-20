part of 'home_bloc.dart';

// these are the boc events on basis of which states are triggered/emited
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class OnCartRemove extends HomeEvent {
  final ProductDataModel removeCart;
  OnCartRemove({required this.removeCart});
}
