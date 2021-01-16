import 'package:hive/hive.dart';

class BoxRepository {
  final Box repoBox;

  BoxRepository({
    this.repoBox,
  });

  void dispose<E>(Box<E> box) {
    box.close();
  }

  void disposeAll() {
    this.repoBox.close();
  }
}
