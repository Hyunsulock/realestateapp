import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:realestatemanager/controller/apt_controller.dart';
import 'package:realestatemanager/models/apt_model.dart';
import 'package:realestatemanager/view/wiget/input_field.dart';
import 'package:uuid/uuid.dart';


class AddAptPage extends StatefulWidget {

  const AddAptPage({Key? key})
      : super(key: key);

  @override
  State<AddAptPage> createState() => _AddAptPageState();
}

class _AddAptPageState extends State<AddAptPage> {


  var uuid = Uuid();
  final TextEditingController _aptNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final AptController _aptController = Get.put(AptController());
  List<TextEditingController> _controllers = [];
  List<DateTimePicker> _fields = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2020), //시작일
      lastDate: DateTime(2022), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );
  }

  Widget _addTile() {
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
        final controller = TextEditingController(text: DateTime.now().toString());
        final field = DateTimePicker(
          controller: controller,
          type: DateTimePickerType.date,
          dateMask: 'yyyy .MM. dd',
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),

          dateLabelText: '${_controllers.length + 1}차 중도금',

        );







        setState(() {
          _controllers.add(controller);
          _fields.add(field);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          child: Row(children:[SizedBox(child: _fields[index],width: 160,), Text('helloo')]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Container(
        child: Column(
          children: [
            Text('정보 추가'),
            MyInputField(
              title: '아파트',
              hint: '아파트이름',
              controller: _aptNameController,
            ),
            MyInputField(
              title: '가격',
              hint: '가격',
              controller: _priceController,
            ),
            MyInputField(
              title: '소유자',
              hint: '소유자',
              controller: _ownerController,
            ),

            _addTile(),
            Expanded(child: _listView()),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          _addAptToDB();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Create class'),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            elevation: 0,
                            primary: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }



  void validateData() {

  }

  _addAptToDB() async {
    await _aptController.addApt(
      aptDataModel: AptDataModel(
        apt: _aptNameController.text,
        owner: _ownerController.text,
        price: int.parse(_priceController.text)
      )
    );
  }



  _addClassToDB() async {
    // final getStorage = GetStorage();
    // var table = await getStorage.read('table');
    // print("tehlo--------------------|" + table + "|----------");
    // int tableInt = int.parse(table);
    // var courseId = uuid.v1();
    // List<LecturesModel> lectures = timeList(courseId, ClassCheckList, tableInt);
    // List<Future> futures = [];
    // if (_selectedRemind != null) {
    //   //widget.notifyHelper.displayNotification(title: 'title', body: 'body');
    //   futures.addAll(lectures.map((e) => widget.notifyHelper
    //       .scheduleWeeklyNotification(
    //       e.date!,
    //       int.parse(classTime[e.start!][0].split(':')[0]),
    //       int.parse(classTime[e.start!][0].split(':')[1]),
    //       e.course_id!,
    //       _aptController.text,
    //       _priceController.text)));
    // }
    //
    // futures.add(_classController.addClass(
    //     courseModel: CourseModel(
    //         id: courseId,
    //         title: _aptController.text,
    //         room: _priceController.text,
    //         prof: _ownerController.text,
    //         remind: _selectedRemind,
    //         color: _shadeColor!.value,
    //         table_id: tableInt
    //       // classCheckList: ClassCheckList
    //     )));
    // futures.addAll(lectures
    //     .map((data) => _classController.addLectures(lecturesModel: data)));
    // await Future.wait(futures);
  }



  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
    );
  }
}