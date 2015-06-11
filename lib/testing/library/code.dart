library generator.testing.library.code;

import 'package:generator/testing/library/annotation.dart';

class Foo {
  @Optimize()
  void baz() {}
}

@Injectable()
class Bar {
  Bar(Foo foo);
}
