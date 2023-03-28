import 'package:riverpod/riverpod.dart';

class ItemLazyLoading extends StateNotifier<int> {
  ItemLazyLoading() : super(10);

  void increaseLimit() => state = state + 10;
}

final itemLazyLoadingProvider =
    StateNotifierProvider<ItemLazyLoading, int>((ref) => ItemLazyLoading());
