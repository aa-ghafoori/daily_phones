import 'package:daily_phones/core/res/constants.dart';
import 'package:daily_phones/select_repairs/views/widgets/repair_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListKeyCubit extends Cubit<GlobalKey<AnimatedListState>> {
  ListKeyCubit() : super(GlobalKey<AnimatedListState>());

  void refreshKey() {
    redPrint('previos state: $state');
    final newState = GlobalKey<AnimatedListState>();
    emit(newState);
    greenPrint('new state: $state');
  }

  void addItem(int index, dynamic item) {
    state.currentState?.insertItem(index);
  }

  void removeItem(int index, dynamic item) {
    state.currentState?.removeItem(
      index,
      (context, animation) => BuildCheckoutItem(
        item: item,
        animation: animation,
        index: index,
      ),
    );
  }
}
