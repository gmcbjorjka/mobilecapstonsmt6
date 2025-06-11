import 'package:get/get.dart';

import '../../../data/ikan.dart';

class IkanviewController extends GetxController {
  //TODO: Implement IkanviewController

  final RxList<MapEntry<String, Map<String, dynamic>>> ikanList =
      fishDetails.entries.toList().obs;
}
