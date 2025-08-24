import 'package:intl/intl.dart';

import '../constants/constant.dart';

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
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('d/M/yyyy h:mm a');
    return formatter.format(dateTime);
  }
}
