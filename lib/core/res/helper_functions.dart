import 'package:daily_phones/src/repair/domain/entities/entities.dart';

double getTotal(List<CheckoutItem> items) {
  final total = items.fold<double>(0, (sum, item) => sum + item.price);
  return double.parse(total.toStringAsFixed(2));
}

String capitalizeName(String name) {
  if (name.isEmpty) return name;

  return name.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

bool isMoreThanTwoHoursAhead(DateTime providedTime) {
  final currentTime = DateTime.now();
  return providedTime.isAfter(currentTime.add(const Duration(hours: 2)));
}
