import 'dart:developer';

import 'package:assignment/utils/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:assignment/utils/calender/lib/flutter_neat_and_clean_calendar.dart';
import 'package:rxdart/rxdart.dart';

class CalendarScreen {
  void getCalendar(context, {required BehaviorSubject<String> textStream}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(16),
          contentPadding: EdgeInsets.zero,
          elevation: 0,
          shadowColor: AppTheme.blackColor.withOpacity(0.4),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Calendar(
              selectedColor: Colors.blue,
              selectedTodayColor: Colors.blue,
              todayColor: Colors.blue,
              isExpanded: true,
              expandableDateFormat: 'dd MMM yyyy',
              textStream: textStream,
              displayMonthTextStyle: AppTheme.getInstance().textStyle18(),
              dayOfWeekStyle: AppTheme.getInstance().textStyle15(),
            ),
          ),
        );
      },
    );
  }
}
