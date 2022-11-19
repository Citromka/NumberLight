import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ErrorType {
  timedOut,
  cancelled,
  clientError,
  serverError,
  other;

  String localization(AppLocalizations localizations) {
    switch(this) {
      case ErrorType.timedOut:
        return localizations.timedOutError;
      case ErrorType.cancelled:
        return localizations.cancelledError;
      case ErrorType.clientError:
        return localizations.clientError;
      case ErrorType.serverError:
        return localizations.serverError;
      case ErrorType.other:
        return localizations.other;
    }
  }
}