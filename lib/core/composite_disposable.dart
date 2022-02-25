import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

mixin CompositeDisposable<S> on Cubit<S> {
  final List<StreamSubscription<dynamic>> _subscriptions = <StreamSubscription<dynamic>>[];

  void addSubscription(StreamSubscription<dynamic> subscription) =>
      _subscriptions.add(subscription);

  @override
  Future<void> close() async {
    await Future.wait(_subscriptions.map((StreamSubscription<dynamic> e) => e.cancel()));

    return super.close();
  }
}
