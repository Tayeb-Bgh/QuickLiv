import 'package:intl/intl.dart';
import 'package:mobileapp/features/customer/research/business/entities/product_entity.dart';

class Business {
  final int id;
  final String name;
  final String imgUrl;
  final String vidUrl;
  final String type;
  final double delivPrice;
  final int delivDuration;
  final double rating;
  final bool open;
  final String description;
  final double distance;

  final List<Product> products;

  static final Map<int, int> datesMap = {
    2: 3,
    3: 4,
    4: 5,
    5: 6,
    6: 7,
    7: 1,
    1: 2,
  };

  Business({
    required this.id,
    required this.name,
    required this.description,
    required this.distance,
    required this.imgUrl,
    required this.vidUrl,
    required this.delivPrice,
    required this.delivDuration,
    required this.type,
    required this.rating,
    required this.open,
    required this.products,
  });

  static bool isOpen(int dayOff, DateTime hourOpen, DateTime hourClose) {
    final int today = datesMap[DateTime.now().weekday]!;
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat.Hm().format(now);
    final DateTime hourMinuteOnly = DateFormat("HH:mm").parse(formattedTime);

    if (dayOff == today) return false;

    return hourMinuteOnly.isBefore(hourClose) &&
        hourMinuteOnly.isAfter(hourOpen);
  }

  static String parseDelivDuration(int seconds) {
    final int totalMinutes = seconds ~/ 60;
    final int hours = totalMinutes ~/ 60;
    final int minutes = totalMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}min';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}min';
    }
  }
}
