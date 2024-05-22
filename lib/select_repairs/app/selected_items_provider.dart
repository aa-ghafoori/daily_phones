import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_items_provider.g.dart';

@riverpod
class SelectedItems extends _$SelectedItems {
  @override
  List build() {
    return [];
  }

  void addItem(dynamic item) {
    state = [...state, item];
  }

  void removeItem(dynamic item) {
    state = state.where((i) => i != item).toList();
  }
}
