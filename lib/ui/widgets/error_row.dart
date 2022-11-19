import 'package:flutter/material.dart';
import 'package:numbers_light/domain/model/base/error_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorRow extends StatelessWidget {
  final ErrorType errorType;
  final Function onRefreshPressed;

  const ErrorRow({
    Key? key,
    required this.errorType,
    required this.onRefreshPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(child: Text(errorType.localization(localizations))),
          const SizedBox(
            width: 8.0,
          ),
          ElevatedButton(
              onPressed: () {
                onRefreshPressed();
              },
              child: Text(localizations.refreshButtonLabel))
        ],
      ),
    );
  }
}
