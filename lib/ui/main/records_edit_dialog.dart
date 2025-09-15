// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_constants.dart';
import '../../services/globals.dart';
import '../components/bottom_sheet.dart';
import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../main/day_selector.dart';

Future showRecordsEditDialog(BuildContext context, [DateTime? date]) async {
  if (date == null) {
    recordsEditViewState.setToday();
  }
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => RecordsEditDialog(),
  );
}

class RecordsEditDialog extends StatelessWidget {
  RecordsEditDialog({super.key});

  final textStyle = TextStyle(fontSize: 65, color: mainColor, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return AMBottomSheet(
      Column(
        children: [
          const DaySelector(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppConstants.sidePadding, horizontal: AppConstants.sidePadding * 3),
            child: CupertinoTextField(
              controller: recordsEditViewState.controller,
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: const BoxDecoration(),
              textAlign: TextAlign.center,
              style: textStyle,
              cursorColor: mainColor,
              placeholder: '0',
              placeholderStyle: textStyle,
              inputFormatters: [FilteringTextInputFormatter(RegExp(r'\d'), allow: true, replacementString: '')],
              prefix: Button.icon(minusOutlinedIcon(context), recordsEditViewState.minusButtonPressed),
              suffix: Button.icon(plusOutlinedIcon(context), recordsEditViewState.plusButtonPressed),
            ),
          ),
        ],
      ),
    );
  }
}
