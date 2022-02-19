import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class PublishState {
  /// 发推字段
  final publish = PublishEntities.fromJson(PublishEntities.child).obs;
}
