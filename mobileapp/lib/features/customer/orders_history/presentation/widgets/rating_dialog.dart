import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';

class RatingDialog extends ConsumerStatefulWidget {
  final String title;
  final double initialRating;
  final Function(double) onRatingConfirmed;

  const RatingDialog({
    super.key,
    required this.title,
    required this.initialRating,
    required this.onRatingConfirmed,
  });

  @override
  ConsumerState<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends ConsumerState<RatingDialog> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      insetPadding: EdgeInsets.symmetric(
        horizontal: width * 0.1,
        vertical: height * 0.2,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            const SizedBox(height: 20),

            RatingBar.builder(
              initialRating: _currentRating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: width * 0.1,
              unratedColor: const Color(0xFF8A8A8A),
              itemBuilder:
                  (context, index) => Icon(
                    index < _currentRating ? Icons.star : Icons.star_border,
                    color: const Color(0xFFF0F018),
                  ),
              onRatingUpdate: (newRating) {
                setState(() {
                  _currentRating = newRating;
                });
              },
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cancel Button
                _circleButton(
                  icon: Icons.close,
                  color: const Color(0xFF504E4E),
                  onPressed: () => Navigator.of(context).pop(),
                  size: width * 0.12,
                ),
                SizedBox(width: width * 0.1),

                // Confirm Button
                _circleButton(
                  icon: Icons.check,
                  color: const Color(0xFFE13838),
                  onPressed: () {
                    widget.onRatingConfirmed(_currentRating);
                    Navigator.of(context).pop();
                  },
                  size: width * 0.12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: size * 0.6),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
