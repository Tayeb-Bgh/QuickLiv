import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class YearPickerDialog extends ConsumerStatefulWidget {
  final Function(int) onYearSelected;

  YearPickerDialog({required this.onYearSelected});

  @override
  _YearPickerDialogState createState() => _YearPickerDialogState();
}

class _YearPickerDialogState extends ConsumerState<YearPickerDialog> {
  int selectedYearIndex = 0; 

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    List<int> years = List.generate(101, (index) => currentYear - index);

    final isDarkMode = ref.watch(darkModeProvider);
    final Color backColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    final Color textColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;
    final Color txtBackColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;

    return AlertDialog(
      backgroundColor: backColor,
      title: Text(
        'Sélectionnez l\'année',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: txtBackColor,
        ),
      ),
      content: Container(
        height: 100, 
        width: 100,
        child: ListWheelScrollView.useDelegate(
          itemExtent: 40,
          diameterRatio: 2.0,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedYearIndex = index;
            });
            widget.onYearSelected(years[index]);
          },
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: years.length,
            builder: (context, index) {
              final year = years[index];
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      index ==
                              selectedYearIndex
                          ? kPrimaryRed.withOpacity(0.3)
                          : textColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  year.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        index == selectedYearIndex
                            ? kPrimaryRed
                            : txtBackColor,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK', style: TextStyle(color: kPrimaryRed)),
        ),
      ],
    );
  }
}
