// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/globals.dart';
import '../components/bottom_sheet.dart';
import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../main/day_selector.dart';

Future<void> showRecordsEditDialog(BuildContext context) async {
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => const RecordsEditDialog(),
  );
}

//TODO: Stateful?
class RecordsEditDialog extends StatefulWidget {
  const RecordsEditDialog();

  @override
  _RecordsEditDialogState createState() => _RecordsEditDialogState();
}

class _RecordsEditDialogState extends State<RecordsEditDialog> {
  @override
  Widget build(BuildContext context) {
    return AMBottomSheet(
      Column(
        children: [
          DaySelector(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: sidePadding, horizontal: sidePadding * 3),
            child: CupertinoTextField(
              controller: recordsEditViewState.controller,
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: const BoxDecoration(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isTablet ? 80 : 65, color: mainColor, fontWeight: FontWeight.w500),
              cursorColor: mainColor,
              placeholder: '0',
              // autofocus: true,
              prefix: Button.icon(minusOutlinedIcon(context), () => print('minus')),
              suffix: Button.icon(plusOutlinedIcon(context), () => print('plus')),
            ),
          ),
        ],
      ),
    );
  }
}
