import 'dart:collection';

import 'package:mockito/mockito.dart';

extension MultipleExpectations<T> on PostExpectation<T> {
  void thenAnwserInOrder(List<T> bodies) {
    final safeBody = Queue.of(bodies);

    thenAnswer((realInvocation) => safeBody.removeFirst());
  }
}