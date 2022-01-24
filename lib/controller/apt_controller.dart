import 'package:get/get.dart';
import 'package:realestatemanager/db/db_helper.dart';
import 'package:realestatemanager/models/apt_model.dart';
import 'package:realestatemanager/models/event_model.dart';

class AptController extends GetxController {

  var aptList = <AptDataModel>[].obs;
  var eventList = <EventModel>[].obs;
  Future<void> addApt({AptDataModel? aptDataModel}) async {
    return await DBHelper.insertApt(aptDataModel);
  }



  Future<void> getData() async {
    var result = await Future.wait([
    DBHelper.queryApt(),
    DBHelper.queryEvent()
    ]);
    List<Map<String, dynamic>> aptData = result[0];
    List<Map<String, dynamic>> eventData = result[1];
    aptList.assignAll(aptData.map((e)=> new AptDataModel.fromJson(e)).toList());
    eventList.assignAll(eventData.map((e)=> new EventModel.fromJson(e)).toList());

  }

  void deleteByAptId(int? id) {
    DBHelper.deleteByAptId(id);
    getData();
  }
}