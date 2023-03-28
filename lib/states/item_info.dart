import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemInfoModel extends StateNotifier<Map<String, String>?> {
  ItemInfoModel() : super({});

  void update(String key, String newValue) {
    Map<String, String>? _tempMap = state;

    if (_tempMap!.containsKey(key)) {
      _tempMap.update(key, (value) => newValue);
    } else {
      _tempMap.putIfAbsent(key, () => newValue);
    }

    state = _tempMap;
  }
}
