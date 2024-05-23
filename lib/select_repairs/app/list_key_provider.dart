import 'package:daily_phones/select_repairs/views/widgets/repair_summary.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_key_provider.g.dart';

@riverpod
class ListKey extends _$ListKey {
  @override
  GlobalKey<AnimatedListState> build() {
    return GlobalKey<AnimatedListState>();
  }

  void refreshKey() {
    state = GlobalKey<AnimatedListState>();
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
