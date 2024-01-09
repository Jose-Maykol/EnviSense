String getFormattedTime(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

String getFormattedDate(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);
  return '${dateTime.day.toString().padLeft(2, '0')} de ${_getMonth(dateTime.month)} del ${dateTime.year}';
}

String _getMonth(int month) {
  switch (month) {
    case 1:
      return 'enero';
    case 2:
      return 'febrero';
    case 3:
      return 'marzo';
    case 4:
      return 'abril';
    case 5:
      return 'mayo';
    case 6:
      return 'junio';
    case 7:
      return 'julio';
    case 8:
      return 'agosto';
    case 9:
      return 'septiembre';
    case 10:
      return 'octubre';
    case 11:
      return 'noviembre';
    case 12:
      return 'diciembre';
    default:
      return '';
  }
}