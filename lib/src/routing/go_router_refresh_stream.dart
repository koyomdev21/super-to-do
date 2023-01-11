import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(List<Stream<dynamic>> streams) {
    notifyListeners();
    _subscription = CombineLatestStream.list(streams).listen(
      (_) {
        print('changes in authState()');
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
