import 'package:flutter/widgets.dart' show VoidCallback;

import 'package:flutter_hooks/flutter_hooks.dart' show useEffect;

void useMount(VoidCallback fn) {
  // ignore: body_might_complete_normally_nullable
  return useEffect(() {
    fn();
  }, const []);
}