import 'package:intl/intl.dart';

class AppFormatters {
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  static String matchDate(DateTime value) => _dateFormat.format(value);

  const AppFormatters._();
}
