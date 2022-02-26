import 'package:hive/hive.dart';

mixin HiveMixin {
  Future<R> execBox<T, R>(
      {required String boxName, required Future<R> Function(Box<T>) body}) async {
    final box = await Hive.openBox<T>(boxName);
    final result = await body.call(box);
    await box.close();
    return result;
  }
}
