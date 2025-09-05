import 'package:intl/intl.dart';

import '../constants/app_constants.dart';
import '../helper/cache_helper.dart';

class FormatService {
  // truncate the text
  static String getTruncatedText({required String text, int? maxLengthToDesc}) {
    maxLengthToDesc = AppConstants.maxLengthOfContentNoteInHomeView;
    if (text.length > maxLengthToDesc) {
      return text = "${text.substring(0, maxLengthToDesc - 3)}...";
    }
    return text;
  }

  // format datetime
  static String formatDateTime(dynamic dateTime) {
    var locale = CacheHelper.getData(key: AppConstants.localeKey);
    final formatter = DateFormat('d/M/yyyy h:mm a', locale);

    if (dateTime is DateTime) {
      return formatter.format(dateTime);
    } else if (dateTime is String) {
      try {
        return formatter.format(DateTime.parse(dateTime));
      } catch (e) {
        return dateTime;
      }
    } else {
      throw ArgumentError(
          'Unsupported type for dateTime: ${dateTime.runtimeType}');
    }
  }
}
