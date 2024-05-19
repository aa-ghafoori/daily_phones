import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_bar_provider.g.dart';

@riverpod
class SearchBarNotifier extends _$SearchBarNotifier {
  late FocusNode _focusNode;
  @override
  bool build() {
    return false;
  }

  void setFocusNode(FocusNode focusNode) {
    _focusNode = focusNode;
  }

  void handleTapOutside() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  void setFocus(bool isFocused) {
    state = isFocused;
  }
}
