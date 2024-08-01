import 'dart:async';

class Debounce {
  final int milliseconds;
  Debounce({this.milliseconds = 500});
  Timer? timer;
  void run(void Function() action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
